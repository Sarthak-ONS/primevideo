import 'package:flutter/material.dart';
import 'package:prime_video/Widgets/custom_spacer.dart';

import '../prime_colors.dart';

class MovieDescriptionControlWidget extends StatelessWidget {
  const MovieDescriptionControlWidget({
    Key? key,
    required this.icons,
    required this.title,
    required this.callback,
    this.bordercolor = Colors.grey,
    this.iconColor = Colors.grey,
  }) : super(key: key);

  final IconData icons;
  final String title;
  final Function callback;
  final Color iconColor;
  final Color bordercolor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            callback();
          },
          child: CircleAvatar(
            radius: 21,
            backgroundColor: bordercolor,
            child: CircleAvatar(
              backgroundColor: PrimeColors.primaryColor,
              radius: 20,
              child: Icon(
                icons,
                size: 25,
                color: iconColor,
              ),
            ),
          ),
        ),
        buildHeightSizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
