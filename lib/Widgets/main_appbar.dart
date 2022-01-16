import 'package:flutter/material.dart';

buildMainAppBar({required bool createBackButton, callback}) => AppBar(
      leading: createBackButton == true
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: callback,
            )
          : null,
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
    );
