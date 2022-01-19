import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prime_video/Widgets/custom_spacer.dart';
import 'package:prime_video/prime_colors.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimeColors.primaryColor,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print(FirebaseAuth.instance.currentUser!.photoURL);
                      },
                      child: CircleAvatar(
                        radius: 43,
                        backgroundColor: PrimeColors.primaryBlueColor,
                        child: CircleAvatar(
                          backgroundColor: PrimeColors.primaryBlueColor,
                          radius: 40,
                          backgroundImage: NetworkImage(
                            FirebaseAuth.instance.currentUser!.photoURL !=
                                    "null"
                                ? "https://images.pexels.com/photos/8350511/pexels-photo-8350511.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
                                : "",
                          ),
                        ),
                      ),
                    ),
                    buildWidthSizedBox(width: 25),
                    Text(
                      FirebaseAuth.instance.currentUser!.displayName!,
                      style: const TextStyle(
                        color: Colors.white,
                        //fontFamily: 'Poppins',
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                buildHeightSizedBox(height: 15),
                Divider(
                  thickness: 1.5,
                  color: PrimeColors.primaryBlueColor,
                ),
                buildHeightSizedBox(height: 20),
                const Text(
                  'Watchlist',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 17,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
