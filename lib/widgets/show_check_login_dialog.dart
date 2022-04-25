import 'dart:io';

import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/screens/login/login_screen.dart';
import 'package:al_murafiq/screens/splash2/splash2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
class ShowCheckLoginDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffFFFFFF),
      height: Get.height*0.37,

      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Container(
                    width: Get.width/2,
                    height: Get.height/8,
                    child:  const Image(
                      image:   AssetImage(
                        'assets/images/Logo.png',
                      ),

                    )
                ),
              ),
              const SizedBox(height: 5,),
                 Container(
                   height: Get.height/10,
                   child: SingleChildScrollView(
                     child: Center(
                       child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                        child:  Text('you_must_login_to_access'.tr,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              ),
                     ),
                   ),
                 ),

              const SizedBox(height: 5,),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(

                      height: 50,
                      minWidth: Get.width/3,
                      child: Text('bt_cancel'.tr, style: kTextStyle.copyWith(fontSize: 18)),
                      color: Color(0xffd39e00),
                      textColor: Color(0xff000000),
                      onPressed: () async {
                         Get.back();
                      },
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0))
                  ),
                  FlatButton(

                      height: 50,
                      minWidth: Get.width/3,
                      child: Text('login'.tr, style: kTextStyle.copyWith(fontSize: 18)),
                      color: Colors.blue.shade800,
                      textColor: Color(0xffFFFFFF),
                      onPressed: () async {
                        await Get.offAll(Splash2());
                      },
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0))
                  ),

                ],
              )
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 30),
              //   child: RoundedLoadingButton(
              //     child: Text(
              //       context.translate('bt_done'),
              //       style: kTextStyle.copyWith(fontSize: 20),
              //     ),
              //     height: 50,
              //     controller: loadingButtonController,
              //     color: Colors.blue.shade800,
              //     onPressed: () async {
              //       loadingButtonController.start();
              //       Get.back();
              //       loadingButtonController.stop();
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
