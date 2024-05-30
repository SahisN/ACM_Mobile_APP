import 'dart:convert';
import 'package:acm_app/widget/local_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

// source: https://www.youtube.com/watch?v=A3M0N_B-CR0
// author: Mitch Koko (youtube channel)
// docs: https://pub.dev/packages/firebase_messaging/example

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print(
      'Title: ${message.notification?.title}, body: ${message.notification?.body}, payload: ${message.notification?.body}');
  LocalNotifications.showSimpleNotification(
      title: 'new update', body: 'update', payload: 'payload');

  // background message handler
  // Foreground message handler
  /**
    FirebaseMessaging.onMessage.listen(
      (message) {
        final notification = message.notification;
        // check if message is null
        if (notification == null) return;

        // if message is not null, show local notification
        _localNotifications.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                  _androidChannel.id, _androidChannel.name,
                  channelDescription: _androidChannel.description,
                  icon: 'ic_launcher'),
            ),
            payload: jsonEncode(
              message.toMap(),
            ));
      },
    );
    */
  Get.rawSnackbar(
    messageText: const Text(
      'New Update avaliable',
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
    ),
    isDismissible: false,
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.green[400]!,
    icon: const Icon(
      Icons.update,
      color: Colors.white,
      size: 35,
    ),
    margin: EdgeInsets.zero,
    snackStyle: SnackStyle.GROUNDED,
  );
}

void onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) async {
  // display a dialog with the notification details, tap ok to go to another page
}

class FirebaseApi {
  // create an instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // create andriod notification channel
  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is ued for important notification',
    importance: Importance.high,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  // function to initialize notifications
  Future<void> initNotification() async {
    // request permission from user
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // fetch the fcm token for this device
    final fcmToken = await _firebaseMessaging.getToken();
    print(fcmToken);

    //initPushNotifications();
    //initLocalNotifications();
  }

  // function to initalize background settings
  Future initPushNotifications() async {
    // set Foreground notification
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: false,
    );

    // handle notification if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // handle notification when app is running
    FirebaseMessaging.onMessage.listen(handleMessage);

    // attach event listeners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    // handle notification on background
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  // function to handle received messages
  void handleMessage(RemoteMessage? message) {
    /**
    navigatorKey.currentState
        ?.pushNamed(NotificationPage.route, arguments: message);
        */

    Get.rawSnackbar(
      messageText: const Text(
        'New Update avaliable',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      isDismissible: false,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green[400]!,
      icon: const Icon(
        Icons.update,
        color: Colors.white,
        size: 35,
      ),
      margin: EdgeInsets.zero,
      snackStyle: SnackStyle.GROUNDED,
    );
  }

  Future initLocalNotifications() async {
    const andriod = AndroidInitializationSettings('ic_launcher');

    const settings = InitializationSettings(android: andriod);
    print('hi');
    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        final message = RemoteMessage.fromMap(jsonDecode(payload as String));

        handleMessage(message);
      },
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidChannel);
  }
}
