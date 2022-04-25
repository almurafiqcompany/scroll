import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/models/payment_plans.dart';
import 'package:al_murafiq/screens/payment/check_out_bloc.dart';
import 'package:al_murafiq/utils/constants.dart';
import 'package:flutter/material.dart' hide Router;

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:al_murafiq/screens/home_page/nav_bar.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';

class CardViewPaypal extends StatefulWidget {
  CardViewPaypal(
      {Key? key,
      this.url,
      this.paymentPlan,
      this.company_id,
      this.pay_method_id,
      this.way_pay_id,
      this.type_payment,
      this.bank_or_address_id})
      : super(key: key);
  final String? url;
  final PaymentPlans? paymentPlan;
  final int? company_id;
  final int? pay_method_id;
  final int? way_pay_id;
  final String? type_payment;

  final int? bank_or_address_id;
  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardViewPaypal> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  CheckOutBloc _checkOutBloc = CheckOutBloc();
  @override
  void initState() {
    super.initState();
    print('start');
    flutterWebviewPlugin.onUrlChanged.listen((String url) async {
      print('url $url');
      if (url.startsWith('https://almurafiq.com/paypal/')) {
        // if (url.startsWith('${TapUrl}/paytabs_response')) {
        print('payment url ${url}');
        if (url.contains('success')) {
          print('payment A');
          // await flutterWebviewPlugin.close();
          print('payment plan');
          // if (widget.paymentPlan != null) {
          //   print('payment plan');
          //   await _checkOutBloc.checkPaymentURL(
          //     context: context,
          //     company_id: widget.company_id,
          //     pay_method_id: widget.pay_method_id,
          //     way_pay_id: widget.way_pay_id,
          //     bank_or_address_id: widget.bank_or_address_id,
          //     type_payment: widget.type_payment,
          //     URLCheck: url
          //   );

          // await showModalBottomSheet<void>(
          //   context: context,
          //   builder: (BuildContext context) {
          //     return ShowMessageDialog(type: 200,message: '',show_but: true,);
          //   },
          // );
          await _checkOutBloc.checkOnline(
            context: context,
            company_id: widget.company_id,
            pay_method_id: widget.pay_method_id,
            way_pay_id: widget.way_pay_id,
            bank_or_address_id: widget.bank_or_address_id,
            type_payment: widget.type_payment,
          );

          // } else {
          //   Get.back();
          // }
          // await Get.offAll(BottomNavBar());
        } else {
          print('payment else');
          if (await flutterWebviewPlugin.canGoBack()) {
            await flutterWebviewPlugin.goBack();
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await flutterWebviewPlugin.canGoBack()) {
          await flutterWebviewPlugin.goBack();
        } else {
          await flutterWebviewPlugin.close();
          if (widget.paymentPlan != null) {
            print('init WillPopScope');
            await Get.offAll(BottomNavBar());
          } else {
            Get.back();
          }
        }
        return false;
      },
      child: Stack(
        children: <Widget>[
          Container(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xffDFDFDF),
                  ),
                  child: WebviewScaffold(
                    url: widget.url,
                    withZoom: true,
                    hidden: true,
                    appBar: PreferredSize(
                        child: AppBar(
                          centerTitle: true,
                          title: Text(
                            'al_murafiq'.tr,
                          ),
                          // ignore: prefer_const_literals_to_create_immutables
                          // actions: [
                          //   GestureDetector(
                          //     onTap: () async {
                          //       if (await flutterWebviewPlugin.canGoBack()) {
                          //         await flutterWebviewPlugin.goBack();
                          //       } else {
                          //         await flutterWebviewPlugin.close();
                          //         if (widget.paymentPlan != null) {
                          //           print('appBar start');
                          //         } else {
                          //           Get.back();
                          //         }
                          //       }
                          //       ;
                          //     },
                          //     child: const Padding(
                          //       padding: EdgeInsets.symmetric(horizontal: 8),
                          //       child: Icon(
                          //         Icons.arrow_back,
                          //         size: 30,
                          //       ),
                          //     ),
                          //   ),
                          // ],
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
                        // ToolBar(
                        //   showBack: true,
                        //   showCartButton: false,
                        //   onBack: () async {
                        //     if (await flutterWebviewPlugin.canGoBack()) {
                        //       await flutterWebviewPlugin.goBack();
                        //     } else {
                        //       await flutterWebviewPlugin.close();
                        //       if (widget.paymentPlan != null) {
                        //         print('appBar start');
                        //       } else {
                        //         Get.back();
                        //       }
                        //     }
                        //   },
                        // ),
                        preferredSize: Size.fromHeight(kToolbarHeight)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
