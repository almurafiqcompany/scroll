import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/ticket.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/subjects.dart';

class AddTicketBloc {
  dioo.Dio _dio = GetIt.instance.get<dioo.Dio>();

  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  TextEditingController detailsController = TextEditingController();
  TextEditingController subjectController = new TextEditingController();
  RoundedLoadingButtonController loadingButtonController =
  RoundedLoadingButtonController();

  final detailSubject = BehaviorSubject<bool>();
  final subjectSubject = BehaviorSubject<bool>();
  changeDetail(String val) =>
      detailSubject.sink.add(validateText(detailsController));

  changesubject(String val) =>
      subjectSubject.sink.add(validateText(subjectController));
  validateText(TextEditingController controller) {
    return controller.text.isNotEmpty;
  }

  Future<void> addTicketPost(BuildContext context) async {

    if (validateText(detailsController) && validateText(subjectController)) {
      String token = await _helper.getToken();
      String lang = await _helper.getCodeLang();
      int countryID = await _helper.getCountryId();
      final dioo.FormData formData = dioo.FormData.fromMap({
        'subject': subjectController.text,
        'details': detailsController.text,

      });
      try {

        dioo.Response res = await _dio.post(
          '/tickets/store?country_id=$countryID',
          options: dioo.Options(
            headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
          ),
          data:formData,
        );

        if (res.statusCode == 200 && res.data['status']==200) {

          TicketData ticketOfUser = TicketData.fromJson(res.data['data']);
          Get.back(result: ticketOfUser);

          await showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return ShowMessageDialog(type: 200,message: '${res.data['message']}',show_but: true,);
            },
          );
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
        // Get.snackbar(null, 'حدث خطأ ما. حاول مرة أخري ',
        //     snackPosition: SnackPosition.BOTTOM);
        await showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return ShowMessageDialog(type: 400,message: 'e'.tr,show_but: true,);
          },
        );
      }
    } else {
      detailSubject.sink.add(validateText(detailsController));
      subjectSubject.sink.add(validateText(subjectController));
    }
  }

  final dataofAllTicketSubject = BehaviorSubject<Tickets>();

  final dataofTicketsofuserSubject = BehaviorSubject<List<TicketData>>();

  Future<void> fetchAllTickets() async {

    String token = await _helper.getToken();
    String lang = await _helper.getCodeLang();
    int countryID = await _helper.getCountryId();

    try {

      dioo.Response res = await _dio.get(
        '/tickets?country_id=$countryID',
        options: dioo.Options(
          headers: {"Authorization": "Bearer $token", 'lang': '$lang'},
        ),

      );

      if (res.statusCode == 200 && res.data['status']==200) {

        dataofAllTicketSubject.sink.add(Tickets.fromJson(res.data['data']));
        dataofTicketsofuserSubject.sink.add(Tickets.fromJson(res.data['data']).data);

        // Get.back(result: ticketData);
        // Get.snackbar(null, "aa",
        //     snackPosition: SnackPosition.BOTTOM);
      }else if(res.data['status']==400) {
        dataofAllTicketSubject.sink.addError(res.data['message']);
      }
      else {
        dataofAllTicketSubject.sink.addError('');
      }
    } catch (e) {
      dataofAllTicketSubject.sink.addError('');

    }
  }

  dispose() async {
    await subjectSubject.stream.drain();
    subjectSubject.close();
    await detailSubject.stream.drain();
    detailSubject.close();
  }
}
