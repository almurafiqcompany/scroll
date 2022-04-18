import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:al_murafiq/models/payment_plans.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';

class PaymentPlansChooseBloc {
  Dio _dio = GetIt.instance.get<Dio>();
  final dataOfPaymentPlansSubject = BehaviorSubject<List<PaymentPlans>>();
  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  Future<void> fetchPaymentPlansChoose({int type}) async {
    try {

      String token = await _helper.getToken();
      String lang = await _helper.getCodeLang();
      int countryID = await _helper.getCountryId();
      final Response res = await _dio.get(
        '/subscriptions/?country_id=$countryID&type=$type',
        options: Options(
          headers: {"Authorization": "Bearer $token", "lang": "$lang"},
        ),
      );
      List<PaymentPlans> paymentPlan = [];

      print('symboll ${res.data}');
      if (res.statusCode == 200 && res.data['status'] == 200) {
        for (var obj in res.data['data']) {
          print('symbol ${PaymentPlans.fromJson(obj).country_subscription}');
          paymentPlan.add(PaymentPlans.fromJson(obj));
        }

        dataOfPaymentPlansSubject.sink.add(paymentPlan);
      } else if (res.data['status'] == 400) {
        dataOfPaymentPlansSubject.sink.addError(res.data['message']);
      } else {
        dataOfPaymentPlansSubject.sink.addError('');
      }
    } catch (e) {
      dataOfPaymentPlansSubject.sink.addError('');
    }
  }

  dispose() async {
    await dataOfPaymentPlansSubject.stream.drain();
    dataOfPaymentPlansSubject.close();
  }
}
