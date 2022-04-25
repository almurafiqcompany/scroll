import 'dart:io';

import 'package:al_murafiq/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
class ShowMessageDialog extends StatelessWidget {
  final String? message;
  final int? type;
  final bool? show_but;


  RoundedLoadingButtonController loadingButtonController =
  RoundedLoadingButtonController();

   ShowMessageDialog({Key? key, this.message, this.type, this.show_but}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffFFFFFF),
      height: Get.height*0.4,
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
                    width: 100,
                    height: Get.height/8,
                    child:  Image(
                      image: type==200? const AssetImage(
                        'assets/images/checkDone.png',
                      ) : const AssetImage(
                          'assets/images/warring.png',
                      ),
                    )
                ),
              ),
              const SizedBox(height: 5,),
                 Container(
                   height: Get.height/6,
                   child: Center(
                     child: SingleChildScrollView(
                       child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child:  Text(message!,textAlign: TextAlign.center,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
              ),
                     ),
                   ),
                 ),

              const SizedBox(height: 5,),


             if (show_but!) ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xff2E5BFF),
                    padding: EdgeInsets.symmetric(horizontal: (Get.width/3), vertical: 10),
                    textStyle: TextStyle(
                      fontSize: 14,
                    )),
                child:  Text('bt_done'.tr),
                onPressed: () async =>  Get.back(),
              ) else SizedBox(),

            ],
          ),
        ),
      ),
    );
  }
}
