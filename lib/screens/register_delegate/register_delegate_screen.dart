import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/screens/register_delegate/account_delegate_screen.dart';
import 'package:al_murafiq/screens/register_delegate/personal_delegate_screen.dart';
import 'package:al_murafiq/screens/register_delegate/register_delegate_bloc.dart';
import 'package:al_murafiq/core/service_locator.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:get/get.dart';

class RegisterDelegateScreen extends StatefulWidget {
  @override
  _RegisterDelegateScreenState createState() => _RegisterDelegateScreenState();
}

class _RegisterDelegateScreenState extends State<RegisterDelegateScreen> {
  RegisterDelegateBloc _bloc = RegisterDelegateBloc();
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
                length: 2,
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
                          unselectedLabelStyle: TextStyle(fontSize: 15),
                          labelStyle: TextStyle(fontSize: 15),
                          labelColor: Colors.black,
                          tabs: <Widget>[
                            Text('personal_info'.tr),
                            Text('account_details'.tr),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: <Widget>[
                              PersonalInformationDelegateScreen(
                                bloc: _bloc,
                              ),
                              AccountInformationDelegateScreen(
                                bloc: _bloc,
                              ),
                            ],
                          ),
                        ),
                        if (snapshot.data == 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: RoundedLoadingButton(
                              child: Text(
                                'bt_continue'.tr,
                                style: kTextStyle.copyWith(color: Colors.white),
                              ),
                              height: 50,
                              controller: _bloc.loadingButtonController,
                              color: Colors.blue.shade800,
                              onPressed: () async {
                                _bloc.loadingButtonController.start();
                                // await BackgroundLocation.startLocationService();
                                // BackgroundLocation.getLocationUpdates(
                                //         (location) {
                                //       _bloc.longSubject.sink
                                //           .add(location.longitude);
                                //       _bloc.latSubject.sink.add(location.latitude);
                                //       // setState(() {
                                //       //   this.latitude =
                                //       //       location.latitude.toString();
                                //       //   this.longitude =
                                //       //       location.longitude.toString();
                                //       //   this.accuracy =
                                //       //       location.accuracy.toString();
                                //       //   this.altitude =
                                //       //       location.altitude.toString();
                                //       //   this.bearing = location.bearing.toString();
                                //       //   this.speed = location.speed.toString();
                                //       //   this.time =
                                //       //       DateTime.fromMillisecondsSinceEpoch(
                                //       //               location.time.toInt())
                                //       //           .toString();
                                //       // }
                                //       // );
                                //       //             print('''\n
                                //       //   Latitude:  $latitude
                                //       //   Longitude: $longitude
                                //       //   Altitude: $altitude
                                //       //   Accuracy: $accuracy
                                //       //   Bearing:  $bearing
                                //       //   Speed: $speed
                                //       //   Time: $time
                                //       // ''');
                                //     });
                                _bloc.longSubject.sink
                                    .add(await _helper.getLng());
                                _bloc.latSubject.sink
                                    .add(await _helper.getLat());
                                _bloc.tapBarSubject.sink.add(1);

                                _bloc.loadingButtonController.stop();
                              },
                            ),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: RoundedLoadingButton(
                              child: Text(
                                'bt_submit'.tr,
                                style: kTextStyle.copyWith(color: Colors.white),
                              ),
                              height: 50,
                              controller: _bloc.loadingButtonController,
                              color: Colors.blue.shade800,
                              onPressed: () async {
                                _bloc.loadingButtonController.start();

                                await _bloc.confirmSignUp(context);

                                _bloc.loadingButtonController.stop();
                              },
                            ),
                          )
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
