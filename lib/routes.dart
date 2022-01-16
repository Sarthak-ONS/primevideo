import 'package:flutter/material.dart';
import 'package:prime_video/Screens/login_screen.dart';
import 'package:prime_video/Screens/signup_screen.dart';

class CustomRoutes {
  static var customRoutes = {
    '/': (context) => const LoginScreen(),
    'signup': (context) => const SignupScreen()
  };
}

Route createRoute(screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
