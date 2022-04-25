import 'dart:async';

import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/screens/change_password/change_password.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/subjects.dart';

class ForgetPasswordVerificationBloc {
  Dio _dio = GetIt.instance.get<Dio>();
  TextEditingController verifiedCodeController = TextEditingController();

  RoundedLoadingButtonController loadingButtonController =
      RoundedLoadingButtonController();

  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();

  final BehaviorSubject<bool> verifiedCodeSubject = BehaviorSubject<bool>();
  final BehaviorSubject<String> sendEmailSubject = BehaviorSubject<String>();

  changeverifiedCode(String val) => verifiedCodeSubject.sink
      .add(validateverifiedCode(verifiedCodeController));

  bool validateverifiedCode(TextEditingController controller) {
    return (phoneExp.hasMatch(controller.text) || controller.text.length >= 6);
  }

  Future<void> sendCode(BuildContext context) async {
    if (validateverifiedCode(verifiedCodeController)) {
      var bodyData = {
        "code": verifiedCodeController.text,
        "email": sendEmailSubject.value,
      };

      try {
        String lang = await _helper.getCodeLang();
        int? countryID = await _helper.getCountryId();
        final res = await _dio.post(
          '/reset-password/check-code?country_id=$countryID',
          options: Options(
            headers: {"lang": "$lang"},
          ),
          data: bodyData,
        );

        if (res.statusCode == 200 && res.data['status'] == 200) {
          await Get.to(ChangePassword(
            email: sendEmailSubject.value,
            code: verifiedCodeController.text,
          ));
        } else if (res.data['status'] == 400) {
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
      verifiedCodeSubject.sink
          .add(validateverifiedCode(verifiedCodeController));
    }

    dispose() async {
      await verifiedCodeSubject.stream.drain();
      await verifiedCodeSubject.close();

      verifiedCodeController.dispose();
    }
  }
}
