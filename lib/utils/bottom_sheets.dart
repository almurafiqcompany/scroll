import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BottomSheetS {
  static void displayOkBottomSheet(BuildContext context, String message) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            height: context.height * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 64,
                  ),
                  decoration: BoxDecoration(
                    // color:  Colors.green ,
                    border: Border.all(width: 5.0, color: Colors.green),
                    borderRadius: const BorderRadius.all(Radius.circular(36.0)),
                  ),
                ),
                Text(
                  message,
                  style: const TextStyle(fontSize: 32),
                ),
                GradientBtn(
                  text: 'تم',
                  onPressed: () => Navigator.pop(context),
                ).addPaddingHorizontalVertical(horizontal: 28, vertical: 8)
              ],
            ),
          );
        });
  }
}