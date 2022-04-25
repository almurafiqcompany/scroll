import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/search_store.dart';
import 'package:al_murafiq/models/ticket.dart';
import 'package:al_murafiq/widgets/show_loading_alert.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/subjects.dart';

class SearchStoreBloc {
  dioo.Dio _dio = GetIt.instance.get<dioo.Dio>();

  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  RoundedLoadingButtonController loadingButtonController =
      RoundedLoadingButtonController();

  final dataofSearchStoreSubject = BehaviorSubject<SearchStore>();
  final dataListSearchStoreSubject = BehaviorSubject<List<SearchStoreData>>();

  Future<void> fetchAllSearchStore() async {
    String? token = await _helper.getToken();
    String lang = await _helper.getCodeLang();
    int? countryID = await _helper.getCountryId();
    String? code = await _helper.getCode();
    try {
      dioo.Response res = await _dio.get(
        '/search/history?country_id=$countryID&user_id=$code',
        options: dioo.Options(
          headers: {"Authorization": "Bearer $token", 'lang': '$lang'},
        ),
      );

      if (res.statusCode == 200 && res.data['status'] == 200) {
        dataofSearchStoreSubject.sink
            .add(SearchStore.fromJson(res.data['data']));
        dataListSearchStoreSubject.sink
            .add(SearchStore.fromJson(res.data['data']).data!);
      } else if (res.data['status'] == 400) {
        dataofSearchStoreSubject.sink.addError(res.data['message']);
      } else {
        dataofSearchStoreSubject.sink.addError(res.data['message']);
      }
    } catch (e) {
      dataofSearchStoreSubject.sink.addError('');
    }
  }

  Future<void> searchStoreDestroy(int id, BuildContext context) async {
    try {
      showAlertDialog(context);
      String? token = await _helper.getToken();
      String lang = await _helper.getCodeLang();
      int? countryID = await _helper.getCountryId();
      final res = await _dio.delete(
        '/search/destroy?id=$id&country_id=$countryID',
        options: dioo.Options(
          headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
        ),
      );
      Get.back();
      if (res.statusCode == 200 && res.data['status'] == 200) {
        dataListSearchStoreSubject.sink.add(dataListSearchStoreSubject.value
          ..removeWhere((ele) => ele.id == id));

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
      Get.back();
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
    await dataofSearchStoreSubject.stream.drain();
    await dataofSearchStoreSubject.close();
  }
}
