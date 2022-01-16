import 'package:flutter/material.dart';
import 'package:prime_video/Widgets/custom_spacer.dart';
import 'package:prime_video/Widgets/main_appbar.dart';
import 'package:prime_video/Widgets/primary_button.dart';
import 'package:prime_video/prime_colors.dart';
import 'package:pinput/pin_put/pin_put.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen(
      {Key? key, required this.email, required this.name, required this.otp})
      : super(key: key);

  final String? name;
  final String? email;
  final int? otp;

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  TextEditingController? _otpController;

  BoxDecoration kboxDecoration = const BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: Colors.grey,
      ),
    ),
  );

  @override
  void dispose() {
    super.dispose();
    _otpController!.dispose();
  }

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimeColors.primaryColor,
      appBar: buildMainAppBar(
          createBackButton: true,
          callback: () {
            Navigator.pop(context);
          }),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Hi, ${widget.name!}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Text(
                widget.email!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              buildHeightSizedBox(),
              buildHeightSizedBox(height: 15),
              const Text(
                'Please Verify Your Email. We have sent a OTP to your Email with a Six Digit OTP, please verify it.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              buildHeightSizedBox(),
              PinPut(
                fieldsCount: 6,
                controller: _otpController,
                textStyle: const TextStyle(
                  color: Colors.white,
                ),
                selectedFieldDecoration: kboxDecoration,
                submittedFieldDecoration: kboxDecoration,
                followingFieldDecoration: kboxDecoration,
                onSubmit: (str) {
                  print("/////////");
                  if (str == widget.otp.toString()) {
                    print("Email Is Verified");
                  }
                  print(str);
                },
                onEditingComplete: () {
                  print("Editing Completed");
                },
              ),
              buildHeightSizedBox(height: 50),
              buildPrimaryButton(
                () {
                  if (_otpController!.text == widget.otp.toString()) {
                    print("OTP is Verified");
                    //Go to Home Page
                  }
                },
                'Verify OTP',
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String pin, BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            'Pin Submitted. Value: $pin',
            style: const TextStyle(fontSize: 25.0),
          ),
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
    );
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
