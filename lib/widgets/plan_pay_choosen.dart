import 'package:al_murafiq/models/eshtrakaty.dart';
import 'package:al_murafiq/screens/payment/payment_plans/pay_plans_screen.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class PlanPayChoosen extends StatelessWidget {
  final Subscriptions? subscription;
  final int? company_id;
  final int? typeAdsOrPlan;

  PlanPayChoosen(
      {Key? key, this.subscription, this.company_id, this.typeAdsOrPlan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(subscription!.subscription!.name!,
                  // context.translate('plan1'),
                  style: const TextStyle(fontSize: 20)),
              const FaIcon(FontAwesomeIcons.checkCircle,
                      color: Colors.deepPurple)
                  .addPaddingOnly(right: 10, left: 10)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('text_days'.tr, style: const TextStyle(fontSize: 18)),
              Text(' ${subscription!.days} / ${subscription!.price}',
                      // context.translate('const'),
                      style: const TextStyle(fontSize: 18))
                  .addPaddingOnly(right: 15, left: 15),
              if (subscription!.currency_symbol != null)
                Text('${subscription!.currency_symbol}',
                    style: const TextStyle(fontSize: 18))
              else
                SizedBox(),
            ],
          ),
          Column(
            children: <Widget>[
              if (subscription!.last == 1)
                CustomedButton(
                        onPressed: () async {
                          await Get.to(PayPlansScreen(
                            company_id: company_id,
                            typeAdsOrPlan: typeAdsOrPlan,
                          ));
                        },
                        text: 'my-plan2'.tr,
                        height: 55)
                    .addPaddingOnly(bottom: 15)
              else
                SizedBox(
                  height: 20,
                ),
              RowCheckPlan(text: subscription.subscription.desc
                  // context.translate('do1')
                  ),
              if (subscription.slider_num == 0)
                const SizedBox()
              else
                RowCheckPlan(text: '${'do2'.tr} ${subscription.slider_num}'),
              if (subscription.banner_num == 0)
                const SizedBox()
              else
                RowCheckPlan(text: '${'do3'.tr} ${subscription.banner_num}'),
            ],
          ).addPaddingHorizontalVertical(horizontal: 20, vertical: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  RowForAppointments(
                      text: 'eshtrak'.tr, appointment: subscription.from
                      // context.translate('appo1')
                      ),
                  RowForAppointments(
                      text: 'tagdeed'.tr, appointment: subscription.to
                      // context.translate('appo2')
                      )
                ],
              ),
            ],
          ).addPaddingOnly(left: 10, right: 10),
        ],
      ),
    ).addPaddingHorizontalVertical(horizontal: 15, vertical: 10);
  }
}
