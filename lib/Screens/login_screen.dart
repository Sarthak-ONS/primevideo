import 'package:flutter/material.dart';
import 'package:prime_video/Auth_Validator/auth_validation.dart';
import 'package:prime_video/Providers/UIProviders/custom_checkbox_provider.dart';
import 'package:prime_video/Screens/signup_screen.dart';
import 'package:prime_video/Services/auth_service.dart';
import 'package:prime_video/Widgets/auth_heading.dart';
import 'package:prime_video/Widgets/custom_spacer.dart';
import 'package:prime_video/Widgets/main_appbar.dart';
import 'package:prime_video/Widgets/primary_button.dart';
import 'package:prime_video/Widgets/text_form_field.dart';
import 'package:prime_video/prime_colors.dart';
import 'package:provider/provider.dart';

import '../routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    if (AuthInputsValidation.validateEmail(_emailController!.text, context) ==
            null ||
        AuthInputsValidation.validatePassword(
                _passwordController!.text, context) ==
            null) return;

    print("The email was corect");
    FirebaseAuthApi().signIn(
        email: _emailController!.text,
        password: _passwordController!.text,
        context: context);
  }

  bool isSignup = false;

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
      appBar: buildMainAppBar(createBackButton: false),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildAuthHeading('Sign in'),
                  buildHeightSizedBox(height: 45),
                  CustomTextFiled(
                    hintText: 'Enter Your Email',
                    textEditingController: _emailController,
                  ),
                  CustomTextFiled(
                    hintText: 'Enter Your Password',
                    obscure:
                        !Provider.of<CheckBoxProvider>(context).getInitialValue,
                    textEditingController: _passwordController,
                  ),
                  buildHeightSizedBox(),
                  buildShowPasswordWidget(),
                  buildHeightSizedBox(),
                  buildPrimaryButton(() {
                    print("Logging the User In");
                    _login();
                  }, 'Sign In'),
                  buildHeightSizedBox(),
                  const Text(
                    'By Signing in, you agree to the Prime Video Terms of Use and license agreements which can be found on the PrimeVideo Catalogue.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  child: const Text(
                    'Sign Up?',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(createRoute(const SignupScreen()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
