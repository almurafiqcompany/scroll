import 'package:al_murafiq/models/about_us.dart';
import 'package:al_murafiq/models/favorate.dart';
import 'package:al_murafiq/models/policy.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';

class PolicyBloc {
  Dio _dio = GetIt.instance.get<Dio>();
  final dataOfPolicySubject = BehaviorSubject<Policy>();
  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  Future<void> fetchPolicy() async {
    try {
      String? token = await _helper.getToken();
      String? lang = await _helper.getCodeLang();
      int? countryID = await _helper.getCountryId();
      final Response res = await _dio.get(
        '/policies/?country_id=$countryID',
        options: Options(
          headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
        ),
      );

      if (res.statusCode == 200 && res.data['status'] == 200) {
        dataOfPolicySubject.sink.add(Policy.fromJson(res.data['data']));
      } else if (res.data['status'] == 400) {
        dataOfPolicySubject.sink.addError(res.data['message']);
      } else {
        dataOfPolicySubject.sink.addError('');
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      dataOfPolicySubject.sink.addError('');
    }
  }

  dispose() async {
    await dataOfPolicySubject.stream.drain();
    await dataOfPolicySubject.close();
  }
}
