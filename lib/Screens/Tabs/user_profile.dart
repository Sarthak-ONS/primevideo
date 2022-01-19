import 'package:flutter/material.dart';
import 'package:prime_video/prime_colors.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimeColors.primaryColor,
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
