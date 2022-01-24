import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
  onDidReceiveLocalNotification: (
    v,
    v1,
    v2,
    v3,
  ) {},
);

class NotificationApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future initializeLocalNotification() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (str) {
        print(str);
      },
    );
  }

// Initate this method for Setting up the channel.
// Opens the app from the terminated State.
  Future getInitialMessages() async {
    Future<RemoteMessage?> remoteMessage =
        _firebaseMessaging.getInitialMessage();
    print(remoteMessage);
  }

//Method for Notification recieved when app is in background
  Future getforegroundMessages() async {
    StreamSubscription streamSubscription = FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        final tempmessage = message;
        print(tempmessage.data);
      },
    );

    print(_firebaseMessaging.app.name);
  }

  Future getbackgroundMessage() async {}

  // Get the Firebase Messaging Token for the device.
  Future getToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      return token;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
