import 'package:flutter_local_notifications/flutter_local_notifications.dart';

AndroidNotificationChannel androidNotificationChannel =
    const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description: 'This channel is used for important notifications.',
        // description
        playSound: true,
        sound: RawResourceAndroidNotificationSound('o_notification'),
        enableVibration: true,
        importance: Importance.high);

AndroidNotificationChannel androidCreateOrderNFChannel =
    const AndroidNotificationChannel(
        'new_order_channel', // id
        'New Order Notifications', // title
        description: 'This channel is used for new order notifications.',
        // description
        playSound: true,
        sound: RawResourceAndroidNotificationSound('o_notification'),
        enableVibration: true,
        showBadge: true,
        groupId: 'new_order_group_id',
        importance: Importance.high);

AndroidNotificationChannel androidUpdateOrderNFChannel =
    const AndroidNotificationChannel(
        'update_order_channel', // id
        'New Update Notifications', // title
        description: 'This channel is used for update order notifications.',
        // description
        playSound: true,
        sound: RawResourceAndroidNotificationSound('o_notification'),
        enableVibration: true,
        showBadge: true,
        groupId: 'update_order_group_id',
        importance: Importance.high);
