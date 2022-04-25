import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/payment_method.dart';
import 'package:al_murafiq/screens/payment/choose_payment_bloc.dart';
import 'package:al_murafiq/screens/payment/offline_payment/addresses/add_address/add_address_screen.dart';

import 'package:al_murafiq/screens/payment/payment_information/pay_informations_screen.dart';
import 'package:flutter/material.dart';
import 'package:al_murafiq/utils/utils.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:al_murafiq/models/payment_plans.dart';

class OfflinePayment extends StatelessWidget {
  // dynamic lng = 0.0;
  // dynamic lat = 0.0;
  final ChoosePaymentBloc? choosePaymentBloc;
  final int? company_id;
  final int? pay_method_id;
  final PaymentPlans? paymentPlans;

  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();

  OfflinePayment(
      {Key? key,
      this.choosePaymentBloc,
      this.company_id,
      this.pay_method_id,
      this.paymentPlans})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: const GradientAppbar(),
            body: SingleChildScrollView(
              physics: iosScrollPhysics(),
              child: Stack(
                children: [
                  Container(
                    height: Get.height * 0.6,
                    width: Get.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/backgroundImage.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('text_offline-payment'.tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black))
                          .addPaddingHorizontalVertical(
                              vertical: 30, horizontal: 10),
                      Image.asset(
                        Assets.MONEY,
                        width: (Get.width) - 20,
                        height: 150,
                      ),
                      Text('text_choose-payment'.tr,
                              style: TextStyle(
                                  fontSize: 17, color: Colors.grey.shade600))
                          .addPaddingOnly(
                              top: 30, bottom: 10, right: 10, left: 10),
                      StreamBuilder<PaymentMethod>(
                          stream: choosePaymentBloc!
                              .dataofPaymentMethodBankSubject.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return CustomedButton(
                                      onPressed: () async {
                                        await Get.to(PayInfoScreen(
                                          company_id: company_id,
                                          pay_method_id: pay_method_id,
                                          way_pay_id: snapshot.data!.id,
                                          paymentPlans: paymentPlans,
                                        ));
                                      },
                                      text: snapshot.data!.name,
                                      height: 55,
                                      imageName: Assets.BANK)
                                  .addPaddingHorizontalVertical(
                                      horizontal: 60, vertical: 20);
                            } else {
                              return SizedBox(
                                height: 10,
                              );
                            }
                          }),
                      StreamBuilder<PaymentMethod>(
                          stream: choosePaymentBloc!
                              .dataofPaymentMethodCashSubject.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return CustomedButton(
                                onPressed: () async {
                                  // await BackgroundLocation
                                  //     .startLocationService();
                                  // BackgroundLocation.getLocationUpdates(
                                  //     (location) {
                                  //   lng = location.longitude;
                                  //   lat = location.latitude;
                                  //   // setState(() {
                                  //   //   print('dd${location.longitude}');
                                  //   //   print('${location}');
                                  //   // });
                                  // });

                                  await Get.to(AddAddressScreen(
                                    // lng: lng, lat: lat,
                                    lng: await _helper.getLng(),
                                    lat: await _helper.getLat(),
                                    company_id: company_id!,
                                    pay_method_id: pay_method_id!,
                                    way_pay_id: snapshot.data!.id!,
                                    paymentPlans: paymentPlans!,
                                  ));
                                },
                                text: snapshot.data!.name,
                                height: 55,
                                imageName: Assets.DELIVERY,
                              ).addPaddingHorizontalVertical(horizontal: 60);
                            } else {
                              return SizedBox(
                                height: 10,
                              );
                            }
                          }),
                    ],
                  ),
                ],
              ),
            )),
        const Positioned(
            right: 30,
            top: 50,
            child: Image(
              image: AssetImage('assets/images/sign.png'),
            )),
      ],
    );
  }
}
