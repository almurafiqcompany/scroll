import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/screens/register_merchant/register_merchant_bloc.dart';
import 'package:al_murafiq/screens/side_menu/side_menu_bloc.dart';

import 'package:al_murafiq/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:get/get.dart';
class BeAffilaorScreen extends StatefulWidget {

  @override
  _RegisterDealerScreenState createState() => _RegisterDealerScreenState();
}

class _RegisterDealerScreenState
    extends State<BeAffilaorScreen> {
  SideMenuBloc sideMenuBloc=SideMenuBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GradientAppbar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[



              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: RoundedLoadingButton(
                  child: Text(
                      'side_be_affilator'.tr,
                    style: kTextStyle.copyWith(color: Colors.white),
                  ),
                  height: 50,
                  controller: sideMenuBloc.loadingButtonController,
                  color: Colors.blue.shade800,
                  onPressed: () async {
                    sideMenuBloc.loadingButtonController.start();

                    await sideMenuBloc.BeAffilator(context);

                    sideMenuBloc.loadingButtonController.stop();
                  },
                ),
              )
            ],
          ).addPaddingHorizontalVertical(horizontal: 30),
        ));
  }
}
