import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/search_store.dart';
import 'package:al_murafiq/models/socials.dart';
import 'package:al_murafiq/widgets/show_loading_alert.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/subjects.dart';

class SocialsBloc {
  dioo.Dio _dio = GetIt.instance.get<dioo.Dio>();

  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  RoundedLoadingButtonController loadingButtonController =
  RoundedLoadingButtonController();


  final dataofSocialsOfCompanySubject = BehaviorSubject<SocialsOfComapny>();
  final dataListSocialsOfCompanySubject = BehaviorSubject<List<SocialData>>();

  Future<void> fetchAllSocialsOfCompany(int company_id) async {

    String? token = await _helper.getToken();
    String? lang = await _helper.getCodeLang();
    int? countryID = await _helper.getCountryId();

    try {

      dioo.Response res = await _dio.get(
        '/socials?id=$company_id&country_id=$countryID',
        options: dioo.Options(
          headers: {"Authorization": "Bearer $token", 'lang': '$lang'},
        ),

      );

      if (res.statusCode == 200 && res.data['status']==200) {
        dataofSocialsOfCompanySubject.sink.add(SocialsOfComapny.fromJson(res.data['data']));
        dataListSocialsOfCompanySubject.sink.add(SocialsOfComapny.fromJson(res.data['data']).socialData!);

      }else if(res.data['status']==400){
        dataofSocialsOfCompanySubject.sink.addError(res.data['message']);
      }
      else {
        dataofSocialsOfCompanySubject.sink.addError('');
      }
    } catch (e) {
      dataofSocialsOfCompanySubject.sink.addError('');

    }
  }
  Future<void> socialsDestroy({int? social_id,int? company_id,BuildContext? context}) async {
    try {
      showAlertDialog(context!);
      String? token = await _helper.getToken();
      String lang = await _helper.getCodeLang();
      int? countryID = await _helper.getCountryId();
      final res = await _dio.delete(
        '/socials/destroy?id=$company_id&social_id=$social_id&country_id=$countryID',
        options: dioo.Options(
          headers: {'Authorization': 'Bearer $token',
            'lang': '$lang'
          },
        ),
      );

      Get.back();
      if (res.statusCode == 200 && res.data['status'] == 200) {

        dataListSocialsOfCompanySubject.sink.add(
            dataListSocialsOfCompanySubject.value..removeWhere((ele) => ele.id == social_id));
        await showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return ShowMessageDialog(type: 200,message: '${res.data['message']}',show_but: true,);
          },
        );
      } else if (res.data['status'] == 500) {

        await showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return ShowMessageDialog(type: 400,message: '${res.data['message']}',show_but: true,);
          },
        );
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {

    Get.back();
      await showModalBottomSheet<void>(
        context: context!,
        builder: (BuildContext context) {
          return ShowMessageDialog(type: 400,message: 'e'.tr,show_but: true,);
        },
      );
    }
  }
  dispose() async {
    await dataofSocialsOfCompanySubject.stream.drain();
    await dataofSocialsOfCompanySubject.close();
  }
}
