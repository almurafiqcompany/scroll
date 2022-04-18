import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/subjects.dart';

class SendToContactBloc {
  final dioo.Dio _dio = GetIt.instance.get<dioo.Dio>();

  final SharedPreferenceHelper _helper =
      GetIt.instance.get<SharedPreferenceHelper>();
  TextEditingController detailsController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  RoundedLoadingButtonController loadingButtonController =
      RoundedLoadingButtonController();

  final BehaviorSubject<bool> detailSubject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> subjectSubject = BehaviorSubject<bool>();
  changeDetail(String val) =>
      detailSubject.sink.add(validateText(detailsController));

  changesubject(String val) =>
      subjectSubject.sink.add(validateText(subjectController));
  validateText(TextEditingController controller) {
    return controller.text.isNotEmpty;
  }

  Future<void> addSendToContact(BuildContext context) async {
    if (validateText(detailsController) && validateText(subjectController)) {
      String? token = await _helper.getToken();
      String lang = await _helper.getCodeLang();
      int? countryID = await _helper.getCountryId();
      final dioo.FormData formData = dioo.FormData.fromMap({
        'subject': subjectController.text,
        'message': detailsController.text,
      });
      try {
        dioo.Response res = await _dio.post(
          '/contact-us?country_id=$countryID',
          options: dioo.Options(
            headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
          ),
          data: formData,
        );

        if (res.statusCode == 200 && res.data['status'] == 200) {
          Get.back();
          await showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return ShowMessageDialog(
                type: 200,
                message: '${res.data['message']}',
                show_but: true,
              );
            },
          );
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
        } else {
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
      detailSubject.sink.add(validateText(detailsController));
      subjectSubject.sink.add(validateText(subjectController));
    }
  }

  // ignore: always_declare_return_types
  dispose() async {
    await subjectSubject.stream.drain();
    await subjectSubject.close();
    await detailSubject.stream.drain();
    await detailSubject.close();
  }
}
