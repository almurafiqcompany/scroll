import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/screens/payment/check_out_bloc.dart';
import 'package:al_murafiq/screens/payment/offline_payment/addresses/add_address/add_address_screen.dart';
import 'package:al_murafiq/screens/payment/online_payment/card_view/card_view.dart';
import 'package:al_murafiq/screens/payment/online_payment/card_view/card_view_paypal.dart';

import 'package:al_murafiq/screens/payment/payment_information/pay_informations_screen.dart';

// import 'package:braintree_payment/braintree_payment.dart';
import 'package:flutter/material.dart';
import 'package:al_murafiq/utils/utils.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:al_murafiq/models/payment_plans.dart';
import 'package:al_murafiq/widgets/show_loading_alert.dart';

class CheckOut extends StatelessWidget {
  final int? company_id;
  final int? pay_method_id;
  final int? way_pay_id;
  final String? type_payment;

  final int? bank_or_address_id;
  final PaymentPlans? paymentPlans;
  CheckOutBloc _checkOutBloc=CheckOutBloc();

   CheckOut({Key? key, this.company_id, this.pay_method_id, this.way_pay_id, this.type_payment, this.bank_or_address_id, this.paymentPlans}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GradientAppbar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: Get.height/11),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: 65,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            gradient: LinearGradient(
                              colors: <Color>[
                                Colors.blueAccent ,
                                Colors.blue.shade800 ,
                              ],

                            )),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(15.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text('${paymentPlans!.name}',
                                    style: const TextStyle(color: Colors.white, fontSize: 17)),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height/11,),
                    Row(
                      children: [
                        Expanded(
                          child: StreamBuilder<bool>(
                               stream: _checkOutBloc.promoCodeSubject.stream,
                              initialData: true,
                              builder: (context, snapshot) {
                                return TextField(
                                  style: TextStyle(fontSize: 14),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFFE0E7FF),
                                    contentPadding: EdgeInsets.all(9),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(6)),
                                      borderSide:
                                      BorderSide(width: 1, color: Color(0xffE0E7FF)),
                                    ),
                                    disabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(6)),
                                      borderSide: BorderSide(width: 1, color: Colors.black54),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(6)),
                                      borderSide:
                                      BorderSide(width: 1, color: Color(0xFFE0E7FF)),
                                    ),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(6)),
                                        borderSide: BorderSide(width: 1)),
                                    errorBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(6)),
                                        borderSide: BorderSide(width: 1, color: Colors.red)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(6)),
                                        borderSide:
                                        BorderSide(width: 1, color: Colors.red.shade800)),
                                    hintText: 'promo_code'.tr,
                                    hintStyle: const TextStyle(
                                        fontSize: 14, color: Color(0xFF9797AD)),
                                  ),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                   onChanged: (val) => _checkOutBloc.changePromoCode(val),
                                   controller: _checkOutBloc.promoCodeController,
                                );
                              }),
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: () async {
                            if(_checkOutBloc.promoCodeController.text.isNotEmpty){
                              await _checkOutBloc.checkPromoCode(
                                context: context,
                                total:paymentPlans!.price,
                              );
                            }

                          },
                          child: Container(
                            height: 50,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Colors.blueAccent ,
                                    Colors.blue.shade800 ,
                                  ],
                                )),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(15.0),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Center(
                                  child: Text(
                                    'active_code'.tr,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                                // const Image(
                                //   image: AssetImage('assets/images/promoCode.png'),
                                // ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    StreamBuilder<String>(
                      stream: _checkOutBloc.resultOfCodeSubject.stream,
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Row(
                              children: [
                                // Text('promo_code_used'.tr,
                                //     style:   const TextStyle(color: Colors.red, fontSize: 15)),
                                Expanded(
                                  child: Text(snapshot.data!,
                                      style:   const TextStyle(color: Colors.green, fontSize: 12)),
                                ),
                              ],
                            ),
                          );
                        }else if(snapshot.hasError){
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text('snapshot.error',
                                      style:   const TextStyle(color: Colors.red, fontSize: 12)),
                                ),
                              ],
                            ),
                          );
                        }
                        return SizedBox();
                      }
                    ),
                    const SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Color(0xffE4E4E4)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('sub_total'.tr,
                                      style:   const TextStyle(color: Color(0xff3E3F68), fontSize: 16)),
                                  Text('${paymentPlans!.price}',
                                      style:   const TextStyle(color: Color(0xff444E5B), fontSize: 14)),
                                ],
                              ),
                            ),
                              StreamBuilder<int>(
                              stream: _checkOutBloc.discountSubject.stream,
                              builder: (context, snapshot) {
                                if(snapshot.hasData){
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('discount'.tr,
                                            style:   const TextStyle(color: Color(0xff3E3F68), fontSize: 16)),
                                        Text('- ${snapshot.data}',
                                            style:   const TextStyle(color: Color(0xffFF7C7C), fontSize: 14)),
                                      ],
                                    ),
                                  );
                                }
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('discount'.tr,
                                          style:   const TextStyle(color: Color(0xff3E3F68), fontSize: 16)),
                                      Text('- 0',
                                          style:   const TextStyle(color: Color(0xffFF7C7C), fontSize: 14)),
                                    ],
                                  ),
                                );

                               }),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(vertical: 8),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Text('discount'.tr,
                            //           style:   const TextStyle(color: Color(0xff3E3F68), fontSize: 20)),
                            //       Text('- 0',
                            //           style:   const TextStyle(color: Color(0xffFF7C7C), fontSize: 16)),
                            //     ],
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child:  Divider(
                                height: 5,
                                color: Color(0xffC6C6C6),
                                indent: 2,
                                endIndent: 2,
                                thickness: 1.5,
                              ),
                            ),
                            StreamBuilder<int>(
                              stream: _checkOutBloc.totalPriceSubject.stream,
                              builder: (context, snapshot) {
                                if(snapshot.hasData){
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('price'.tr,
                                            style:   const TextStyle(color: Color(0xff3E3F68), fontSize: 16)),
                                        Text('${snapshot.data}',
                                            style:   const TextStyle(color: Colors.green, fontSize: 14,fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  );
                                }
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('price'.tr,
                                          style:   const TextStyle(color: Color(0xff3E3F68), fontSize: 16)),
                                      Text('${paymentPlans!.price}',
                                          style:   const TextStyle(color: Color(0xff444E5B), fontSize: 14,fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                );
                              }
                            ),
                          ],
                        ),
                      ),
                    ),
                     SizedBox(height: Get.height/12),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(5.0),
                      ),
                      height: 50,
                      minWidth: Get.width*0.8,
                      color: Color(0xff2E5BFF),
                      child: Text(
                        'bt_check_out'.tr,
                        style: TextStyle(
                            color: Color(0xffFFFFFF)),
                      ),
                      onPressed: () async {
                        if(type_payment == 'PayPal'){
                          print('paypal');
                          // payPalFlow();
                        // <activity android:name="com.braintreepayments.api.BraintreeBrowserSwitchActivity"
                        // android:launchMode="singleTask">
                        // <intent-filter>
                        // <action android:name="android.intent.action.VIEW" />
                        // <category android:name="android.intent.category.DEFAULT" />
                        // <category android:name="android.intent.category.BROWSABLE" />
                        // <data android:scheme="${applicationId}.braintree" />
                        // </intent-filter>
                        // </activity>
                        // <meta-data android:name="com.google.android.gms.wallet.api.enabled" android:value="true"/>

                          showAlertDialog(context);
                          var linkWebView= await _checkOutBloc.getLinkWebView(
                            context: context,
                            company_id: company_id!,
                            pay_method_id: pay_method_id!,
                            way_pay_id: way_pay_id!,
                            type_payment: type_payment!,
                          );
                        if(linkWebView !=null){
                        print('a ${linkWebView}');
                         // payPalFlow();
                         await Get.to(
                             CardViewPaypal(
                               url: linkWebView,
                               paymentPlan: paymentPlans!,
                               company_id: company_id!,
                               pay_method_id: pay_method_id!,
                               way_pay_id: way_pay_id!,
                               bank_or_address_id: bank_or_address_id!,
                               type_payment: type_payment!,
                             )
                        );
                        }
                          Get.back();
                        }else if(type_payment == 'Tap'){
                          print('paytabs');
                          print('paytabs ${type_payment}');
                          showAlertDialog(context);
                         var linkWebView= await _checkOutBloc.getLinkWebView(
                           context: context,
                          company_id: company_id!,
                          pay_method_id: pay_method_id!,
                          way_pay_id: way_pay_id!,
                          type_payment: type_payment!,
                          );
                        if(linkWebView !=null){
                          print('a ${linkWebView}');
                          await Get.to(
                              CardView(
                                url: linkWebView,
                                paymentPlan: paymentPlans!,
                                company_id: company_id!,
                                pay_method_id: pay_method_id!,
                                way_pay_id: way_pay_id!,
                                bank_or_address_id: bank_or_address_id!,
                                type_payment: type_payment!,
                              )
                          );
                          }
                          Get.back();
                        }else{
                          await _checkOutBloc.checkOut(
                            context: context,
                            company_id: company_id!,
                            pay_method_id: pay_method_id,
                            way_pay_id: way_pay_id,
                            bank_or_address_id: bank_or_address_id,
                            type_payment: type_payment,
                          );
                        }

                          },
                        ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 30),
                    //   child: RoundedLoadingButton(
                    //     child: Text(
                    //       'bt_check_out'.tr,
                    //       style: kTextStyle.copyWith(color: Colors.white),
                    //     ),
                    //     height: 50,
                    //     controller: _checkOutBloc.loadingButtonController,
                    //     color: Colors.blue.shade800,
                    //     onPressed: () async {
                    //       _checkOutBloc.loadingButtonController.start();
                    //       await _checkOutBloc.checkOut(
                    //         context: context,
                    //         company_id: company_id,
                    //         pay_method_id: pay_method_id,
                    //         way_pay_id: way_pay_id,
                    //         bank_or_address_id: bank_or_address_id,
                    //         type_payment: type_payment,
                    //       );
                    //       _checkOutBloc.loadingButtonController.stop();
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
  // String clientNonce =
  //     'eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiJlNTc1Mjc3MzZiODkyZGZhYWFjOTIxZTlmYmYzNDNkMzc2ODU5NTIxYTFlZmY2MDhhODBlN2Q5OTE5NWI3YTJjfGNyZWF0ZWRfYXQ9MjAxOS0wNS0yMFQwNzoxNDoxNi4zMTg0ODg2MDArMDAwMFx1MDAyNm1lcmNoYW50X2lkPTM0OHBrOWNnZjNiZ3l3MmJcdTAwMjZwdWJsaWNfa2V5PTJuMjQ3ZHY4OWJxOXZtcHIiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvMzQ4cGs5Y2dmM2JneXcyYi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJncmFwaFFMIjp7InVybCI6Imh0dHBzOi8vcGF5bWVudHMuc2FuZGJveC5icmFpbnRyZWUtYXBpLmNvbS9ncmFwaHFsIiwiZGF0ZSI6IjIwMTgtMDUtMDgifSwiY2hhbGxlbmdlcyI6W10sImVudmlyb25tZW50Ijoic2FuZGJveCIsImNsaWVudEFwaVVybCI6Imh0dHBzOi8vYXBpLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb206NDQzL21lcmNoYW50cy8zNDhwazljZ2YzYmd5dzJiL2NsaWVudF9hcGkiLCJhc3NldHNVcmwiOiJodHRwczovL2Fzc2V0cy5icmFpbnRyZWVnYXRld2F5LmNvbSIsImF1dGhVcmwiOiJodHRwczovL2F1dGgudmVubW8uc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbSIsImFuYWx5dGljcyI6eyJ1cmwiOiJodHRwczovL29yaWdpbi1hbmFseXRpY3Mtc2FuZC5zYW5kYm94LmJyYWludHJlZS1hcGkuY29tLzM0OHBrOWNnZjNiZ3l3MmIifSwidGhyZWVEU2VjdXJlRW5hYmxlZCI6dHJ1ZSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiQWNtZSBXaWRnZXRzLCBMdGQuIChTYW5kYm94KSIsImNsaWVudElkIjpudWxsLCJwcml2YWN5VXJsIjoiaHR0cDovL2V4YW1wbGUuY29tL3BwIiwidXNlckFncmVlbWVudFVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS90b3MiLCJiYXNlVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb20iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJhbGxvd0h0dHAiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjp0cnVlLCJlbnZpcm9ubWVudCI6Im9mZmxpbmUiLCJ1bnZldHRlZE1lcmNoYW50IjpmYWxzZSwiYnJhaW50cmVlQ2xpZW50SWQiOiJtYXN0ZXJjbGllbnQzIiwiYmlsbGluZ0FncmVlbWVudHNFbmFibGVkIjp0cnVlLCJtZXJjaGFudEFjY291bnRJZCI6ImFjbWV3aWRnZXRzbHRkc2FuZGJveCIsImN1cnJlbmN5SXNvQ29kZSI6IlVTRCJ9LCJtZXJjaGFudElkIjoiMzQ4cGs5Y2dmM2JneXcyYiIsInZlbm1vIjoib2ZmIn0=';
  //
  // payPalFlow() async {
  //   print('start paypall ');
  //   BraintreePayment braintreePayment =  BraintreePayment();
  //   print('start ${braintreePayment} ');
  //   Map data = await braintreePayment.startPayPalFlow(
  //       nonce: clientNonce, amount: '5.0', currency: 'USD');
  //
  //   // var data = await braintreePayment.showDropIn(
  //   //     nonce: clientNonce,
  //   //     amount: "2.0",
  //   //     enableGooglePay: true,
  //   //     nameRequired: true,
  //   //     inSandbox: true,
  //   //     currency: "EUR",
  //   //     useVault: false);
  //   print('Response of the paypal flow $data');
  // }
}
