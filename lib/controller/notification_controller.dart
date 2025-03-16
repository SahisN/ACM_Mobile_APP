import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {}

  // Use this method to schedule notification
  static Future<void> showNotification({
    required final int id,
    required final String title,
    required final String body,
    required final String channelKey,
    final String? summary,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final Map<String, String>? payload,
    required final int year,
    required final int month,
    required final int days, // 21
    required final int hours, // 16
    required final int minutes, // 24
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: id,
          channelKey: 'event_group',
          title: title,
          body: body,
          payload: payload),
      schedule: NotificationCalendar(
        allowWhileIdle: true,
        year: year,
        month: month,
        day: days,
        hour: hours,
        minute: minutes,
      ),
    );
  }

  // Use this method to cancel specific notification with notificationId
  // notificationId should correspond to eventId in event_details widget
  static Future<void> cancelNotifications(final int notificationId) async {
    await AwesomeNotifications().cancel(notificationId);
  }

  // Use this method to cancel all notification
  static Future<void> cancelAllNotifications() async {
    await AwesomeNotifications().cancelAll();
  }
}
