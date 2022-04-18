import 'dart:io';

import 'package:al_murafiq/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
class ShowMessageEmtyDialog extends StatelessWidget {
  final String message;
  final String pathImg;

  const ShowMessageEmtyDialog({Key key, this.message, this.pathImg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: Get.height*0.71,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          //gradient: kAdsHomeGradient,
          color: Colors.white,
        ),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(pathImg,
                  height: Get.height*0.3,
                  width: Get.width*0.8,
                  color: Colors.grey.withOpacity(0.3),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(message,style: TextStyle(color: Colors.grey.withOpacity(0.8)),),
                ),
              ],
            )),
      ),
    );
  }
}
