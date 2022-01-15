import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prime_video/Widgets/custom_spacer.dart';
import 'package:prime_video/Widgets/text_form_field.dart';
import 'package:prime_video/prime_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  buildSignInHeading() => const Text(
        'Sign In',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
      );

  buildShowPasswordWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: false,
            onChanged: (currentValue) {},
          ),
          const Text(
            'Show Password',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimeColors.primaryColor,
      appBar: AppBar(
        title: Image.asset(
          'Assets/Images/ogo.png',
          height: 140,
          width: 140,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSignInHeading(),
            buildHeightSizedBox(height: 15),
            const CustomTextFiled(
              hintText: 'Enter Your Email',
            ),
            const CustomTextFiled(
              hintText: 'Enter Your Password',
            ),
            buildShowPasswordWidget()
          ],
        ),
      ),
    );
  }
}
