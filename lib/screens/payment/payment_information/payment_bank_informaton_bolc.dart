import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:al_murafiq/models/payment_bank_information.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';

class PaymentBankInformationBloc {
  Dio _dio = GetIt.instance.get<Dio>();
  final dataOfPaymentBankInformationSubject =
      BehaviorSubject<List<PaymentBankInformation>>();
  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  Future<void> fetchPaymentBankInformation() async {
    try {

      String token = await _helper.getToken();
      String lang = await _helper.getCodeLang();
      int countryID = await _helper.getCountryId();
      final Response res = await _dio.get(
        '/banks/?country_id=$countryID',
        options: Options(
          headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
        ),
      );

      List<PaymentBankInformation> paymentbank = [];
      if (res.statusCode == 200 && res.data['status'] == 200) {
        for (var obj in res.data['data']) {
          paymentbank.add(PaymentBankInformation.fromJson(obj));
        }

        dataOfPaymentBankInformationSubject.sink.add(paymentbank);


      } else if (res.data['status'] == 400) {

        dataOfPaymentBankInformationSubject.sink.addError(res.data['message']);
      } else {
        dataOfPaymentBankInformationSubject.sink.addError('');
      }
    } catch (e) {
      dataOfPaymentBankInformationSubject.sink.addError('');
    }
  }

  dispose() async {
    await dataOfPaymentBankInformationSubject.stream.drain();
    dataOfPaymentBankInformationSubject.close();
  }
}
