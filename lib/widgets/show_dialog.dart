import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
class CustomDialog {
  static void showWithOk(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.right,
          ),
          content: Text(
            message,
            textAlign: TextAlign.right,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'ok'.tr,
                style: const TextStyle(fontSize: 18),
              ),
              onPressed: () => hideDialog(context),
            ),
          ],
        );
      },
    );
  }

  static Future<BuildContext> showProgressDialog(
      BuildContext contextToShow) async {
    BuildContext contextForHide;
    // ignore: unawaited_futures
    showDialog(
      context: contextToShow,
      barrierDismissible: false,
      builder: (BuildContext context) {
        contextForHide = context;
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const ShowProgress(),
              Text('please_wait'.tr),
            ],
          ),
        );
      },
    );
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    //workaround to wait builder to make context
    return contextForHide;
  }

  static void hideDialog(BuildContext context) => Navigator.pop(context);
}
