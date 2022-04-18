import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GradientBtn extends StatelessWidget {
  const GradientBtn(
      {Key key,
      @required this.text,
      this.onPressed,

      this.textStyle,
      this.iconColor,
      this.imageName})
      : super(key: key);

  final String text;
  // ignore: always_specify_types, prefer_typing_uninitialized_variables
  final  onPressed;

  final TextStyle textStyle;
  final String imageName;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: const LinearGradient(
          colors: <Color>[
            Color( 0xff339DFA ),
            Color(0xff0367CC ),
          ],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {Get.to(onPressed());},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                text,
                style: textStyle ?? buttonTextStyle,
              ).addPaddingOnly(left: 10,right: 10),
              if (imageName != null)
                Image(
                 image: AssetImage(imageName),
                  height: 50,
                  width: 30,
                  color: iconColor ?? Colors.white,
                ).addPaddingOnly(right: 10,left: 10)
            ],
          ),
        ),
      ),
    );
  }

//  bool _isEnable() => enable && onPressed != null;
}
