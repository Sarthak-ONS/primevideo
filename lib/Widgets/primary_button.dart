import 'package:flutter/material.dart';

import '../prime_colors.dart';

buildPrimaryButton(callBack, String title) => TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          PrimeColors.textFieldBorderActiveColor,
        ),
      ),
      onPressed: callBack,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 3,
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
