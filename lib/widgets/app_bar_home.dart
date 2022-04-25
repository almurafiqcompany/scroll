import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/screens/splash2/splash2.dart';
import 'package:al_murafiq/theme.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:al_murafiq/constants.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:al_murafiq/extensions/extensions.dart';

class AppBarHome extends StatelessWidget {
  final String? title;

  final Color? color1;
  final Color? color2;
  final List<Widget>? actions;

  AppBarHome({Key? key, this.title, this.color1, this.color2, this.actions})
      : super(key: key);
  SharedPreferenceHelper helper = GetIt.instance.get<SharedPreferenceHelper>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Stack(
            children: [
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
              StreamBuilder<String?>(
                  stream: Stream.fromFuture(getIsLogIn()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return const SizedBox();
                    } else {
                      return Positioned(
                        left: 20,
                        top: 35,
                        child: GestureDetector(
                            onTap: () async {
                              print(await helper.getToken());
                              Get.to(Splash2());
                            },
                            child: AutoSizeText(
                              // context.translate('login'),
                              'login'.tr,
                              maxFontSize: 18,
                              minFontSize: 14,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                      );
                    }
                  }),
              Positioned(
                right: 20,
                top: 35,
                child: GestureDetector(
                    onTap: () async {},
                    child: AutoSizeText(
                      'al_murafiq'.tr,
                      maxFontSize: 18,
                      minFontSize: 14,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
              ),
            ],
          ),
          Container(
            width: double.maxFinite,
            height: 6,
            color: Colors.lime,
          ),
        ],
      ),
    );
  }

  Future<String?> getIsLogIn() async {
    return await helper.getToken();
  }
}
