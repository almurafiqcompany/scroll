import 'package:flutter/material.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:get/get.dart';
class PayOffline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text('hatef'.tr,
                style: const TextStyle(fontSize: 30)),
          ).addPaddingOnly(top: 50, bottom: 30, right: 50),
          Text('hatef'.tr,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
              .addPaddingOnly(bottom: 5, right: 15),
          const TextFieldOutlineBorder(
              hintText: '',
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next),
          Text('re-hatef'.tr,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
              .addPaddingOnly(bottom: 5, right: 15, top: 20),
          const TextFieldOutlineBorder(
              hintText: '',
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next),
          const Spacer(),
          CustomedButton(text: 'btn-offline'.tr, height: 55),
          const Spacer(),
        ],
      ).addPaddingHorizontalVertical(horizontal: 50),
    );
  }
}
