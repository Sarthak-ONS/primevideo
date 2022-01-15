import 'package:flutter/material.dart';

import '../prime_colors.dart';

buildPrimaryButton(callBack) => TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          PrimeColors.textFieldBorderActiveColor,
        ),
      ),
      onPressed: callBack,
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
    );
