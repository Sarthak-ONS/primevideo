import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prime_video/Screens/home_screen.dart';
import 'package:prime_video/Services/email_verification_service.dart';
import 'package:prime_video/Services/firestore_service.dart';
import 'package:prime_video/Widgets/custom_spacer.dart';
import 'package:prime_video/Widgets/main_appbar.dart';
import 'package:prime_video/Widgets/primary_button.dart';
import 'package:prime_video/prime_colors.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:prime_video/routes.dart';

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
              //TODO: Add a Resend Email Of OTP
              PinPut(
                fieldsCount: 6,
                controller: _otpController,
                textStyle: const TextStyle(
                  color: Colors.white,
                ),
                selectedFieldDecoration: kboxDecoration,
                submittedFieldDecoration: kboxDecoration,
                followingFieldDecoration: kboxDecoration,
                onSubmit: (str) async {
                  if (_otpController!.text ==
                      SendEmailVerificationMail.otp.toString()) {
                    print("OTP is Verified");
                    await FirebaseFirestoreApi().createProfileInDatabase(
                        FirebaseAuth.instance.currentUser!.uid);

                    //Go to Home Page
                    Navigator.of(context).pushAndRemoveUntil(
                        createRoute(
                          const HomeScreen(),
                        ),
                        ModalRoute.withName(""));
                  }
                },
                onEditingComplete: () {
                  print("Editing Completed");
                },
              ),
              buildHeightSizedBox(height: 50),
              buildPrimaryButton(
                () async {
                  if (_otpController!.text ==
                      SendEmailVerificationMail.otp.toString()) {
                    print("OTP is Verified");
                    await FirebaseFirestoreApi().createProfileInDatabase(
                        FirebaseAuth.instance.currentUser!.uid);

                    //Go to Home Page
                    Navigator.of(context).pushAndRemoveUntil(
                        createRoute(
                          const HomeScreen(),
                        ),
                        ModalRoute.withName(""));
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
}
