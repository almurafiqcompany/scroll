import 'dart:io';

import 'package:al_murafiq/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';


class LoadingView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      color: Colors.transparent,
      child: Center(
        child: CircularProgressIndicator(
          valueColor:
           AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
        ),
      ),
    );
  }
}
