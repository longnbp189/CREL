import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) async {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings(
        "@mipmap/ic_launcher",
      ),
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? type) async {
        print("onSelectNotification");
        // navigatorNotification(, context);
        // if (type!.isNotEmpty) {
        //   print("Router Value1234 $type");

        //   // Navigator.of(context).push(
        //   //   MaterialPageRoute(
        //   //     builder: (context) => NotificationPage(
        //   //       id: id,
        //   //     ),
        //   //   ),
        //   // );
        // }
      },
    );
  }

  static void createanddisplaynotification(RemoteMessage message) async {
    final int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails(
            "CREL_Mobile", "pushnotificationappchannel",
            importance: Importance.max,
            priority: Priority.high,
            icon: "@mipmap/ic_launcher"));
    // AndroidNotificationDetails('channel_id', 'channel_name',
    //     channelDescription: 'description',
    //     importance: Importance.max,
    //     priority: Priority.max,
    //     playSound: true));
    try {
      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['Type'],
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
