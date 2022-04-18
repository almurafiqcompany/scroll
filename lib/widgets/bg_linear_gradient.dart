import 'package:al_murafiq/extensions/extensions.dart';
import 'package:flutter/material.dart';

class BGLinearGradient extends StatelessWidget {
  const BGLinearGradient({Key? key, this.color1, this.color2})
      : super(key: key);
  final Color? color1;
  final Color? color2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: const Alignment(0.4, 0.4),
          colors: <Color>[
            color2 ?? context.accentColor,
            color1 ?? context.primaryColor,
          ], // red to yellow
        ),
      ),
    );
  }
}
