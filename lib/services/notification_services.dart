import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationServices {
  // source: https://www.youtube.com/watch?v=uZvWY1VGnZU, author: coding orbit
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'high_importance_channel',
          channelKey: 'high_importance_channel',
          channelName: 'Event Reminder',
          channelDescription: 'Test notifcation channel',
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'high_importance_channel_group',
          channelGroupName: 'event_group',
        )
      ],
      debug: true,
    );

    // check if the app has notification permission
    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      // if app does not have notification permission then ask for permission
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }
}
