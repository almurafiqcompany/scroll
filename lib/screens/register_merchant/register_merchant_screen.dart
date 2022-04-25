import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/screens/register_merchant/account_merchant_screen.dart';
import 'package:al_murafiq/screens/register_merchant/personal_merchant_screen.dart';
import 'package:al_murafiq/screens/register_merchant/register_merchant_bloc.dart';

import 'package:al_murafiq/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:get/get.dart';

class RegisterMerchantScreen extends StatefulWidget {
  @override
  _RegisterMerchantScreenState createState() => _RegisterMerchantScreenState();
}

class _RegisterMerchantScreenState extends State<RegisterMerchantScreen> {
  RegisterMerchantBloc _bloc = RegisterMerchantBloc();

  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder<int>(
            stream: _bloc.tapBarSubject.stream,
            initialData: 0,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return DefaultTabController(
                key: UniqueKey(),
                length: 1,
                initialIndex: snapshot.data!,
                child: Scaffold(
                    appBar: const GradientAppbar(),
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('new_account'.tr,
                                style: const TextStyle(fontSize: 30))
                            .addPaddingOnly(right: 44, left: 44, top: 10),
                        const SizedBox(height: 10),
                        TabBar(
                          unselectedLabelColor: Colors.grey,
                          unselectedLabelStyle: TextStyle(fontSize: 14),
                          labelStyle: TextStyle(fontSize: 14),
                          labelColor: Colors.black,
                          tabs: <Widget>[
                            // Text('personal_info'.tr),
                            Text('account_details'.tr),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: <Widget>[
                              // PersonalInformationMerchantScreen(
                              //   bloc: _bloc,
                              // ),
                              AccountInformationMerchantScreen(
                                bloc: _bloc,
                              ),
                            ],
                          ),
                        ),
                        //   if (snapshot.data == 0)
                        //     Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 25),
                        //       child: RoundedLoadingButton(
                        //         child: Text(
                        //           'bt_continue'.tr,
                        //           style: kTextStyle.copyWith(color: Colors.white),
                        //         ),
                        //         height: 50,
                        //         controller: _bloc.loadingButtonController,
                        //         color: Colors.blue.shade800,
                        //         onPressed: () async {
                        //           _bloc.loadingButtonController.start();
                        //           // await BackgroundLocation.setNotificationTitle(
                        //           //     "Background service running");
                        //           // await BackgroundLocation.startLocationService();
                        //           BackgroundLocation.getLocationUpdates(
                        //               (location) {
                        //             _bloc.longSubject.sink
                        //                 .add(location.longitude);
                        //             _bloc.latSubject.sink.add(location.latitude);
                        //             // setState(() {
                        //             //   this.latitude =
                        //             //       location.latitude.toString();
                        //             //   this.longitude =
                        //             //       location.longitude.toString();
                        //             //   this.accuracy =
                        //             //       location.accuracy.toString();
                        //             //   this.altitude =
                        //             //       location.altitude.toString();
                        //             //   this.bearing = location.bearing.toString();
                        //             //   this.speed = location.speed.toString();
                        //             //   this.time =
                        //             //       DateTime.fromMillisecondsSinceEpoch(
                        //             //               location.time.toInt())
                        //             //           .toString();
                        //             // }
                        //             // );
                        // //             print('''\n
                        // //   Latitude:  $latitude
                        // //   Longitude: $longitude
                        // //   Altitude: $altitude
                        // //   Accuracy: $accuracy
                        // //   Bearing:  $bearing
                        // //   Speed: $speed
                        // //   Time: $time
                        // // ''');
                        //           });
                        //           print(_bloc.tapBarSubject.value);
                        //           print(_bloc.longSubject.value);
                        //           print(_bloc.latSubject.value);
                        //
                        //           _bloc.tapBarSubject.sink.add(1);
                        //           print(_bloc.nameSubject.value);
                        //           print(_bloc.tapBarSubject.value);
                        //
                        //           _bloc.loadingButtonController.stop();
                        //         },
                        //       ),
                        //     )
                        //   else
                        //     // Padding(
                        //     //   padding: const EdgeInsets.symmetric(vertical: 30),
                        //     //   child: RoundedLoadingButton(
                        //     //     child: Text(
                        //     //       context.translate('cont'),
                        //     //       style: kTextStyle.copyWith(color: Colors.white),
                        //     //     ),
                        //     //     height: 50,
                        //     //     controller: _bloc.loadingButtonController,
                        //     //     color: Colors.blue.shade800,
                        //     //     onPressed: () async {
                        //     //       _bloc.loadingButtonController.start();
                        //     //
                        //     //     //  await _bloc.confirmSignUp(context);
                        //     //     await Get.to(PersonalInformationDealerPageTwoScreen(bloc: _bloc,));
                        //     //       _bloc.loadingButtonController.stop();
                        //     //     },
                        //     //   ),
                        //     // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: Center(
                            child: FlatButton(
                                height: 55,
                                minWidth: Get.width - 110,
                                child: Text('bt_continue'.tr,
                                    style: kTextStyle.copyWith(
                                        color: Colors.white, fontSize: 22)),
                                color: Colors.blue.shade800,
                                textColor: Color(0xffFFFFFF),
                                onPressed: () async {
                                  // await Get.to(AccountInformationDealerPageTwoScreen(bloc: _bloc,));
                                  //lng:await _helper.getLng(),lat: await _helper.getLat()
                                  _bloc.longSubject.sink
                                      .add(await _helper.getLng());
                                  _bloc.latSubject.sink
                                      .add(await _helper.getLat());
                                  _bloc.accountDealerPageOne(context, _bloc);
                                },
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0))),
                          ),
                        ),
                      ],
                    ).addPaddingHorizontalVertical(horizontal: 30)),
              );
            }),
        const Positioned(
            right: 30,
            top: 70,
            child: Image(
              image: AssetImage('assets/images/sign.png'),
            )),
      ],
    );
  }
}
