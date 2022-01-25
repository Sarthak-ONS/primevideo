import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:prime_video/Providers/UIProviders/bottom_navbar_provider.dart';
import 'package:prime_video/Screens/Tabs/downloads_tab.dart';
import 'package:prime_video/Screens/Tabs/home_tab.dart';
import 'package:prime_video/Screens/Tabs/search_tab.dart';
import 'package:prime_video/Screens/Tabs/user_profile.dart';
import 'package:prime_video/Screens/settings.dart';
import 'package:prime_video/Services/firebase_dynamic_link_api.dart';
import 'package:prime_video/Services/firebase_notification_api.dart';
import 'package:prime_video/prime_colors.dart';
import 'package:prime_video/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _tabs = const [
    HomeTab(),
    SearchTab(),
    DownloadsTab(),
    UserProfile(),
  ];

  final Color colorwhite = Colors.white;

  _onTapNavBarItem(int index) {
    Provider.of<BottomNavBarProvider>(context, listen: false)
        .changeCurrentIndex(index);
  }

  @override
  void initState() {
    NotificationApi(context).getToken();
    NotificationApi(context).onbackgroundMessageClick(context);
    NotificationApi(context).getforegroundMessages();
    // NotificationApi().getbackgroundNOtificaion();
    FirebaseDynamicLinkApi().init(context);
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: PrimeColors.primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          "Assets/Images/ogo.png",
          height: 100,
          width: 100,
        ),
        actions: [
          Provider.of<BottomNavBarProvider>(context).currentIndex == 3
              ? IconButton(
                  onPressed: () {
                    // FirebaseAuth.instance.signOut();
                    Navigator.of(context).push(createRoute(const Settings()));
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                )
              : Container(),
        ],
      ),
      backgroundColor: PrimeColors.primaryColor,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        //  fixedColor: PrimeColors.primaryColor,
        selectedItemColor: PrimeColors.primaryColor,
        unselectedItemColor: PrimeColors.primaryColor,
        selectedIconTheme: IconThemeData(color: PrimeColors.primaryBlueColor),
        selectedLabelStyle: TextStyle(color: PrimeColors.primaryBlueColor),
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: Provider.of<BottomNavBarProvider>(context).currentIndex,
        elevation: 0,
        onTap: _onTapNavBarItem,
        items: [
          buildbottomNavBarItem(
              imageUrl: 'pentagon',
              title: 'Home',
              color:
                  Provider.of<BottomNavBarProvider>(context).currentIndex == 0
                      ? PrimeColors.primaryBlueColor
                      : colorwhite),
          buildbottomNavBarItem(
              imageUrl: 'search',
              title: 'Find',
              color:
                  Provider.of<BottomNavBarProvider>(context).currentIndex == 1
                      ? PrimeColors.primaryBlueColor
                      : colorwhite),
          buildbottomNavBarItem(
              imageUrl: 'download',
              title: 'Downloads',
              color:
                  Provider.of<BottomNavBarProvider>(context).currentIndex == 2
                      ? PrimeColors.primaryBlueColor
                      : colorwhite),
          buildbottomNavBarItem(
              imageUrl: 'user',
              title: 'My Stuff',
              color:
                  Provider.of<BottomNavBarProvider>(context).currentIndex == 3
                      ? PrimeColors.primaryBlueColor
                      : colorwhite)
        ],
      ),
      body: _tabs[Provider.of<BottomNavBarProvider>(context).currentIndex],
    );
  }

  BottomNavigationBarItem buildbottomNavBarItem({
    required String imageUrl,
    required String title,
    Color? color = Colors.white,
  }) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        'Assets/Images/$imageUrl.png',
        color: color!,
        height: 22,
      ),
      label: title,
    );
  }
}
