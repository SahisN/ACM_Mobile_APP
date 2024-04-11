import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// source: https://www.youtube.com/watch?v=A3M0N_B-CR0
// author: Mitch Koko (youtube channel)
// docs: https://pub.dev/packages/firebase_messaging/example

class FirebaseApi {
  // create an instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

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
  }

  // function to initalize background settings
  Future initPushNotifications() async {
    // handle notification if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // attach event listeners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    FirebaseMessaging.onBackgroundMessage(
        (message) => _firebaseBackgroundMessage(message));
  }

  // function to handle received messages
  void handleMessage(RemoteMessage? message) {
    if (message == null) {
      return;
    }

    Get.rawSnackbar(
      messageText: const Text(
        'New update avaliable',
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

  Future _firebaseBackgroundMessage(RemoteMessage? message) async {
    if (message == null) {
      return;
    }
    Get.rawSnackbar(
      messageText: const Text(
        'New update avaliable',
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
}
