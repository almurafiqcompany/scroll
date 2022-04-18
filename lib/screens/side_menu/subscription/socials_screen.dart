import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/models/countries.dart';
import 'package:al_murafiq/models/subscription.dart';
import 'package:al_murafiq/screens/countries/countries_bloc.dart';
import 'package:al_murafiq/screens/home_page/company/socials/socials_screen.dart';
import 'package:al_murafiq/screens/home_page/nav_bar.dart';
import 'package:al_murafiq/screens/payment/eshtrakaty_screen.dart';
import 'package:al_murafiq/screens/side_menu/change_language/change_lang_bloc.dart';
import 'package:al_murafiq/screens/side_menu/subscription/subscription_bloc.dart';
import 'package:al_murafiq/utils/utils.dart';
import 'package:al_murafiq/widgets/show_check_login_dialog.dart';
import 'package:al_murafiq/widgets/show_loading_dialog.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SocialsMediaScreen extends StatefulWidget {

  @override
  _SocialsMediaScreenState createState() => _SocialsMediaScreenState();
}

class _SocialsMediaScreenState extends State<SocialsMediaScreen> {
  SubscriptionBloc _bloc = SubscriptionBloc();
  SharedPreferenceHelper helper = GetIt.instance.get<SharedPreferenceHelper>();
  @override
  void initState() {
    _bloc.fetchAllSubscription(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  GradientAppbar(title: 'side_social'.tr),
      body: SingleChildScrollView(
          physics: iosScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            child: Container(
              width: Get.width,
              height: Get.height*0.85,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                //gradient: kAdsHomeGradient,
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/social.png',
                    color: Colors.grey,
                    width: 120,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // Text(
                  //   // context.translate('select_country'),
                  //     'select_country'.tr,
                  //     style: TextStyle(color: Colors.white, fontSize: 20))
                  //     .addPaddingOnly(top: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                        'select_company'.tr,
                        style: TextStyle(color: Colors.black, fontSize: 16))
                        .addPaddingOnly(top: 5, bottom: 20),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade300,),
                            child: StreamBuilder<List<SubscriptionData>>(
                                stream: _bloc.allSubscriptionSubject.stream,
                                builder: (context, countriesSnapshot) {
                                  if (countriesSnapshot.hasData) {
                                    return StreamBuilder<SubscriptionData>(
                                        stream: _bloc.selectedSubscription.stream,

                                        builder: (context, snapshot) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 2),
                                            child: DropdownButton<
                                                SubscriptionData>(
                                                dropdownColor: Colors.white,
                                                iconEnabledColor: Colors.grey,
                                                iconSize: 32,
                                                elevation: 3,
                                                icon: Icon(Icons
                                                    .arrow_drop_down_outlined),
                                                items: countriesSnapshot.data
                                                    .map((item) {
                                                  return DropdownMenuItem<
                                                      SubscriptionData>(
                                                      value: item,
                                                      child: AutoSizeText(
                                                        item.name,
                                                        style:
                                                            kTextStyle.copyWith(
                                                                fontSize: 18),
                                                        minFontSize: 14,
                                                        maxFontSize: 18,
                                                      ));
                                                }).toList(),
                                                isExpanded: true,
                                                hint: Row(
                                                  children: [
                                                    Icon(Icons.emoji_flags),
                                                    Text(
                                                      'select_company'.tr,
                                                      // context.translate('select_country'),
                                                      style:
                                                          kTextStyle.copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ],
                                                ),
                                                style: kTextStyle.copyWith(
                                                    color: Colors.black),
                                                underline: SizedBox(),
                                                value: snapshot.data,
                                                onChanged:
                                                    (SubscriptionData item) {

                                                  // _bloc.selectedLanguage.sink.add(null);
                                                  _bloc.selectedSubscription.sink
                                                      .add(item);

                                                }),
                                          );
                                        });
                                  } else {
                                    return const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(
                                          child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                kAccentColor),
                                      )),
                                    );
                                  }
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),



                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: RoundedLoadingButton(
                      child: Text(
                        'bt_done'.tr,
                        // context.translate('bt_done'),
                        style: kTextStyle.copyWith(fontSize: 20,color: Color(0xffFFFFFF)),
                      ),
                      height: 50,
                      controller: _bloc.loadingButtonController,
                      color: Colors.blue.shade800,
                      onPressed: () async {
                        if(!_bloc.selectedSubscription.value.isNull){
                          _bloc.loadingButtonController.start();
                          await Get.to(SocialsScreen(
                            company_id: _bloc.selectedSubscription.value.id,
                          ));
                          _bloc.loadingButtonController.stop();
                        }


                      },
                    ),
                  ),


                ],
              ),
            ),
          )),
    );
  }
}
