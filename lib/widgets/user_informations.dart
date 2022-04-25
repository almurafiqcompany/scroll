import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/screens/payment/check_out.dart';
import 'package:al_murafiq/widgets/customed_button.dart';
import 'package:flutter/material.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:get/get.dart';
import 'package:al_murafiq/models/payment_plans.dart';
class BankAccountInformations extends StatelessWidget {
  final int? id;
  final String? bankName, accountOwnerName, branchName, accountNumber, swiftCode;
  final int? company_id;
  final int? pay_method_id;
  final int? way_pay_id;
  final PaymentPlans? paymentPlans;

  const BankAccountInformations({Key? key, this.id, this.bankName, this.accountOwnerName, this.branchName, this.accountNumber, this.swiftCode, this.company_id, this.pay_method_id, this.way_pay_id, this.paymentPlans}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
      decoration: BoxDecoration(
        color:  Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: <Widget>[

          Text('bank_info_1'.tr,
              style: TextStyle(fontSize: 15, color: Color(0xff8C98A9))),
          Text(bankName!,
                  style: const TextStyle(
                      fontSize: 18,color: Color(0xFF052656), fontWeight: FontWeight.w300))
              .addPaddingHorizontalVertical(vertical: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomedButton(
                onPressed: () async {
                  await Get.to(CheckOut(
                    company_id: company_id!,
                    pay_method_id: pay_method_id!,
                    way_pay_id: way_pay_id!,
                    bank_or_address_id: id!,
                    type_payment: 'Bank',
                    paymentPlans: paymentPlans!,
                  ));
                },
                text:'Select this bank',
                height: 55)
                .addPaddingOnly(bottom: 10),
          ),
          Text('bank_info_2'.tr,
              style: TextStyle(fontSize: 15, color: Color(0xff8C98A9))),
          Text(accountNumber!,
                  style: const TextStyle(
                      fontSize: 18, color: Color(0xFF052656), fontWeight: FontWeight.bold))
              .addPaddingHorizontalVertical(vertical: 10),
          Text('bank_info_3'.tr,
              style: TextStyle(fontSize: 15, color: Color(0xff8C98A9))),
          Text(accountOwnerName!,
                  style: const TextStyle(
                      fontSize: 18, color: Color(0xFF052656), fontWeight: FontWeight.w500))
              .addPaddingHorizontalVertical(vertical: 10),
          Text('bank_info_4'.tr,
              style: const TextStyle(fontSize: 15, color: Color(0xff8C98A9))),
          Text(branchName!,
                  style: const TextStyle(
                      fontSize: 18, color: Color(0xFF052656), fontWeight: FontWeight.w500))
              .addPaddingHorizontalVertical(vertical: 10),
          Text('bank_info_5'.tr,
              style: TextStyle(fontSize: 15, color: Color(0xff8C98A9))),
          Text(swiftCode!,
                  style: const TextStyle(
                      fontSize: 18,  color: Color(0xFF052656), fontWeight: FontWeight.bold))
              .addPaddingHorizontalVertical(vertical: 10),
        ],
      ),
    ).addPaddingHorizontalVertical(horizontal: 25,vertical: 1);
  }
}
