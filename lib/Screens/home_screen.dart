import 'package:flutter/material.dart';
import 'package:prime_video/prime_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: PrimeColors.primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          "Assets/Images/ogo.png",
          height: 140,
          width: 140,
        ),
      ),
      backgroundColor: PrimeColors.primaryColor,
    );
  }
}
