import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/payment_method.dart';
import 'package:al_murafiq/models/ticket.dart';
import 'package:al_murafiq/models/eshtrakaty.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/subjects.dart';

class ChoosePaymentBloc {
  dioo.Dio _dio = GetIt.instance.get<dioo.Dio>();

  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  RoundedLoadingButtonController loadingButtonController =
  RoundedLoadingButtonController();


  final dataofhoosePaymentSubject = BehaviorSubject<List<PaymentMethod>>();
  final dataofPaymentMethodCashSubject = BehaviorSubject<PaymentMethod>();
  final dataofPaymentMethodBankSubject = BehaviorSubject<PaymentMethod>();
  final dataofPaymentMethodPayPallSubject = BehaviorSubject<PaymentMethod>();
  final dataofPaymentMethodPayTabsSubject = BehaviorSubject<PaymentMethod>();
  final dataofPaymentMethodOnlineSubject = BehaviorSubject<PaymentMethod>();

  Future<void> fetchChoosePayment() async {

    String? token = await _helper.getToken();
    String lang = await _helper.getCodeLang();
    int? countryID = await _helper.getCountryId();

    try {
      print('start payment-methods');
      dioo.Response res = await _dio.get(
        '/payment-methods/?country_id=$countryID',
        options: dioo.Options(
          headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
        ),

      );
      print('payment ${res.data}');
      if (res.statusCode == 200 && res.data['status']==200) {
        List<PaymentMethod> paymentMethod = [];
        for (var obj in res.data['data']) {
          if(obj['type'] == 'Cash'){
            dataofPaymentMethodCashSubject.add(PaymentMethod.fromJson(obj));

          }
           if(obj['type']  == 'Bank'){
             dataofPaymentMethodBankSubject.add(PaymentMethod.fromJson(obj));

          }
          //  if(obj['type']  == 'Online'){
          //
          //   dataofPaymentMethodOnlineSubject.add(PaymentMethod.fromJson(obj));
          //
          // }
           if(obj['type']  == 'PayPal'){

             dataofPaymentMethodPayPallSubject.add(PaymentMethod.fromJson(obj));

          }
           if(obj['type']  == 'Tap'){

             dataofPaymentMethodPayTabsSubject.add(PaymentMethod.fromJson(obj));

          }

          paymentMethod.add(PaymentMethod.fromJson(obj));
        }
        dataofhoosePaymentSubject.sink.add(paymentMethod);
        // Get.snackbar(null, "aa",
        //     snackPosition: SnackPosition.BOTTOM);
      } else if(res.statusCode == 400){
        dataofhoosePaymentSubject.addError(res.data['message']);
        // Get.snackbar(null, 'حدث خطأ ما. حاول مرة أخري',
        //     snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      dataofhoosePaymentSubject.addError('');
    }
  }


}
