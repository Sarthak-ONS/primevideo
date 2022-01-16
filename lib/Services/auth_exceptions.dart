import 'package:flutter/material.dart';
import 'package:prime_video/Widgets/custom_spacer.dart';
import 'package:prime_video/Widgets/primary_button.dart';

class CustomAuthExceptions {
  Future handleAuthExceptions(code, context) async {
    print("Auth Exceptions handle Method is Called");
    String? errorMessage;
    switch (code) {
      case "email-already-in-use":
        errorMessage = "Email Account Already Exists";
        break;
      case "invalid-email":
        errorMessage = "Please use a valid Email";
        break;
      case "weak-password":
        errorMessage = "Pasword is too weak";
        break;
      case "wrong-password":
        errorMessage = "Invalid Password";
        break;
      case "too-many-requests":
        errorMessage = "Too Many Attempts. Please Try Again Later";
        break;
      case "user-not-found":
        errorMessage = "We couldn't find a account attached to this email.";
        break;
      case "user-disabled":
        errorMessage =
            "Your account is disabled to unusual activity. Please go to help section";
        break;
      default:
        errorMessage = "An undefined Error happened.";
        print(code);
    }

    if (errorMessage.isNotEmpty) {
      print(errorMessage);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                errorMessage!,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              buildHeightSizedBox(height: 15),
              buildPrimaryButton(() {
                Navigator.pop(context);
              }, 'OK')
            ],
          ),
        ),
      );
    }
  }
}
