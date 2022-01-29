import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:prime_video/Providers/BProviders/save_movie_provider.dart';
import 'package:provider/provider.dart';

import 'dart:io';

import 'package:path_provider/path_provider.dart' as pathprovider;
import 'package:prime_video/Providers/BProviders/current_user_provider.dart';
import 'package:prime_video/Providers/BProviders/trending_provider.dart';
import 'package:prime_video/Providers/UIProviders/bottom_navbar_provider.dart';
import 'package:prime_video/Providers/UIProviders/custom_checkbox_provider.dart';
import 'package:prime_video/Screens/home_screen.dart';
import 'package:prime_video/Screens/login_screen.dart';

import 'Models/movie_model_hive.dart';
import 'private_variable.dart';

Future main() async {
  print("Restarting the complete the app");
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathprovider.getApplicationDocumentsDirectory();
  print(directory.path);
  Hive.init(directory.path);
  Hive.registerAdapter(HiveMovieModelAdapter());
  box = await Hive.openBox<HiveMovieModel>('continuewatching');
  await Firebase.initializeApp();
  runApp(const MyApp());
}

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
        ),
        ChangeNotifierProvider(
          create: (_) => MovieStateProvider(),
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
