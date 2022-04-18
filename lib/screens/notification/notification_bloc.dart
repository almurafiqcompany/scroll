import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/notification.dart';
import 'package:al_murafiq/models/search_store.dart';
import 'package:al_murafiq/models/ticket.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/subjects.dart';

class NotificationBloc {
  dioo.Dio _dio = GetIt.instance.get<dioo.Dio>();

  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  RoundedLoadingButtonController loadingButtonController =
  RoundedLoadingButtonController();


  final dataofNotificationsSubject = BehaviorSubject<Notifications>();

  Future<void> fetchAllNotifications() async {

    String token = await _helper.getToken();
    String lang = await _helper.getCodeLang();
    int countryID = await _helper.getCountryId();

    try {

      dioo.Response res = await _dio.get(
        '/notifications?country_id=$countryID',
        options: dioo.Options(
          headers: {"Authorization": "Bearer $token", 'lang': '$lang'},
        ),

      );
      if (res.statusCode == 200 && res.data['status']==200) {
        dataofNotificationsSubject.sink.add(Notifications.fromJson(res.data['data']));
        await _helper.setNumberOfNotfiction(0);
      }else if(res.data['status']==400){
        dataofNotificationsSubject.sink.addError(res.data['message']);
      }
      else {
        dataofNotificationsSubject.sink.addError('');
      }
    // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      dataofNotificationsSubject.sink.addError('');
    }
  }
  Future<void> fetchNumberOfNotifications() async {

    String token = await _helper.getToken();
    String lang = await _helper.getCodeLang();
    int countryID = await _helper.getCountryId();

    try {

      dioo.Response res = await _dio.get(
        '/notifications/get-seen?country_id=$countryID',
        options: dioo.Options(
          headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
        ),

      );
      if (res.statusCode == 200 && res.data['status']==200) {
        await _helper.setNumberOfNotfiction(res.data['data']);
      }else if(res.data['status']==400){
        await _helper.setNumberOfNotfiction(0);
      }
      else {
        await _helper.setNumberOfNotfiction(0);
      }
    // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      await _helper.setNumberOfNotfiction(0);
    }
  }

  dispose() async {
    await dataofNotificationsSubject.stream.drain();
    await dataofNotificationsSubject.close();
  }
}
