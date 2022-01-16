import 'package:flutter/material.dart';

import '../global_variable.dart';

class AuthInputsValidation {
  //Validator For Email with Show SnackBar
  static validateEmail(String value, BuildContext context) {
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

  static validatePassword(String password, BuildContext context) {
    RegExp regExp = RegExp(patternForPassword);
    if (regExp.hasMatch(password) == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Password'),
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.black,
        ),
      );
      return;
    }
    return (!regExp.hasMatch(password)) ? false : true;
  }
}
