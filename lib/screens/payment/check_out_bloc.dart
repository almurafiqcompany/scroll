import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/ticket.dart';
import 'package:al_murafiq/models/eshtrakaty.dart';
import 'package:al_murafiq/screens/home_page/nav_bar.dart';
import 'package:al_murafiq/widgets/show_loading_alert.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/subjects.dart';

class CheckOutBloc {
  dioo.Dio _dio = GetIt.instance.get<dioo.Dio>();
  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  RoundedLoadingButtonController loadingButtonController =
  RoundedLoadingButtonController();


  final dataofAllSubscriptionsSubject = BehaviorSubject<Eshtrakaty>();

  TextEditingController promoCodeController = TextEditingController();
  final BehaviorSubject<bool> promoCodeSubject = BehaviorSubject<bool>();
  changePromoCode(String val) => promoCodeSubject.sink.add(validateText(promoCodeController));

  validateText(TextEditingController controller) {
    return controller.text.isNotEmpty;
  }
  final couponIDSubject = BehaviorSubject<dynamic>();
  final payPalIDSubject = BehaviorSubject<dynamic>();
  Future<void> checkOut({BuildContext context  ,int company_id,
   int pay_method_id,
   int way_pay_id,
   String type_payment,
   int bank_or_address_id,}) async {

    String token = await _helper.getToken();
    String lang = await _helper.getCodeLang();
    int countryID = await _helper.getCountryId();

    try {
      showAlertDialog(context);
      final dioo.FormData formData = dioo.FormData.fromMap({
        'id': company_id,
        'subscription_id': pay_method_id,
        'payment_method_id': way_pay_id,
        'coupon_id':couponIDSubject.value,
        'code': promoCodeController.text,
      });
      // if (!couponIDSubject.value.isNaN) {
      //   formData.fields.add(
      //       // ignore: always_specify_types
      //       MapEntry('coupon_id', '${couponIDSubject.value}')
      //   );
      //
      // }
      if (type_payment == 'Cash' ) {
        formData.fields.add(
            MapEntry('address_id', '${bank_or_address_id}')

        );
        formData.fields.add(
            const MapEntry('type', 'Cash')
        );
      }
      if (type_payment == 'Bank' ) {
        formData.fields.add(
            MapEntry('bank_id', '${bank_or_address_id}')
        );
        formData.fields.add(
            const MapEntry('type', 'Bank')
        );
      }
      if (type_payment == 'PayPal' ) {
        // formData.fields.add(
        //     MapEntry('bank_id', '${bank_or_address_id}')
        // );
        formData.fields.add(
            const MapEntry('type', 'PayPal')
        );
      }
      if (type_payment == 'Tap' ) {
        // formData.fields.add(
        //     MapEntry('bank_id', '${bank_or_address_id}')
        // );
        formData.fields.add(
            const MapEntry('type', 'Tap')
        );
      }
      dioo.Response res = await _dio.post(
       '/companies/add-subscription?country_id=$countryID',
        options: dioo.Options(
          headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
        ),
        data: formData,
      );

      Get.back();
      print(' w ${res.data}');
      if (res.statusCode == 200 && res.data['status']==200) {
        await showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return ShowMessageDialog(type: 200,message: '${res.data['message']}',show_but: true,);
          },
        );
        await Get.offAll(BottomNavBar());
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
        context: context,
        builder: (BuildContext context) {
          return ShowMessageDialog(type: 400,message: 'e'.tr,show_but: true,);
        },
      );
    }
  }

  Future<void> checkOnline({BuildContext context  ,int company_id,
   int pay_method_id,
   int way_pay_id,
   String type_payment,
   int bank_or_address_id,int tryToActiveAddSub=1}) async {

    String token = await _helper.getToken();
    String lang = await _helper.getCodeLang();
    int countryID = await _helper.getCountryId();

    try {

      final dioo.FormData formData = dioo.FormData.fromMap({
        'id': company_id,
        'subscription_id': pay_method_id,
        'payment_method_id': way_pay_id,
        'coupon_id':couponIDSubject.value,
        'code': promoCodeController.text,
      });
      // if (!couponIDSubject.value.isNaN) {
      //   formData.fields.add(
      //       // ignore: always_specify_types
      //       MapEntry('coupon_id', '${couponIDSubject.value}')
      //   );
      //
      // }
      if (type_payment == 'Cash' ) {
        formData.fields.add(
            MapEntry('address_id', '${bank_or_address_id}')

        );
        formData.fields.add(
            const MapEntry('type', 'Cash')
        );
      }
      if (type_payment == 'Bank' ) {
        formData.fields.add(
            MapEntry('bank_id', '${bank_or_address_id}')
        );
        formData.fields.add(
            const MapEntry('type', 'Bank')
        );
      }
      if (type_payment == 'PayPal' ) {
        // formData.fields.add(
        //     MapEntry('bank_id', '${bank_or_address_id}')
        // );
        formData.fields.add(
            const MapEntry('type', 'PayPal')
        );
      }
      if (type_payment == 'Tap' ) {
        // formData.fields.add(
        //     MapEntry('bank_id', '${bank_or_address_id}')
        // );
        formData.fields.add(
            const MapEntry('type', 'Tap')
        );
      }
      dioo.Response res = await _dio.post(
       '/companies/add-subscription?country_id=$countryID',
        options: dioo.Options(
          headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
        ),
        data: formData,
      );

      print(' w ${res.data}');
      if (res.statusCode == 200 && res.data['status']==200) {

        await Get.offAll(BottomNavBar());
      } else {
        if(tryToActiveAddSub <=3 ){
          tryToActiveAddSub=tryToActiveAddSub + 1;
          await checkOnline(
            context: context,
            company_id: company_id,
            pay_method_id: pay_method_id,
            way_pay_id: way_pay_id,
            bank_or_address_id: bank_or_address_id,
            type_payment: type_payment,
            tryToActiveAddSub: tryToActiveAddSub,
          );
        }
        await Get.offAll(BottomNavBar());
        // await showModalBottomSheet<void>(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return ShowMessageDialog(type: 400,message: '${res.data['message']}',show_but: true,);
        //   },
        // );
      }
    // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      await showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return ShowMessageDialog(type: 400,message: 'e'.tr,show_but: true,);
        },
      );
    }
  }

  Future<void> checkPaymentURL({BuildContext context  ,int company_id,
   int pay_method_id,
   int way_pay_id,
   String type_payment,
   int bank_or_address_id,String URLCheck}) async {

    try {
      String urlParametersString = URLCheck.split('api')[1];
      print('urlParametersString ${urlParametersString}');
      dioo.Response res = await _dio.get(
       // 'https://almurafiq.dev-krito.com/api/pay-tap-response?tap_id=chg_TS040820211200n9MN0205875',
        '${urlParametersString}'
      );

      print('checkPaymentURL ${res.data}');
      print('checkPaymentURL ${res.statusCode}');
      if (res.statusCode==200) {
        // await showModalBottomSheet<void>(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return ShowMessageDialog(type: 200,message: '${res.data['message']}',show_but: true,);
        //   },
        // );
        // await Get.offAll(BottomNavBar());
        await checkOnline(
          context: context,
          company_id: company_id,
          pay_method_id: pay_method_id,
          way_pay_id: way_pay_id,
          bank_or_address_id: bank_or_address_id,
          type_payment: type_payment,
        );
      } else {
        // await showModalBottomSheet<void>(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return ShowMessageDialog(type: 400,message: '${res.data['message']}',show_but: true,);
        //   },
        // );
        await Get.offAll(BottomNavBar());
      }
    // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      await showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return ShowMessageDialog(type: 400,message: 'e'.tr,show_but: true,);
        },
      );
    }
  }

  Future<dynamic> getLinkWebView({BuildContext context  ,int company_id,
   int pay_method_id,
   int way_pay_id,
   String type_payment,}) async {

    String token = await _helper.getToken();
    String lang = await _helper.getCodeLang();
    int countryID = await _helper.getCountryId();

    try {
      // showAlertDialog(context);
      final dioo.FormData formData = dioo.FormData.fromMap({
        'id': company_id,
        'subscription_id': pay_method_id,
        'payment_method_id': way_pay_id,
        'coupon_id':couponIDSubject.value,
        'code': promoCodeController.text,
      });

      if (type_payment == 'PayPal' ) {
        // formData.fields.add(
        //     MapEntry('bank_id', '${bank_or_address_id}')
        // );
        formData.fields.add(
            const MapEntry('type', 'PayPal')
        );
      }
      if (type_payment == 'Tap' ) {
        // formData.fields.add(
        //     MapEntry('bank_id', '${bank_or_address_id}')
        // );
        formData.fields.add(
            const MapEntry('type', 'Tap')
        );
      }
      dioo.Response res = await _dio.post(
       '/companies/goCheckout?country_id=$countryID',
        options: dioo.Options(
          headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
        ),
        data: formData,
      );

      // Get.back();
      print(' w ${res.data}');
      if (res.statusCode == 200 && res.data['status']==200) {
        if(type_payment == 'PayPal') {
          payPalIDSubject.sink.add(res.data['data']['id']);
          print('payPalIDSubject ${payPalIDSubject.value}');
        }
         return type_payment == 'PayPal'?res.data['data']['url']:res.data['data'];
      } else {
        await showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return ShowMessageDialog(type: 400,message: '${res.data['message']}',show_but: true,);
          },
        );
        return null;
      }
    // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      await showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return ShowMessageDialog(type: 400,message: 'e'.tr,show_but: true,);
        },
      );
      return null;
    }
  }

  final resultOfCodeSubject = BehaviorSubject<String>();
  final discountSubject = BehaviorSubject<int>();
  final totalPriceSubject = BehaviorSubject<int>();
  Future<void> checkPromoCode({BuildContext context,int total}) async {

    String token = await _helper.getToken();
    String lang = await _helper.getCodeLang();
    int countryID = await _helper.getCountryId();

    try {
      showAlertDialog(context);
      final dioo.FormData formData = dioo.FormData.fromMap({
        'code': promoCodeController.text,
        'total': total,
      });

      dioo.Response res = await _dio.post(
        '/companies/coupon?country_id=$countryID',
        options: dioo.Options(
          headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
        ),
        data: formData,
      );
      Get.back();
      print('dd ${res.data}');
      if (res.statusCode == 200 && res.data['status']==200) {
       resultOfCodeSubject.sink.add(res.data['message']);
       discountSubject.sink.add(res.data['data']['discount']);
       totalPriceSubject.sink.add(res.data['data']['total']);
       couponIDSubject.sink.add(res.data['data']['coupon_id']);

      } else if(res.data['status']==400){
        resultOfCodeSubject.sink.addError(res.data['message']);
      }
    // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      resultOfCodeSubject.sink.addError('e'.tr);

    }
  }


}
