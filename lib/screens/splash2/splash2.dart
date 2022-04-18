import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/screens/register_delegate/register_delegate_screen.dart';
import 'package:al_murafiq/screens/register_merchant/register_merchant_screen.dart';
import 'package:al_murafiq/screens/register_user-delegate/register_screen.dart';
import 'package:al_murafiq/utils/scroll_physics_like_ios.dart';
import 'package:al_murafiq/utils/utils.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
class Splash2 extends StatefulWidget {
  @override
  _Splash2State createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const BGLinearGradient(),
          SingleChildScrollView(
            // physics: iosScrollPhysics(),
            child: Container(
              width: Get.width,
              height: Get.height,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height * .20,),
                    Image.asset(
                      Assets.APP_LOGO,
                    ),
                    Text('are_you'.tr,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18))
                        .addPaddingOnly(top: 50, bottom: 20),
                    GradientBtn(
                            text: 'new_user'.tr,
                            textStyle: const TextStyle(
                                color: Colors.white, fontSize: 18),
                            onPressed: () => RegisterScreen(),
                                // Navigator.pushNamed(
                                // context, PageRouteName.REGISTER,
                                // arguments: 'Customer'),
                            imageName: Assets.GROUP)
                        .addPaddingHorizontalVertical(
                            horizontal: 20, vertical: 15),
                    GradientBtn(
                            text: 'Marketer'.tr,
                            textStyle: const TextStyle(
                                color: Colors.white, fontSize: 18),
                            onPressed: () => RegisterDelegateScreen(),
                                // Navigator.pushNamed(
                                // context, PageRouteName.REGISTER,
                                // arguments: 'Marketer'),
                            imageName: Assets.DELIVERY)
                        .addPaddingHorizontalVertical(
                            horizontal: 20, vertical: 15),
                    GradientBtn(
                            text: 'dealer'.tr,
                            textStyle: const TextStyle(
                                color: Colors.white, fontSize: 18),
                            onPressed: ()  => RegisterMerchantScreen(),
                                // Navigator.pushNamed(
                                // context, PageRouteName.REGISTER_MERCHANT),
                            imageName: Assets.SHOP)
                        .addPaddingHorizontalVertical(
                            horizontal: 20, vertical: 15),
                    const AlreadyHaveAnAccount()
                        .addPaddingOnly(top: 20, bottom: 20)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
