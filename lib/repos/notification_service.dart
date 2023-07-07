import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  void checkIfNotificationsAllowed() {
    AwesomeNotifications().isNotificationAllowed().then(
      (allowed) {
        if (!allowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );
  }

  void initNotifications(
      {required String channelKey,
      required String channelName,
      required String channelDescription}) {
    checkIfNotificationsAllowed();
    AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelKey: channelKey,
              channelName: channelName,
              channelDescription: channelDescription)
        ],
        debug: true);
  }

  void showNotification(
      {required int id,
      required String channelKey,
      required String title,
      required String body}) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: id,
          channelKey: channelKey,
          title: title,
          body: body,
          fullScreenIntent: true),
    );
  }
}
