import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount({Key? key, this.textColor}) : super(key: key);

  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('question_login'.tr,
            style: TextStyle(color: textColor ?? Colors.white, fontSize: 18)),
        InkWell(
          onTap: () => Get.to(LoginScreen()),
          //Navigator.pushNamed(context, PageRouteName.LOGIN),
          child: Text(
            'login'.tr,
            style: const TextStyle(color: Colors.green, fontSize: 18),
          ),
        )
      ],
    );
  }
}
