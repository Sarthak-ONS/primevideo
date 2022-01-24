import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'my_channel', // id
  'My Channel', // title
  description: 'Important notifications from my server.', // description
  importance: Importance.high,
);

var android = const AndroidNotificationDetails(
  'abcdefgh',
  'main',
  channelDescription: 'CHANNEL DESCRIPTION',
  importance: Importance.max,
  priority: Priority.high,
  enableLights: true,
  enableVibration: true,
  ticker: 'ticker',
);

var ios = const IOSNotificationDetails();

var platform = NotificationDetails(android: android, iOS: ios);

class NotificationApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  NotificationApi() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    print("Handling a background message: ${message.notification}");
    print("Handling a background message: ${message.data}");
    try {
      await flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title,
        message.notification!.body,
        platform,
        payload: message.data.toString(),
      );
    } catch (e) {
      print(e);
    }
  }

  Future getInitialMessages() async {
    RemoteMessage? res = await FirebaseMessaging.instance.getInitialMessage();
    print(res!.notification);
  }

  Future onbackgroundMessageClick() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("handler called app is opened");
      print(message.notification!.body);
    }, onError: (e) {
      print(e);
    });
  }

//Method for Notification recieved when app is in Foreround
  Future getforegroundMessages() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );

    try {
      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) async {
          final tempmessage = message;
          print(tempmessage);

          try {
            await flutterLocalNotificationsPlugin.show(
              0,
              message.notification!.title,
              message.notification!.body,
              platform,
              payload: message.data.toString(),
            );
            print(tempmessage.notification!.body);
            print(tempmessage.notification!.title);
          } on PlatformException catch (e) {
            print(e);
          } catch (e) {
            print(e);
          }
          print(tempmessage.notification!.body);
        },
      );
    } catch (e) {
      print(e);
    }
  }

  // Get the Firebase Messaging Token for the device.
  Future getToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      print(token);
      return token;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
