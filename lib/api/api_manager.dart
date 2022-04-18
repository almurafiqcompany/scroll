import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class MyClient extends http.BaseClient {
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    print('Api request: method=>${request.method}, url=>${request.url}');

    request.headers
        .addAll(<String, String>{'Content-Type': 'application/json'});

    return request.send();
  }
}

class ApiManager {
  final MyClient _client = MyClient();

  final Map<String, http.Response> _httpGETCaching =
      HashMap<String, http.Response>();

  Map<String, String> headersWithBearerToken(String token) => <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

  Future<dynamic> get(
    String? url, {
    Map<String, String>? headers,
  }) async {
    try {
      return _response(await _client.get(Uri.parse(url!)));
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<dynamic> getWithCache(String url,
      {Map<String, String>? headers}) async {
    try {
      http.Response? response;
      if (!_httpGETCaching.containsKey(url)) {
        response = await _client.get(Uri.parse(url));
        if (response.statusCode == 200) {
          _httpGETCaching[url] = response;
        }
      } else {
        response = _httpGETCaching[Uri.parse(url)];
      }

      return _response(response!);
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<dynamic> post(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    Encoding? encoding,
  }) async {
    try {
      return _response(await _client.post(Uri.parse(url),
          headers: headers, body: body, encoding: encoding));
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  dynamic _response(http.Response response) {
    if (json.decode(response.body)['status'] != 200) {
      throw Exception(
          '${json.decode(response.body)['message']}-${json.decode(response.body)['status']}');
    }
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
        break;

      case 401:
        throw Exception('Error : Your Token Is Experd-${response.statusCode}');
        break;
      default:
        throw Exception(
            '${json.decode(response.body)['message']}-${json.decode(response.body)['status']}');
    }
  }
}

class ResponseApi<T> {
  ResponseApi.success(this.data) : status = ApiStatus.SUCCESS;

  ResponseApi.error(this.error) : status = ApiStatus.ERROR;
  T? data;

  String? error;

  ApiStatus? status;

  @override
  String toString() {
    return 'Status : $status \n Error : $error \n Data : $data';
  }
}

enum ApiStatus { SUCCESS, ERROR }
