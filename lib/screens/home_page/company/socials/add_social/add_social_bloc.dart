import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/socials.dart';
import 'package:al_murafiq/models/ticket.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/subjects.dart';
class SocialItem {
  final String? name;
  final IconData? icon;

  SocialItem({this.name, this.icon});
}
class AddSocialBloc {
  dioo.Dio _dio = GetIt.instance.get<dioo.Dio>();

  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();

  TextEditingController linkController = new TextEditingController();
  RoundedLoadingButtonController loadingButtonController =
  RoundedLoadingButtonController();


  final linkSubject = BehaviorSubject<bool>();


  changeLink(String val) =>
      linkSubject.sink.add(validateLink(linkController));

  validateLink(TextEditingController controller) {
    print('value ${controller.text.isNotEmpty}');
    // return urlExp.hasMatch(controller.text);
    return controller.text.isNotEmpty;
  }

  List<SocialItem> socialItems = [
    SocialItem(name: 'facebook'.tr, icon: MdiIcons.facebook),
    SocialItem(name: 'twitter'.tr, icon: MdiIcons.twitter),
    SocialItem(name: 'instagram'.tr, icon: MdiIcons.instagram),
    SocialItem(name: 'whatsapp'.tr, icon: MdiIcons.whatsapp),
    SocialItem(name: 'snapshat'.tr, icon: MdiIcons.snapchat),
    SocialItem(name: 'googleplus'.tr, icon: MdiIcons.googlePlus),
    SocialItem(name: 'website'.tr, icon: MdiIcons.web),
    SocialItem(name: 'other'.tr, icon: MdiIcons.ellipse),
  ];
  final typeSocialSubject = BehaviorSubject<String>();
  Future<void> addSocial(int id,BuildContext context) async {
    if (typeSocialSubject.value == null) {

      await showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return ShowMessageDialog(type: 400,message: 'select social',show_but: true,);
        },
      );
      return ;
    }
    if ( validateLink(linkController)) {
      String? token = await _helper.getToken();
      String? lang = await _helper.getCodeLang();
      int? countryID = await _helper.getCountryId();
      final dioo.FormData formData = dioo.FormData.fromMap({
        'link': linkController.text,
        'icon_type': typeSocialSubject.value,
        'id': id,

      });
      try {
        dioo.Response res = await _dio.post(
          '/socials/store?country_id=$countryID',
          options: dioo.Options(
            headers: {"Authorization": "Bearer $token", 'lang': '$lang'},
          ),
          data:formData,
        );

        if (res.statusCode == 200&&res.data['status'] == 200) {
          SocialData socialOfCompany = SocialData.fromJson(res.data['data']);

          Get.back(result: socialOfCompany);

          await showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return ShowMessageDialog(type: 200,message: '${res.data['message']}',show_but: true,);
            },
          );
          // await Get.back();
        } else if (res.data['status'] == 400) {

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

      linkSubject.sink.add(validateLink(linkController));
    }
  }

  final dataofAllTicketSubject = BehaviorSubject<Tickets>();

  final dataofTicketsofuserSubject = BehaviorSubject<List<TicketData>>();

  Future<void> fetchAllTickets() async {

    String? token = await _helper.getToken();
    String? lang = await _helper.getCodeLang();
    int? countryID = await _helper.getCountryId();

    try {

      dioo.Response res = await _dio.get(
        '/tickets?country_id=$countryID',
        options: dioo.Options(
          headers: {"Authorization": "Bearer $token", 'lang': '$lang'},
        ),

      );

      if (res.statusCode == 200 && res.data['status']==200) {

        dataofAllTicketSubject.sink.add(Tickets.fromJson(res.data['data']));
        dataofTicketsofuserSubject.sink.add(dataofAllTicketSubject.value.data!);

        // Get.back(result: ticketData);
        // Get.snackbar(null, "aa",
        //     snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('null', '${res.data['message']}',
            snackPosition: SnackPosition.BOTTOM);
      }
    // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      Get.snackbar('null', '${e}',
          snackPosition: SnackPosition.BOTTOM);

    }
  }

  dispose() async {
    await linkSubject.stream.drain();
    linkSubject.close();

  }
}
