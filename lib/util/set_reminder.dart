import 'package:acm_app/model/event_item.dart';
import 'package:acm_app/controller/notification_controller.dart';
import 'package:acm_app/provider/state_provider.dart';
import 'package:acm_app/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void setNotification(EventItem event, BuildContext context) {
  late List<int> timeState =
      Provider.of<StateProvider>(context, listen: false).time;

  NotificationController.showNotification(
      id: event.uid.hashCode,
      title: event.name,
      body: event.description == '' ? '' : event.description,
      channelKey: 'event',
      year: event.dateTime.year,
      month: event.dateTime.month,
      days: event.dateTime.day + timeState[0],
      hours: event.dateTime.hour == 0 ? 9 : event.dateTime.hour + timeState[1],
      minutes: event.dateTime.minute + timeState[2]);
}

void cancelNotification(EventItem event) {
  NotificationController.cancelNotifications(event.uid.hashCode);
}

Future<void> enableNotification(bool notification, BuildContext context) async {
  if (notification) {
    final events = await UserPreferences.getFavoriteEvents();

    if (events.isNotEmpty) {
      await Future.wait(events.map((event) async {
        setNotification(event, context);
      }));
    }
  } else {
    NotificationController.cancelAllNotifications();
  }
}
