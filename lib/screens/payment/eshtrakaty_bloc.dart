import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/ticket.dart';
import 'package:al_murafiq/models/eshtrakaty.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/subjects.dart';

class EshtrakatyBloc {
  dioo.Dio _dio = GetIt.instance.get<dioo.Dio>();

  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  RoundedLoadingButtonController loadingButtonController =
  RoundedLoadingButtonController();


  final dataofAllSubscriptionsSubject = BehaviorSubject<Eshtrakaty>();

  Future<void> fetchAllSubscriptions({int company_id,int typeAdsOrPlan}) async {

    String token = await _helper.getToken();
    String lang = await _helper.getCodeLang();
    int countryID = await _helper.getCountryId();

    try {

      dioo.Response res = await _dio.get(
        '/companies/subscriptions?country_id=$countryID&id=$company_id&type=$typeAdsOrPlan',
        options: dioo.Options(
          headers: {"Authorization": "Bearer $token", 'lang': '$lang'},
        ),

      );
      print('test ${res.data}');
      if (res.statusCode == 200 && res.data['status']==200) {

        dataofAllSubscriptionsSubject.sink.add(Eshtrakaty.fromJson(res.data['data']));

        // Get.snackbar(null, "aa",
        //     snackPosition: SnackPosition.BOTTOM);
      } else {
        dataofAllSubscriptionsSubject.addError('');
      }
    } catch (e) {
      dataofAllSubscriptionsSubject.addError('');

    }
  }


}
