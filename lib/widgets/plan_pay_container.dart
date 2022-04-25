import 'package:al_murafiq/models/payment_plans.dart';
import 'package:al_murafiq/screens/payment/choose_payment_screen.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';


class PlanPayContainer extends StatelessWidget {

final  PaymentPlans? paymentPlans;
final int? company_id;

  const PlanPayContainer({Key? key, this.paymentPlans, this.company_id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 3),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(paymentPlans!.name!,
                  // context.translate('plan1'),
                  style: const TextStyle(fontSize: 22)),
              const FaIcon(FontAwesomeIcons.checkCircle,
                      color: Colors.deepPurple)
                  .addPaddingOnly(right: 5,left: 5)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (paymentPlans!.country_subscription!.currency_symbol!=null) Text('${paymentPlans!.country_subscription!.currency_symbol}',
                  style: const TextStyle(fontSize: 18)) else SizedBox(),
              Text(' ${paymentPlans!.country_subscription!.price} / ${paymentPlans!.days}',
                  // context.translate('const'),
                  style: const TextStyle(fontSize: 18))
                  .addPaddingOnly(right: 15, left: 15),
              Text('text_days'.tr,
                  style: const TextStyle(fontSize: 18)),
            ],
          ),

          Column(
            children: <Widget>[
              CustomedButton(
                      onPressed: () async {

                        await Get.to(ChoosePayment(company_id: company_id!,pay_method_id: paymentPlans!.id!,paymentPlans: paymentPlans!,));
                      },
                      text: 'plan2'.tr,
                      height: 55)
                  .addPaddingOnly(bottom: 20),
              RowCheckPlan(text: paymentPlans!.desc!),
              if (paymentPlans!.slider_num == 0) const SizedBox() else RowCheckPlan(text: '${'do2'.tr} ${paymentPlans!.slider_num}'),
              if (paymentPlans!.banner_num == 0) const SizedBox() else RowCheckPlan(text: '${'do3'.tr} ${paymentPlans!.banner_num}'),

            ],
          ).addPaddingHorizontalVertical(horizontal: 20, vertical: 20),
        ],
      ),
    ).addPaddingHorizontalVertical(horizontal: 15, vertical: 10);
  }
}
