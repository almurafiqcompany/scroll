import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/ticket.dart';
import 'package:al_murafiq/models/ticket_replay.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/subjects.dart';

class TicketSupportReplayBloc {
  dioo.Dio _dio = GetIt.instance.get<dioo.Dio>();

  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  TextEditingController sendReplayController = TextEditingController();
  RoundedLoadingButtonController loadingButtonController =
  RoundedLoadingButtonController();

  final sendReplaySubject = BehaviorSubject<bool>();
  changeDetail(String val) =>
      sendReplaySubject.sink.add(validateText(sendReplayController));


  validateText(TextEditingController controller) {
    return controller.text.isNotEmpty;
  }

  Future<void> addsendReplay({int ticket_id,BuildContext context}) async {

    if (validateText(sendReplayController) ) {
      String token = await _helper.getToken();
      String lang = await _helper.getCodeLang();
      int countryID = await _helper.getCountryId();
      final dioo.FormData formData = dioo.FormData.fromMap({
        'reply': sendReplayController.text,
        'ticket_id': '$ticket_id',

      });
      try {
        dioo.Response res = await _dio.post(
          '/tickets/reply?country_id=$countryID',
          options: dioo.Options(
            headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
          ),
          data:formData,
        );

        if (res.statusCode == 200) {
          // TicketData ticketData = TicketData.fromJson(res.data['data']['data']);
          //print('model $ticketData');
          // Get.back(result: ticketData);


           await showModalBottomSheet<void>(
             context: context,
             builder: (BuildContext context) {
               return ShowMessageDialog(type: 200,message: '${res.data['message']}',show_but: true,);
             },
           );
           Get.back();
        } else {

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
          // ignore: avoid_catches_without_on_clauses
          context: context,
          builder: (BuildContext context) {
            return ShowMessageDialog(type: 400,message: 'e'.tr,show_but: true,);
          },
        );

      }
    } else {
      sendReplaySubject.sink.add(validateText(sendReplayController));
    }
  }

  final dataofAllTicketSupportReplaySubject = BehaviorSubject<TicketsSupportReplay>();

  Future<void> fetchAllTicketsSupportReplay({int ticket_id}) async {

    String token = await _helper.getToken();
    String lang = await _helper.getCodeLang();
    int countryID = await _helper.getCountryId();

    try {

      dioo.Response res = await _dio.get(
        '/tickets/show?country_id=$countryID&ticket_id=$ticket_id',
        options: dioo.Options(
          headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
        ),

      );

      if (res.statusCode == 200 && res.data['status']==200) {
        dataofAllTicketSupportReplaySubject.sink.add(TicketsSupportReplay.fromJson(res.data['data']));
        // Get.snackbar(null, "aa",
        //     snackPosition: SnackPosition.BOTTOM);
      } else {
        dataofAllTicketSupportReplaySubject.addError('');
      }
    } catch (e) {
      dataofAllTicketSupportReplaySubject.addError('');

    }
  }

  dispose() async {
    await sendReplaySubject.stream.drain();
    sendReplaySubject.close();
    await sendReplaySubject.stream.drain();
    sendReplaySubject.close();
  }
}
