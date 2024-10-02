import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:vendor/service/notification/notification.dart';
import 'package:vendor/utils/utility.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  kPrint('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    kPrint(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  NotificationService().showFlutterNotification(message);
  kPrint('Handling a background message ${message.messageId}');
}


Future<void> firebaseMessagingForegroundHandler() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    kPrint('Got a message whilst in the foreground!');
    kPrint('Message data: ${message.data}');

    if (message.notification != null) {
      NotificationService().showFlutterNotification(message);
      kPrint(
          'Message also contained a notification: ${message.notification}');
    }
  });
}