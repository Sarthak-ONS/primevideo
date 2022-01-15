import 'package:flutter/material.dart';
import 'package:prime_video/prime_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimeColors.primaryColor,
      appBar: AppBar(
        title: const Text('Prime Video'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
