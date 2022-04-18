import 'dart:async';

import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/screens/login/login_screen.dart';
import 'package:al_murafiq/screens/splash2/splash2.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/subjects.dart';

class changePassBloc {
  Dio _dio = GetIt.instance.get<Dio>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmePasswordController = TextEditingController();

  RoundedLoadingButtonController loadingButtonController =
      RoundedLoadingButtonController();

  final BehaviorSubject<bool> emailOrPhoneSubject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> passwordSubject =
      BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<bool> obscurePasswordSubject =
      BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<bool> confirmePasswordSubject =
      BehaviorSubject<bool>.seeded(true);

  final BehaviorSubject<bool> obscureConfirmePasswordSubject =
      BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<String> sendEmailSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> codeSubject = BehaviorSubject<String>();

  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();

  changePassword(String val) =>
      passwordSubject.sink.add(validatePassword(passwordController));
  changeConfirmePassword(String val) => confirmePasswordSubject.sink
      .add(validatePassword(confirmePasswordController));

  validatePassword(TextEditingController controller) {
    return controller.text.length >= 8;
  }

  Future<void> updatePass(BuildContext context) async {
    if (validatePassword(passwordController) &&
        validatePassword(confirmePasswordController)) {
      if (passwordController.text == confirmePasswordController.text) {
        var bodyData = {
          'email': sendEmailSubject.value,
          'code': codeSubject.value,
          'password': passwordController.text,
          'password_confirmation': confirmePasswordController.text,
        };

        try {
          String lang = await _helper.getCodeLang();
          int? countryID = await _helper.getCountryId();
          final res = await _dio.post(
            '/reset-password/update-password?country_id=$countryID',
            options: Options(
              headers: {'lang': '$lang'},
            ),
            data: bodyData,
          );
          if (res.statusCode == 200 && res.data['status'] == 200) {
            // Get.snackbar(null, 'Success',
            //     snackPosition: SnackPosition.BOTTOM);
            await showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 350,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: Container(
                                width: 100,
                                height: 100,
                                color: Colors.white,
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/checkDone.png',
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'تم تغير رقمك السري',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'بنجاح',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff2E5BFF),
                                padding: EdgeInsets.symmetric(
                                    horizontal: (Get.width / 2) - 50,
                                    vertical: 10),
                                textStyle: TextStyle(
                                  fontSize: 14,
                                )),
                            child: const Text('تم'),
                            onPressed: () async =>
                                await Get.offAll(LoginScreen()),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (res.data['status'] == 500) {
            // Get.snackbar(null, '${res.data['message']}',
            //   icon: GestureDetector(
            //       onTap: ()=> Get.back(),
            //       child: Icon(Icons.close,color: Colors.black,)),
            //   colorText: Colors.black,backgroundColor: Colors.red.withOpacity(0.8),
            //
            //   duration: Duration(seconds: 60),
            //   snackPosition: SnackPosition.BOTTOM,);
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
          // ignore: avoid_catches_without_on_clauses
          // Get.snackbar(null, '${e}',
          //   icon: GestureDetector(
          //       onTap: ()=> Get.back(),
          //       child: Icon(Icons.close,color: Colors.black,)),
          //   colorText: Colors.black,backgroundColor: Colors.red.withOpacity(0.8),
          //
          //   duration: Duration(seconds: 60),
          //   snackPosition: SnackPosition.BOTTOM,);
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
        await showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return ShowMessageDialog(
              type: 400,
              message: 'text_pass_not_similer'.tr,
              show_but: true,
            );
          },
        );
      }
    } else {
      passwordSubject.sink.add(validatePassword(passwordController));
      confirmePasswordSubject.sink
          .add(validatePassword(confirmePasswordController));
    }

    dispose() async {
      await confirmePasswordSubject.stream.drain();
      await confirmePasswordSubject.close();
      await passwordSubject.stream.drain();
      await passwordSubject.close();
      await obscurePasswordSubject.stream.drain();
      await obscurePasswordSubject.close();
      confirmePasswordController.dispose();
      passwordController.dispose();
    }
  }
}
