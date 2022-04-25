import 'package:al_murafiq/models/about_us.dart';
import 'package:al_murafiq/models/favorate.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';

class AboutUSBloc {
  Dio _dio = GetIt.instance.get<Dio>();
  final dataOfAboutUSSubject = BehaviorSubject<AboutUs>();
  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  Future<void> fetchAboutUS() async {
    try {
      String? token = await _helper.getToken();
      String lang = await _helper.getCodeLang();
      int? countryID = await _helper.getCountryId();
      final Response res = await _dio.get(
        '/about-us/?country_id=$countryID',
        options: Options(
          headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
        ),
      );

      if (res.statusCode == 200 && res.data['status'] == 200) {
        dataOfAboutUSSubject.sink.add(AboutUs.fromJson(res.data['data']));
      } else if (res.data['status'] == 400) {
        dataOfAboutUSSubject.sink.addError(res.data['message']);
      } else {
        dataOfAboutUSSubject.sink.addError('');
      }
    } catch (e) {
      dataOfAboutUSSubject.sink.addError('');
    }
  }

  dispose() async {
    await dataOfAboutUSSubject.stream.drain();
    dataOfAboutUSSubject.close();
  }
}
