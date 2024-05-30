import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// source: https://www.youtube.com/watch?v=--PQXg_mx9I&t=238s
// author Snehasis Ghosh

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future init() async {
    // andriod settings
    const AndroidInitializationSettings initializationSettingsAndriod =
        AndroidInitializationSettings('ic_launcher');
    // ios settings
    final DarwinInitializationSettings initializationSettingsDrawin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => null,
    );
    // linux settings
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    // initalize all platform notification settings
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndriod,
            iOS: initializationSettingsDrawin,
            linux: initializationSettingsLinux);

    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (details) => null,
    );
  }

  // show a simple local notification
  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    // create andriod notification channel
    const AndroidNotificationDetails andriodNotificationDetails =
        AndroidNotificationDetails('channel_id', 'channel_name',
            channelDescription: 'channel_description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: andriodNotificationDetails);

    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }
}
