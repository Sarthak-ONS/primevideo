import 'package:flutter/material.dart';
import 'package:prime_video/Providers/UIProviders/custom_checkbox_provider.dart';
import 'package:prime_video/Widgets/custom_spacer.dart';
import 'package:prime_video/Widgets/primary_button.dart';
import 'package:prime_video/Widgets/text_form_field.dart';
import 'package:prime_video/prime_colors.dart';
import 'package:provider/provider.dart';

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

  bool obscure = true;

  togglePasswordField(currentValue) {
    Provider.of<CheckBoxProvider>(context, listen: false).showPassword();
    print(
        Provider.of<CheckBoxProvider>(context, listen: false).getInitialValue);
  }

  buildShowPasswordWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: Provider.of<CheckBoxProvider>(context).getInitialValue,
            onChanged: togglePasswordField,
            checkColor: Colors.white,
            side: const BorderSide(
              color: Colors.white,
            ),
          ),
          const Text(
            'Show Password',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15),
          ),
        ],
      );

  TextEditingController? _emailController;
  TextEditingController? _passwordController;

  Future<void> _login() async {
    print("First Validating Email");
    if (validateEmail("Sarthak!gmail.com") == null) return;
    print("The email was corect");
  }

  validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (regex.hasMatch(value) == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Email'),
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.black,
        ),
      );
      return;
    }
    return (!regex.hasMatch(value)) ? false : true;
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController!.dispose();
    _passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimeColors.primaryColor,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            'Assets/Images/ogo.png',
            height: 140,
            width: 140,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.s,
          children: [
            buildSignInHeading(),
            buildHeightSizedBox(height: 45),
            CustomTextFiled(
              hintText: 'Enter Your Email',
              textEditingController: _emailController,
            ),
            CustomTextFiled(
              hintText: 'Enter Your Password',
              obscure: !Provider.of<CheckBoxProvider>(context).getInitialValue,
              textEditingController: _passwordController,
            ),
            buildShowPasswordWidget(),
            buildPrimaryButton(() {
              print("Logging the User In");
              _login();
            }),
            buildHeightSizedBox(),
            const Text(
              'By Signing in, you agree to the Prime Video Terms of Use and license agreements which can be found on the PrimeVideo Catalogue.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
