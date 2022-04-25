import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/screens/payment/payment_plans/payment_plans_choose_bloc.dart';
import 'package:al_murafiq/utils/utils.dart';
import 'package:al_murafiq/widgets/show_message_emty_dialog.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:al_murafiq/models/payment_plans.dart';

class PayPlansScreen extends StatefulWidget {
  final int? company_id;
  final int? typeAdsOrPlan;

  PayPlansScreen({Key? key, this.company_id, this.typeAdsOrPlan})
      : super(key: key);
  @override
  _PayPlansScreenState createState() => _PayPlansScreenState();
}

class _PayPlansScreenState extends State<PayPlansScreen> {
  PaymentPlansChooseBloc _paymentPlans = PaymentPlansChooseBloc();
  @override
  void initState() {
    _paymentPlans.fetchPaymentPlansChoose(type: widget.typeAdsOrPlan);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          // const GradientAppbar(),
          AppBar(
        centerTitle: true,
        title: const Text(''),
        elevation: 0,
        flexibleSpace: Column(
          children: <Widget>[
            Flexible(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF03317C),
                      Color(0xFF05B3D6),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 6,
              color: Colors.lime,
            ),
          ],
        ),
      ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Text('${'pay1'.tr}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 20)),
                        ),
                      ),
                      Image.asset(
                        Assets.LOGO,
                        width: 140,
                        height: 120,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('pay2'.tr,
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey.shade600))
                        .addPaddingOnly(bottom: 20),
                  ),
                  StreamBuilder<List<PaymentPlans>>(
                      stream: _paymentPlans.dataOfPaymentPlansSubject.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.length > 0) {
                            return ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  ZoomIn(
                                duration: Duration(milliseconds: 600),
                                delay: Duration(
                                    milliseconds:
                                        index * 100 > 1000 ? 600 : index * 120),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 0),
                                  child: PlanPayContainer(
                                    paymentPlans: snapshot.data![index],
                                    company_id: widget.company_id,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return SizedBox(
                              height: Get.height,
                              child: Center(child: Text('no_data'.tr)),
                            );
                          }
                        } else if (snapshot.hasError) {
                          return Center(
                              child: ShowMessageEmtyDialog(
                            message: 'snapshot.error',
                            pathImg: 'assets/images/noDocument.png',
                          ));
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
    );
  }
}
