import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/models/eshtrakaty.dart';
import 'package:al_murafiq/screens/payment/eshtrakaty_bloc.dart';
import 'package:al_murafiq/screens/payment/payment_plans/pay_plans_screen.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/utils/utils.dart';
import 'package:get/get.dart';

class Eshtrkaty extends StatefulWidget {
  final int company_id;
  final int typeAdsOrPlan;

   Eshtrkaty({Key key, this.company_id, this.typeAdsOrPlan}) : super(key: key);


  @override
  _EshtrkatyState createState() => _EshtrkatyState();
}

class _EshtrkatyState extends State<Eshtrkaty> {
  EshtrakatyBloc _eshtrakatyBloc=EshtrakatyBloc();

  @override
  void initState() {
    _eshtrakatyBloc.fetchAllSubscriptions(company_id: widget.company_id,typeAdsOrPlan:widget.typeAdsOrPlan );
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppbar(),

      body: ListView(
        physics: iosScrollPhysics(),
        children: <Widget>[
          Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                        child: Text('my-plan1'.tr,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 3),
                        child: Text('my-plan3'.tr,
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey.shade600)),
                      )
                    ],
                  ),
                ),
                Image.asset(Assets.LOGO,height: 120,width: 150,),
              ],
            ),
            StreamBuilder<Eshtrakaty>(
              stream: _eshtrakatyBloc.dataofAllSubscriptionsSubject.stream,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  if(snapshot.data.subscriptions.length > 0){
                    return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.subscriptions.length,
                      itemBuilder: (BuildContext context, int index) => ZoomIn(
                        duration: Duration(milliseconds: 600),
                        delay: Duration(
                            milliseconds:
                            index * 100 > 1000 ? 600 : index * 120),

                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            child: PlanPayChoosen(subscription: snapshot.data.subscriptions[index],company_id: widget.company_id,typeAdsOrPlan: widget.typeAdsOrPlan,)
                        ),
                      ),
                    );
                  }else{
                    return SizedBox(
                        height: Get.height,
                        child:  Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 25),
                              child: FlatButton(
                                  height: 60,
                                  minWidth: Get.width - 100,
                                  child: Text('bt_add_plan'.tr,
                                      style: kTextStyle.copyWith(fontSize: 23)),
                                  color: Colors.blue.shade800,
                                  textColor: Color(0xffFFFFFF),
                                  onPressed: () async {
                                    await Get.to(PayPlansScreen(company_id: widget.company_id,typeAdsOrPlan: widget.typeAdsOrPlan,));
                                  },
                                  shape:  RoundedRectangleBorder(
                                      borderRadius:
                                       BorderRadius.circular(30.0))),
                            ),
                        ));
                  }
                }else{
                  return SizedBox(
                      height: Get.height,
                      child: const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: kPrimaryColor,
                          )));
                }

              }
            ),
          ]),
        ],
      ),
    );
  }
}
