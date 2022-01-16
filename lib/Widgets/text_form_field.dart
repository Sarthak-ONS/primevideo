import 'package:flutter/material.dart';

import '../prime_colors.dart';

class CustomTextFiled extends StatelessWidget {
  const CustomTextFiled(
      {Key? key,
      this.textEditingController,
      required this.hintText,
      this.obscure = false})
      : super(key: key);

  final TextEditingController? textEditingController;
  final String? hintText;
  final bool? obscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure!,
      controller: textEditingController,
      autofillHints:
          hintText == "Enter Your Email" ? [AutofillHints.email] : [],
      style: const TextStyle(fontSize: 17),
      decoration: InputDecoration(
        fillColor: PrimeColors.textFieldColor,
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: PrimeColors.textFieldBorderActiveColor,
          ),
        ),
        enabledBorder: const OutlineInputBorder(),
      ),
    );
  }
}
