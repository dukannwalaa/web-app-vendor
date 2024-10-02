import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:vendor/model/order.dart';
import 'package:vendor/service/notification/channels.dart';
import 'package:vendor/service/notification/listeners.dart';
import 'package:vendor/service/notification/utils.dart';

class NotificationService {
  late AndroidNotificationChannel channel;
  late AndroidNotificationChannel newOrderNFChannel;
  late AndroidNotificationChannel updateOrderNFChannel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationService() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    channel = androidNotificationChannel;
    newOrderNFChannel = androidCreateOrderNFChannel;
    updateOrderNFChannel = androidUpdateOrderNFChannel;
  }

  initialiseNotificationService() async {
    await setupFlutterNotifications();

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    requestNotificationPermissions(flutterLocalNotificationsPlugin);

    //Handle Foreground Message
    firebaseMessagingForegroundHandler();

    //Handle Background Message
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  Future<void> setupFlutterNotifications() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: 'ic_launcher',
          ),
        ),
      );
    }
  }

  showLocalNotification({title, subTitle}) {
    flutterLocalNotificationsPlugin.show(
        1211,
        title,
        subTitle,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            category: AndroidNotificationCategory.event,
            sound: const RawResourceAndroidNotificationSound('o_notification'),
            playSound: true,
            enableVibration: true,
            channelShowBadge: true,
            icon: 'notification',
          ),
        ));
  }

  newOrderNotificationV(Order order) {
    flutterLocalNotificationsPlugin.show(
        Random().nextInt(100),
        'New Order Received',
        '${order.name} has places order',
        NotificationDetails(
          android: AndroidNotificationDetails(
            newOrderNFChannel.id,
            newOrderNFChannel.name,
            channelDescription: newOrderNFChannel.description,
            groupKey: newOrderNFChannel.groupId,
            groupAlertBehavior: GroupAlertBehavior.children,
            category: AndroidNotificationCategory.event,
            sound: const RawResourceAndroidNotificationSound('o_notification'),
            playSound: true,
            enableVibration: true,
            channelShowBadge: true,
            icon: 'notification',
          ),
        ));
  }

  updateOrderNotificationC({title, subTitle}) {
    flutterLocalNotificationsPlugin.show(
        Random().nextInt(100),
        title,
        subTitle,
        NotificationDetails(
          android: AndroidNotificationDetails(
            newOrderNFChannel.id,
            newOrderNFChannel.name,
            channelDescription: newOrderNFChannel.description,
            groupKey: newOrderNFChannel.groupId,
            groupAlertBehavior: GroupAlertBehavior.children,
            category: AndroidNotificationCategory.event,
            sound: const RawResourceAndroidNotificationSound('o_notification'),
            playSound: true,
            enableVibration: true,
            channelShowBadge: true,
            icon: 'notification',
          ),
        ));
  }
}
