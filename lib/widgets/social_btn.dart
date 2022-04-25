import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class SocialButton extends StatelessWidget {
  const SocialButton(
      {@required this.decorationColor,
      @required this.text,
      @required this.iconColor,
      @required this.icon,
      this.fontWeight,
      this.border,
      this.onPress,
      @required this.textColor});
  final Color? decorationColor;
  final Color? textColor;
  final Color? iconColor;
  final String? text;
  final FontWeight? fontWeight;
  final IconData? icon;
  final Border? border;
  final Function? onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      // onTap:
      // onPress,
      //     () {
      //   _loginWithFB();
      // },
      child: Container(
        alignment: Alignment.center,
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: decorationColor,
            border: border),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(text!,
                style: TextStyle(
                    color: textColor, fontWeight: fontWeight, fontSize: 15)),
            const SizedBox(width: 10),
            FaIcon(
              icon,
              color: iconColor,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
