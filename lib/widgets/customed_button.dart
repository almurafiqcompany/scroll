import 'package:al_murafiq/extensions/extensions.dart';
import 'package:flutter/material.dart';

class CustomedButton extends StatelessWidget {
  const CustomedButton(
      {@required this.text,
      @required this.height,
      this.imageName,
      this.onPressed,
      this.textStyle});

  final String? text;
  final double? height;
  final String? imageName;
  final Function? onPressed;
  // final bool enable;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: LinearGradient(
            colors: <Color>[
              Colors.blueAccent,
              Colors.blue.shade800,
            ],
          )),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(15.0),
          //onTap: onPressed,
          onTap: () {},
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(text!,
                  style: textStyle ??
                      const TextStyle(color: Colors.white, fontSize: 17)),
              if (imageName != null)
                Image(
                  image: AssetImage(imageName!),
                  height: 50,
                  width: 55,
                  // color: Colors.white,
                )
            ],
          ),
        ),
      ),
    );
  }

  //bool _isEnable() => enable && onPressed != null;
}
