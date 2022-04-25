import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/special_ads.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class SpecialAdsBloc {
  Dio _dio = GetIt.instance.get<Dio>();
  final dataOfSpecialAdsSubject = BehaviorSubject<Special_Ads_Data>();
  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  Future<void> fetchSpecialAds() async {
    try {
      String? token = await _helper.getToken();
      String? lang = await _helper.getCodeLang();
      int? countryID = await _helper.getCountryId();
      double? lat = await _helper.getLat();
      double? lng = await _helper.getLng();

      final Response res = await _dio.get(
        '/special-ads?country_id=$countryID&lat=$lat&lng=$lng',
        options: Options(
          headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
        ),
      );

      if (res.statusCode == 200 && res.data['status'] == 200) {
        dataOfSpecialAdsSubject.sink
            .add(Special_Ads_Data.fromJson(res.data['data']));

      } else if (res.data['status'] == 400) {

        dataOfSpecialAdsSubject.sink.addError(res.data['message']);
      } else {
        dataOfSpecialAdsSubject.sink.addError('');
      }
    } catch (e) {
      dataOfSpecialAdsSubject.sink.addError('');
    }
  }

  dispose() async {
    await dataOfSpecialAdsSubject.stream.drain();
    dataOfSpecialAdsSubject.close();
  }
}
