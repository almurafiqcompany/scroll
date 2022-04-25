import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/subscription.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/rxdart.dart';
import 'package:al_murafiq/models/countries.dart';

class SubscriptionBloc {
  Dio _dio = GetIt.instance.get<Dio>();
  SharedPreferenceHelper helper = GetIt.instance.get<SharedPreferenceHelper>();
  final allSubscriptionSubject = BehaviorSubject<List<SubscriptionData>>();

  final selectedSubscription = BehaviorSubject<SubscriptionData>();
  RoundedLoadingButtonController loadingButtonController =
      RoundedLoadingButtonController();
  Future<void> fetchAllSubscription(BuildContext context) async {
    try {
      String langCode = await helper.getCodeLang();
      int? idCountry = await helper.getCountryId();
      String? token = await helper.getToken();
      final List<SubscriptionData> subscriptionData = [];
      final res = await _dio.get(
        '/companies/branches?type=1',
        options: Options(
          headers: {"Authorization": "Bearer $token", 'lang': '$langCode'},
        ),
      );
      if (res.statusCode == 200 && res.data['status'] == 200) {
        for (var obj in res.data['data']) {
          // countries.add(CountriesData.fromJson(obj));
          SubscriptionData subscription = SubscriptionData.fromJson(obj);
          // if(subscription.id == idCountry){
          //   selectedSubscription.sink.add(subscription);
          // }
          subscriptionData.add(subscription);
        }
        allSubscriptionSubject.sink.add(subscriptionData);
        selectedSubscription.sink.add(subscriptionData[0]);
      } else if (res.data['status'] == 400) {
        allSubscriptionSubject.sink.addError('');

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
              message: '${res.data['message']}',
              show_but: true,
            );
          },
        );
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      allSubscriptionSubject.sink.addError('');

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
    await allSubscriptionSubject.stream.drain();
    allSubscriptionSubject.close();
  }
}
