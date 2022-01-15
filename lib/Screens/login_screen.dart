import 'package:flutter/material.dart';
import 'package:prime_video/Providers/UIProviders/custom_checkbox_provider.dart';
import 'package:prime_video/Widgets/custom_spacer.dart';
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
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  PrimeColors.textFieldBorderActiveColor,
                ),
              ),
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 3,
                ),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
