import 'package:al_murafiq/components/notification_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotifications {
  FirebaseMessaging? _fcm;
  Future<String> generateFcmToken() async {
    _fcm = FirebaseMessaging.instance;
    final fcm_token = await _fcm!.getToken();
    if (fcm_token != null) {
      print('fcm_token  ${fcm_token}');
      return fcm_token;
    }
    return '';
  }

  Future<void> configFcm() async {
    _fcm = FirebaseMessaging.instance;
    print('message of fcm ');

    // if(Platform.isIOS){
    //   await NotificationPermissions
    //       .requestNotificationPermissions(
    //       iosSettings:
    //       const NotificationSettingsIos(
    //           sound: true,
    //           badge: true,
    //           alert: true));
    // }

    // _fcm.configure(onMessage: (Map<String, dynamic>? message) async {
    //   print('message of fcm $message');
    //   if (message != null && message['notification'] != null) {
    //     print('message of fcm $message');
    //     await NotificationController().notificationsPlugin.show(
    //         0,
    //         message['notification']['title'],
    //         message['notification']['body'],
    //         NotificationController().platformChannelSpecifics);
    //   }
    //   return ;
    // });

    // await _fcm.requestNotificationPermissions(
    //     const IosNotificationSettings(
    //         sound: true, badge: true, alert: true, provisional: true));
    //
    //

    // _fcm.configure(
    //   onBackgroundMessage: Platform.isAndroid ? backGroundMessageHandler : null,
    //   onMessage: (Map<String, dynamic> message) async {
    //     showNotification(message);
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     showNotification(message);
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     showNotification(message);
    //   },
    // );
  }

  Future<dynamic> backGroundMessageHandler(Map<String, dynamic> message) async {
    if (message.containsKey('notification')) {
      final dynamic notification = message['notification'];
      showNotification(notification);
    }
    if (message.containsKey('data')) {
      final dynamic data = message['data'];
      showNotification(data);
    }
  }

  // ignore: always_specify_types
  Future showNotification(Map<String, dynamic> message) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('splash');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('Al-Murafiq', 'Al-Murafiq Notifications',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails();
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        message['notification']['title'].toString(),
        message['notification']['body'].toString(),
        platformChannelSpecifics,
        payload: 'item x');
  }
}
