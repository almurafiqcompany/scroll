import 'package:al_murafiq/models/about_us.dart';
import 'package:al_murafiq/models/favorate.dart';
import 'package:al_murafiq/models/policy.dart';
import 'package:al_murafiq/models/side_menu.dart';
import 'package:al_murafiq/models/total_cliets.dart';
import 'package:al_murafiq/screens/home_page/nav_bar.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/rxdart.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';

class SideMenuBloc {
  Dio _dio = GetIt.instance.get<Dio>();
  final dataOfSideMenuSubject = BehaviorSubject<Settings>();
  final dataOfTotalClientsSubject = BehaviorSubject<TotalClents>();
  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();

  Future<void> fetchSideMenu() async {
    try {
      String? token = await _helper.getToken();
      String? lang = await _helper.getCodeLang();
      String? code = await _helper.getCode();
      int? countryID = await _helper.getCountryId();
      final res = await _dio.get(
        '/setting?country_id=$countryID&user_id=$code',
        options: Options(
          headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
        ),
      );

      print('sitting ${res.data}');
      if (res.statusCode == 200 && res.data['status'] == 200) {
        dataOfSideMenuSubject.sink.add(Settings.fromJson(res.data['data']));
        await _helper.setActive(res.data['data']['active']);
        await _helper
            .setActivationMessage(res.data['data']['activation_message']);
        await _helper.setShareMessage(res.data['data']['share_message']);
      } else if (res.data['status'] == 400) {
        dataOfSideMenuSubject.sink.addError(res.data['message']);
      } else {
        dataOfSideMenuSubject.sink.addError('');
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      dataOfSideMenuSubject.sink.addError('');
    }
  }

  Future<void> fetchTotalClients() async {
    try {
      String? token = await _helper.getToken();
      String lang = await _helper.getCodeLang();
      int? countryID = await _helper.getCountryId();
      final res = await _dio.get(
        '/marketers/clients?country_id=$countryID',
        options: Options(
          headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
        ),
      );
      if (res.statusCode == 200 && res.data['status'] == 200) {
        dataOfTotalClientsSubject.sink
            .add(TotalClents.fromJson(res.data['data']));
      } else if (res.data['status'] == 400) {
        dataOfSideMenuSubject.sink.addError(res.data['message']);
      } else {
        dataOfSideMenuSubject.sink.addError('');
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      dataOfSideMenuSubject.sink.addError('');
    }
  }

  RoundedLoadingButtonController loadingButtonController =
      RoundedLoadingButtonController();
  Future<void> BeAffilator(BuildContext context) async {
    try {
      String? token = await _helper.getToken();
      String lang = await _helper.getCodeLang();
      int? countryID = await _helper.getCountryId();
      final res = await _dio.post(
        '/become-affilator?country_id=$countryID',
        options: Options(
          headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
        ),
      );
      if (res.statusCode == 200 && res.data['status'] == 200) {
        await _helper.cleanData();
        await Get.offAll(BottomNavBar());
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
        dataOfSideMenuSubject.sink.addError('');
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
  }

  dispose() async {
    await dataOfSideMenuSubject.stream.drain();
    await dataOfSideMenuSubject.close();
  }
}
