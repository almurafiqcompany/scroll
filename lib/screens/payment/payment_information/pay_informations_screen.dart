import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/screens/payment/payment_information/payment_bank_informaton_bolc.dart';
import 'package:al_murafiq/utils/assets.dart';
import 'package:al_murafiq/utils/scroll_physics_like_ios.dart';
import 'package:flutter/material.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:al_murafiq/models/payment_bank_information.dart';
import 'package:al_murafiq/models/payment_plans.dart';
class PayInfoScreen extends StatefulWidget {
  final int? company_id;
  final int? pay_method_id;
  final
   int? way_pay_id;
  final  PaymentPlans? paymentPlans;

   PayInfoScreen({Key? key, this.company_id, this.pay_method_id, this.way_pay_id, this.paymentPlans}) : super(key: key);


  @override
  _PayInfoScreenState createState() => _PayInfoScreenState();
}

class _PayInfoScreenState extends State<PayInfoScreen> {
  PaymentBankInformationBloc _paymentBankInformationBloc =
      PaymentBankInformationBloc();
  @override
  void initState() {
    _paymentBankInformationBloc.fetchPaymentBankInformation();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: const GradientAppbar(),
          body: Stack(
            children: [
              Column(
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
                ],
              ),
              ListView(
                physics: iosScrollPhysics(),
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Image.asset(Assets.BANK_LOGO).addPaddingOnly(top: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        child: Text('bank1'.tr,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        child: Text('bank2'.tr,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 15)),
                      ),
                      StreamBuilder<List<PaymentBankInformation>>(
                          stream: _paymentBankInformationBloc
                              .dataOfPaymentBankInformationSubject.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.length > 0) {
                                return ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 0),
                                    child: BulidBankCard(
                                        paymentBankInformation:
                                            snapshot.data![index],
                                        company_id: widget.company_id!,
                                        pay_method_id: widget.pay_method_id!,
                                        paymentPlans: widget.paymentPlans!,
                                        way_pay_id: widget.way_pay_id!),
                                  ),
                                );
                              } else {
                                return SizedBox(
                                  height: Get.height,
                                  child: Center(child: Text('Not Found Data')),
                                );
                              }
                            } else if (snapshot.hasError) {
                              return SizedBox(
                                height: Get.height,
                                child: Center(child: Text('${snapshot.error}')),
                              );
                            } else {
                              //return SizedBox();
                              return SizedBox(
                                  height: Get.height,
                                  child: const Center(
                                      child: CircularProgressIndicator(
                                    backgroundColor: kPrimaryColor,
                                  )));
                            }
                          }),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const Positioned(
            right: 30,
            top: 50,
            child: Image(
              image: AssetImage('assets/images/sign.png'),
            )),
      ],
    );
  }

  Widget BulidBankCard({
    PaymentBankInformation? paymentBankInformation,
    int? company_id,
    int? pay_method_id,
    int? way_pay_id,
    PaymentPlans? paymentPlans,
  }) {
    return Column(
      children: [
        // Image.asset(Assets.HSBC,width: (Get.width)-30,)
        //     .addPaddingHorizontalVertical(vertical: 10,horizontal: 10),
        Image.network(
          '$ImgUrl${paymentBankInformation!.logo}',
          fit: BoxFit.fill,
          width: (Get.width / 2) + 20,
          height: 100,
        ).addPaddingHorizontalVertical(vertical: 10, horizontal: 10),
        BankAccountInformations(
          way_pay_id: way_pay_id,
            pay_method_id: pay_method_id,
            company_id: company_id,
            id: paymentBankInformation.id,
            bankName: '${paymentBankInformation.bank_name}',
            accountNumber: '${paymentBankInformation.account_num}',
            accountOwnerName: '${paymentBankInformation.owner_name}',
            branchName: '${paymentBankInformation.branch_name}',
            paymentPlans: paymentPlans,
            swiftCode: '${paymentBankInformation.swift_num}'),
      ],
    );
  }
}
