import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prime_video/Providers/BProviders/current_user_provider.dart';
import 'package:prime_video/Providers/BProviders/trending_provider.dart';
import 'package:prime_video/Providers/UIProviders/bottom_navbar_provider.dart';
import 'package:prime_video/Providers/UIProviders/custom_checkbox_provider.dart';
import 'package:prime_video/Screens/home_screen.dart';
import 'package:prime_video/Screens/login_screen.dart';
import 'package:prime_video/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  //Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
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
            } else {
              return const HomeScreen();
            }
          },
        ),
      ),
    );
  }
}
