import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/utils/utils.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:rive_loading/rive_loading.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:al_murafiq/screens/home_page/nav_bar.dart';
import 'package:al_murafiq/screens/countries/countries_screen.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:get_it/get_it.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Get.offAll(StreamBuilder<int?>(
            // ignore: always_specify_types
            stream: Stream.fromFuture(getIsCountryId()),
            builder: (BuildContext context, AsyncSnapshot<int?> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return BottomNavBar();
              } else {
                return CountriesScreen();
              }
            })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const BGLinearGradient(
            color1: Color(0xff034187),
            color2: Color(0xff034187),
          ),
          SingleChildScrollView(
            // physics: iosScrollPhysics(),
            child: Container(
              width: Get.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Image.asset(
                  //   Assets.APP_LOGO,
                  // ),
                  // Expanded(
                  //   child: FlareActor(
                  //     'assets/images/SuccessCheck.flr',
                  //     animation: 'Untitled',
                  //     // animation: 'anim',
                  //
                  //   ),
                  // ),
                  Expanded(
                    child: RiveLoading(
                      name: 'assets/images/almurafiq.riv',
                      // startAnimation: 'anim',
                      loopAnimation: 'anim',
                      width: Get.width * 0.5,
                      height: Get.height * 0.3,
                      onError: (error, stacktrace) {
                        print(error);
                      },
                      onSuccess: (data) {
                        print('sucess $data');
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  SharedPreferenceHelper helper = GetIt.instance.get<SharedPreferenceHelper>();
  Future<int?> getIsCountryId() async {
    return await helper.getCountryId();
  }
}
