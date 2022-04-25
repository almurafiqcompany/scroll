import 'dart:async';

import 'package:al_murafiq/components/firebase_notifications.dart';
import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/screens/home_page/nav_bar.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:dio/dio.dart';
import 'package:al_murafiq/screens/payment/payment_plans/pay_plans_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/subjects.dart';

class LoginBloc {
  Dio _dio = GetIt.instance.get<Dio>();
  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();

  TextEditingController emailOrPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RoundedLoadingButtonController loadingButtonController =
      RoundedLoadingButtonController();

  final BehaviorSubject<bool> emailOrPhoneSubject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> passwordSubject =
      BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<bool> obscurePasswordSubject =
      BehaviorSubject<bool>.seeded(true);

  void changeEmailOrPhone(String val) => emailOrPhoneSubject.sink
      .add(validateEmailOrPhone(emailOrPhoneController));

  changePassword(String val) =>
      passwordSubject.sink.add(validatePassword(passwordController));

  bool validateEmailOrPhone(TextEditingController controller) {
    // ignore: unnecessary_parenthesis
    return (emailExp.hasMatch(controller.text) ||
        phoneExp.hasMatch(controller.text));
  }

  validatePassword(TextEditingController controller) {
    return controller.text.length >= 8;
  }

  Future<void> confirmLogin(BuildContext context) async {
    if (validateEmailOrPhone(emailOrPhoneController) &&
        validatePassword(passwordController)) {
      var bodyData = {
        "email": emailOrPhoneController.text,
        "password": passwordController.text,
      };
      if (await FirebaseNotifications().generateFcmToken()!=null) {
        bodyData['fcm_token'] = await FirebaseNotifications().generateFcmToken();
      }

      try {
        String lang = await _helper.getCodeLang();
        int? countryID = await _helper.getCountryId();
        final res = await _dio.post(
          '/login?country_id=$countryID',
          options: Options(
            headers: {'lang': '$lang'},
          ),
          data: bodyData,
        );

        if (res.statusCode == 200 && res.data['status'] == 200) {
          await _helper.setEmail(emailOrPhoneController.text);
          await _helper.setToken(res.data['data']['token']);
          await _helper.setType(res.data['data']['type']);
          await _helper.setName(res.data['data']['name']);
          await _helper.setCode(res.data['data']['code']);
          await _helper.setMarketer(res.data['data']['marketer_id']);
          await _helper.setAvatar(res.data['data']['avatar']);
          await _helper.setActive(res.data['data']['active']);
          await _helper.setActivationMessage(res.data['data']['activation_message']);

          // await _helper.setFirst(res.data['data']['first']);
          // if (res.data['data']['first'] == 1 && res.data['data']['type'] == 'Company') {
          //   await Get.to(PayPlansScreen(company_id: res.data['data']['company_id'],typeAdsOrPlan: 0,));
          //
          // }else{
          //   print('done');
          //   await Get.offAll(BottomNavBar());
          // }
          await Get.offAll(BottomNavBar());
        } else if (res.data['status'] == 500) {

          await showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return ShowMessageDialog(type: 400,message: '${res.data['message']}',show_but: true,);
            },
          );
        } else if (res.data['status'] == 400) {

          await showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return ShowMessageDialog(type: 400,message: '${res.data['message']}',show_but: true,);
            },
          );
        }else if (res.data['status'] == 300) {
          await showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return ShowMessageDialog(type: 400,message: '${res.data['message']}',show_but: true,);
            },
          );
        }
      // ignore: avoid_catches_without_on_clauses
      } catch (e) {

        await showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return ShowMessageDialog(type: 400,message: 'e'.tr,show_but: true,);
          },
        );
      }
    } else {
      emailOrPhoneSubject.sink
          .add(validateEmailOrPhone(emailOrPhoneController));
      passwordSubject.sink.add(validatePassword(passwordController));
    }

    dispose() async {
      await emailOrPhoneSubject.stream.drain();
      await emailOrPhoneSubject.close();
      await passwordSubject.stream.drain();
      await passwordSubject.close();
      await obscurePasswordSubject.stream.drain();
      await obscurePasswordSubject.close();
      emailOrPhoneController.dispose();
      passwordController.dispose();
    }
  }
}
