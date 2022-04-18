
import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/screens/splash2/splash2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:al_murafiq/extensions/extensions.dart';
class NeedToLogin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return Container(
        height: (Get.height/2)+30,
        width: Get.width-30,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(

          gradient: kButtonGradient,
          borderRadius: BorderRadius.circular(15.00),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/app_logo.png",
              width: Get.width/2,
              height: Get.height/4,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal:  15,
                  vertical: 15),
              child: Text(
                "${'you_must_login_to_access'.tr}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 15,
                  color: Color(0xffffffff),
                ),
              ),
            ),
            RawMaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              onPressed: () =>
                  Get.to(Splash2()),
              fillColor: kPrimaryColor,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:  25,
                    vertical: 11),
                child: Text(
                  'login'.tr,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      );

  }
}
