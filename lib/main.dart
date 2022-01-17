import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prime_video/Providers/BProviders/current_user_provider.dart';
import 'package:prime_video/Providers/UIProviders/bottom_navbar_provider.dart';
import 'package:prime_video/Providers/UIProviders/custom_checkbox_provider.dart';
import 'package:prime_video/routes.dart';
import 'package:provider/provider.dart';

void main() {
  //Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider(
          create: (_) => CheckBoxProvider(),
        ),
        Provider(
          create: (_) => CurrentUser(),
        ),
        ListenableProvider(
          create: (_) => BottomNavBarProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'PoppinsRegular',
        ),
        routes: CustomRoutes.customRoutes,
        initialRoute: '/',
      ),
    );
  }
}
