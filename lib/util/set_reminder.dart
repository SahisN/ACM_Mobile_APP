import 'package:acm_app/model/event_item.dart';
import 'package:acm_app/controller/notification_controller.dart';

void setNotification(EventItem event) {
  NotificationController.showNotification(
      id: event.uid.hashCode,
      title: event.name,
      body: event.description == '' ? '' : event.description,
      channelKey: 'event',
      year: event.dateTime.year,
      month: event.dateTime.month,
      days: event.dateTime.day,
      hours: event.dateTime.hour == 0 ? 9 : event.dateTime.hour,
      minutes: event.dateTime.minute);
}

void cancelNotification(EventItem event) {
  NotificationController.cancelNotifications(event.uid.hashCode);
}

void allowNotification(bool notification) {
  if (notification) {
  } else {
    NotificationController.cancelAllNotifications();
  }
}
