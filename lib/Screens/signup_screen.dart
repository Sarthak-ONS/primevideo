import 'package:flutter/material.dart';
import 'package:prime_video/Auth_Validator/auth_validation.dart';
import 'package:prime_video/Providers/UIProviders/custom_checkbox_provider.dart';
import 'package:prime_video/Services/auth_service.dart';
import 'package:prime_video/Widgets/auth_heading.dart';
import 'package:prime_video/Widgets/custom_spacer.dart';
import 'package:prime_video/Widgets/main_appbar.dart';
import 'package:prime_video/Widgets/primary_button.dart';
import 'package:prime_video/Widgets/text_form_field.dart';
import 'package:prime_video/prime_colors.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
  TextEditingController? _nameController;
  TextEditingController? _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController!.dispose();
    _passwordController!.dispose();
    _confirmPasswordController!.dispose();
    _nameController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(
        createBackButton: true,
        callback: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: PrimeColors.primaryColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeightSizedBox(height: 25),
              buildAuthHeading('Create an Account'),
              buildHeightSizedBox(height: 35),
              CustomTextFiled(
                hintText: 'Enter Your Name',
                textEditingController: _nameController,
              ),
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
              CustomTextFiled(
                hintText: 'Confirm Password',
                textEditingController: _confirmPasswordController,
                obscure:
                    !Provider.of<CheckBoxProvider>(context).getInitialValue,
              ),
              buildHeightSizedBox(),
              buildShowPasswordWidget(),
              buildHeightSizedBox(),
              buildPrimaryButton(() {
                _singup();
              }, 'Sign Up'),
              buildHeightSizedBox(),
              const Text(
                'By Signing Up, you agree to the Prime Video Terms of Use and license agreements which can be found on the PrimeVideo Catalogue.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _singup() {
    if (AuthInputsValidation.validateEmail(_emailController!.text, context) ==
            false ||
        AuthInputsValidation.validatePassword(
                _passwordController!.text, context) ==
            false ||
        AuthInputsValidation.validatePassword(
                _confirmPasswordController!.text, context) ==
            false) {
      print("Invalid Credentials");
      print(_emailController!.text);
      print(_passwordController!.text);
      print(_confirmPasswordController!.text);
      return;
    }

    if (_confirmPasswordController!.text != _passwordController!.text ||
        _nameController!.text.isEmpty) return;
    print(_emailController!.text);
    FirebaseAuthApi().createUserwithEmailAndPassword(
      email: _emailController!.text,
      password: _passwordController!.text,
      name: _nameController!.text,
      context: context,
    );
  }
}
