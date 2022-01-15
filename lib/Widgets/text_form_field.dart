import 'package:flutter/material.dart';

import '../prime_colors.dart';

class CustomTextFiled extends StatelessWidget {
  const CustomTextFiled(
      {Key? key, this.textEditingController, required this.hintText})
      : super(key: key);

  final TextEditingController? textEditingController;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        fillColor: PrimeColors.textFieldColor,
        filled: true,
        hintText: hintText,
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
