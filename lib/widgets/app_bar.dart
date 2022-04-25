import 'package:al_murafiq/theme.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:al_murafiq/constants.dart';

class AppBarAllScreen extends StatelessWidget {
  final String? title;

  final Color? color1;
  final Color? color2;
  final List<Widget>? actions;

  const AppBarAllScreen(
      {Key? key, this.title, this.color1, this.color2, this.actions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            left: 30,
            top: 30,
            child: Icon(
              Icons.location_on,
              size: 40,
              color: Colors.amber,
            )),
        Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 75,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      color1 ?? const Color(0xFF03317C),
                      color2 ?? const Color(0xFF05B3D6),
                    ],
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
      ],
    );
  }
}
