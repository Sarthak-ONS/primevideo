import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:prime_video/Models/movie_model_hive.dart';
import 'package:prime_video/Services/firebase_notification_api.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as pathprovider;

import 'package:prime_video/Providers/BProviders/current_user_provider.dart';
import 'package:prime_video/Providers/BProviders/trending_provider.dart';
import 'package:prime_video/Providers/UIProviders/bottom_navbar_provider.dart';
import 'package:prime_video/Providers/UIProviders/custom_checkbox_provider.dart';
import 'package:prime_video/Screens/home_screen.dart';
import 'package:prime_video/Screens/login_screen.dart';

Future main() async {
  print("Restarting the complete the app");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Directory directory = await pathprovider.getApplicationDocumentsDirectory();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  print(directory.path);
  Hive.init(directory.path);
  Hive.registerAdapter(HiveMovieModelAdapter());
  await Hive.openBox<HiveMovieModel>('hiveMoviesForDownloads');
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  //await Firebase.initializeApp();

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

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       // Initialize FlutterFire
//       future: Firebase.initializeApp(),
//       builder: (context, snapshot) {
//         // Check for errors
//         if (snapshot.hasError) {
//           return Center(
//             child: Text('Please try again later'),
//           );
//         }

//         // Once complete, show your application
//         if (snapshot.connectionState == ConnectionState.done) {
//           return MyApp();
//         }

//         // Otherwise, show something whilst waiting for initialization to complete
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider(
          create: (_) => CheckBoxProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CurrentUserProvider(),
        ),
        ListenableProvider(
          create: (_) => BottomNavBarProvider(),
        ),
        ListenableProvider(
          create: (_) => MovieProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'PoppinsRegular',
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const LoginScreen();
            }
            if (snapshot.hasError) {
              return const LoginScreen();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const HomeScreen();
          },
        ),
      ),
    );
  }
}
