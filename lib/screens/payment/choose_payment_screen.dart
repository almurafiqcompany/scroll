import 'package:al_murafiq/models/payment_method.dart';
import 'package:al_murafiq/screens/payment/choose_payment_bloc.dart';
import 'package:al_murafiq/screens/payment/offline_payment/offlinepayment_screen.dart';
import 'package:al_murafiq/screens/payment/online_payment/onlinepayment_screen.dart';
import 'package:flutter/material.dart';
import 'package:al_murafiq/utils/utils.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:al_murafiq/models/payment_plans.dart';
class ChoosePayment extends StatefulWidget {
  final int company_id;
  final int pay_method_id;
  final  PaymentPlans paymentPlans;

  const ChoosePayment({Key key, this.company_id, this.pay_method_id, this.paymentPlans}) : super(key: key);

  @override
  _ChoosePaymentState createState() => _ChoosePaymentState();
}

class _ChoosePaymentState extends State<ChoosePayment> {
  ChoosePaymentBloc _choosePaymentBloc=ChoosePaymentBloc();
  @override
  void initState() {
    print('o');
    _choosePaymentBloc.fetchChoosePayment();
    // TODO: implement initState
    super.initState();
  }
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
                      Text('text_choose-payment'.tr,
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black))
                          .addPaddingHorizontalVertical(
                              vertical: 30, horizontal: 10),
                      Image.asset(Assets.POS,
                          width: (Get.width) - 20, height: 150),
                      Text('text_choose-payment'.tr,
                              style: TextStyle(
                                  fontSize: 17, color: Colors.grey.shade600))
                          .addPaddingOnly(
                              top: 30, bottom: 10, right: 10, left: 10),

                      StreamBuilder<List<PaymentMethod>>(
                        stream: _choosePaymentBloc.dataofhoosePaymentSubject.stream,
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            if(snapshot.data.length>0){
                              return Column(
                                children: [
                                  CustomedButton(
                                      onPressed: () async {
                                      //  OnlinePayment
                                        await Get.to(OnlinePayment(choosePaymentBloc:_choosePaymentBloc ,pay_method_id: widget.pay_method_id,company_id: widget.company_id,paymentPlans: widget.paymentPlans,));

                                      },
                                      text: 'online'.tr,
                                      height: 55,
                                      imageName: Assets.ONL)
                                      .addPaddingHorizontalVertical(
                                      horizontal: 40, vertical: 20),
                                  CustomedButton(
                                      onPressed: () async {
                                        await Get.to(OfflinePayment(choosePaymentBloc:_choosePaymentBloc ,pay_method_id: widget.pay_method_id,company_id: widget.company_id,paymentPlans: widget.paymentPlans,));
                                      },
                                      text: 'offline'.tr,
                                      height: 55,
                                      imageName: Assets.OFL)
                                      .addPaddingHorizontalVertical(horizontal: 40),
                                ],
                              );
                            }else {
                              return const SizedBox(height: 20,);

                                  }

                          }else if(snapshot.hasError){
                            return  Text(
                              '${snapshot.error}',
                            );
                          }else {
                            return const SizedBox(height: 20,);

                          }

                        }
                      ),

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
