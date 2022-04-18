import 'dart:async';

import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/screens/forgot_password_verification_code/forgot_password_verification_code.dart';
import 'package:al_murafiq/screens/splash2/splash2.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/subjects.dart';

class ForgetPasswordBloc {
  Dio _dio = GetIt.instance.get<Dio>();
  TextEditingController emailOrPhoneController = TextEditingController();

  RoundedLoadingButtonController loadingButtonController =
      RoundedLoadingButtonController();

  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();

  final BehaviorSubject<bool> emailOrPhoneSubject = BehaviorSubject<bool>();

  changeEmailOrPhone(String val) => emailOrPhoneSubject.sink
      .add(validateEmailOrPhone(emailOrPhoneController));

  bool validateEmailOrPhone(TextEditingController controller) {
    // ignore: unnecessary_parenthesis
    return (emailExp.hasMatch(controller.text) ||
        phoneExp.hasMatch(controller.text));
  }

  Future<void> sendEmail(BuildContext context) async {
    if (validateEmailOrPhone(emailOrPhoneController)) {
      var bodyData = {
        'email': emailOrPhoneController.text,
      };
      try {
        String lang = await _helper.getCodeLang();
        int? countryID = await _helper.getCountryId();
        final res = await _dio.post(
          '/reset-password/send-mail?country_id=$countryID',
          options: Options(
            headers: {'lang': '$lang'},
          ),
          data: bodyData,
        );
        if (res.statusCode == 200 && res.data['status'] == 200) {
          await Get.to(ForgotPasswordVerificationCode(
            email: emailOrPhoneController.text,
          ));
        } else if (res.data['status'] == 500) {
          await showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return ShowMessageDialog(
                type: 400,
                message: '${res.data['message']}',
                show_but: true,
              );
            },
          );
        }
        // ignore: avoid_catches_without_on_clauses
      } catch (e) {
        await showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return ShowMessageDialog(
              type: 400,
              message: 'e'.tr,
              show_but: true,
            );
          },
        );
      }
    } else {
      emailOrPhoneSubject.sink
          .add(validateEmailOrPhone(emailOrPhoneController));
    }

    dispose() async {
      await emailOrPhoneSubject.stream.drain();
      await emailOrPhoneSubject.close();

      emailOrPhoneController.dispose();
    }
  }
}
