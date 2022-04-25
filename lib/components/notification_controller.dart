import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationController {
  static final NotificationController? _singleton =
      NotificationController._internal();
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationDetails? platformChannelSpecifics;

  factory NotificationController() {
    return _singleton!;
  }

  NotificationController._internal() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('splash');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    notificationsPlugin.initialize(initializationSettings);
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            enableVibration: true);
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails();
    platformChannelSpecifics = const NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
  }
}
