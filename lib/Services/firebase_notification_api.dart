import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:prime_video/Screens/movie_description_page.dart';
import 'package:prime_video/routes.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'abcdefgh', // id
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

  StreamSubscription<RemoteMessage>? _streamSubscriptionforForeground;

  StreamSubscription<RemoteMessage>? get getStreamOfNotificaion =>
      _streamSubscriptionforForeground;

  StreamSubscription<RemoteMessage>? _streamSubscriptionforBackground;

  StreamSubscription<RemoteMessage>? get getStreamOfNotificaionForbackground =>
      _streamSubscriptionforBackground;

  NotificationApi(context) {
    initialize(context);
  }

  initialize(context) async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onSelectNotification: (str) {
        Map map = str as Map;
        Navigator.of(context).push(
          createRoute(
            MovieDescriptionScreen(
              backdropposter: map['image'],
              movieID: map['id'] as int,
              moviename: map['name'],
              description: map['description'],
            ),
          ),
        );
        print(map['MovieID']);
        print("/////////////");
        print(str);
      },
    );
  }

  Future onbackgroundMessageClick(context) async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("handler called app is opened");
      Map map = message.data;
      Navigator.of(context).push(
        createRoute(
          MovieDescriptionScreen(
            backdropposter: map['image'],
            movieID: int.parse(map['id']),
            moviename: map['name'],
            description: map['description'],
          ),
        ),
      );
      print(map['MovieID']);
    }, onError: (e) {
      print(e);
    });
  }

//Method for Notification recieved when app is in Foreround
  Future getforegroundMessages() async {
    try {
      _streamSubscriptionforForeground = FirebaseMessaging.onMessage.listen(
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
            print(tempmessage.data);
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

  Future getbackgroundNOtificaion() async {
    FirebaseMessaging.onBackgroundMessage(
      firebaseMessagingBackgroundHandler,
    );
  }

  Future firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onSelectNotification: (str) {
        print("/////////////");
        print(str!);
      },
    );

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
