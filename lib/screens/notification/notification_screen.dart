import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/notification.dart' as not;
import 'package:al_murafiq/screens/home_page/search/search_screen.dart';
import 'package:al_murafiq/screens/notification/notification_bloc.dart';
import 'package:al_murafiq/widgets/gradient_appbar.dart';
import 'package:al_murafiq/widgets/show_message_emty_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:al_murafiq/screens/home_page/nav_bar.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationBloc _notificationBloc = NotificationBloc();
  @override
  void initState() {
    _notificationBloc.fetchAllNotifications();
    // TODO: implement initState
    super.initState();
    // setNotf();
  }

  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  Future<void> setNotf() async {
    try {
      await _helper.setNumberOfNotfiction(0);
      print('w ${await _helper.getNumberOfNotfiction()}');
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      print('error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: GradientAppbar(),
      body: RefreshIndicator(
        onRefresh: () async {
          await _notificationBloc.fetchAllNotifications();
          return Future.delayed(Duration(milliseconds: 400));
        },
        child: StreamBuilder<not.Notifications>(
            stream: _notificationBloc.dataofNotificationsSubject.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                setNotf();
                if (snapshot.data!.notification!.length > 0) {
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: Get.height * 0.1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF03317C),
                                Color(0xFF05B3D6),
                              ],
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.offAll(BottomNavBar());
                                  },
                                  child: Icon(
                                    Get.locale!.languageCode == 'ar'
                                        ? MdiIcons.chevronRight
                                        : MdiIcons.chevronLeft,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          reverse: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.notification!.length,
                          itemBuilder: (BuildContext context, int index) =>
                              BuildNotifictinCard(
                                  snapshot.data!.notification![index]),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SizedBox(
                      height: Get.height,
                      child: Center(
                          child: Column(
                        children: [
                          Icon(
                            Icons.notifications_off,
                            size: 40,
                            color: Colors.grey.withOpacity(0.7),
                          ),
                          Text(
                            'Not Found Notification',
                          ),
                        ],
                      )));
                }
              } else if (snapshot.hasError) {
                return Center(
                    child: ShowMessageEmtyDialog(
                  message: 'snapshot.error',
                  pathImg: 'assets/images/noNotification.png',
                ));
              } else {
                return SizedBox(
                    height: Get.height,
                    child: const Center(
                        child: CircularProgressIndicator(
                      backgroundColor: kPrimaryColor,
                    )));
              }
            }),
      ),
    );
  }

  Widget BuildNotifictinCard(not.Notification notification) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
          // height: 80,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          notification.title!,
                          style: TextStyle(fontSize: 17),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      '${notification.time}',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ReadMoreText(
                '${notification.data}',
                trimLines: 2,
                colorClickableText: Colors.blue,
                trimMode: TrimMode.Line,
                trimCollapsedText: ' ▼',
                trimExpandedText: '▲',
                style: kTextStyle.copyWith(
                  fontSize: 13,
                ),
              ),
            ],
          )),
    );
  }
}
