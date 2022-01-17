import 'package:flutter/material.dart';
import 'package:prime_video/Providers/UIProviders/bottom_navbar_provider.dart';
import 'package:prime_video/Screens/Tabs/downloads_tab.dart';
import 'package:prime_video/Screens/Tabs/home_tab.dart';
import 'package:prime_video/Screens/Tabs/search_tab.dart';
import 'package:prime_video/Screens/Tabs/user_profile.dart';
import 'package:prime_video/prime_colors.dart';
import 'package:provider/provider.dart';

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

  _onTapNavBarItem(int index) {
    Provider.of<BottomNavBarProvider>(context, listen: false)
        .changeCurrentIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    print("Widget is not Rebuilding");
    return Scaffold(
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
          buildbottomNavBarItem(imageUrl: 'pentagon', title: 'Home'),
          buildbottomNavBarItem(imageUrl: 'search', title: 'Find'),
          buildbottomNavBarItem(imageUrl: 'download', title: 'Downloads'),
          buildbottomNavBarItem(imageUrl: 'user', title: 'My Stuff')
        ],
      ),
      body: _tabs[Provider.of<BottomNavBarProvider>(context).currentIndex],
    );
  }

  BottomNavigationBarItem buildbottomNavBarItem({
    required String imageUrl,
    required String title,
  }) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        'Assets/Images/$imageUrl.png',
        color: PrimeColors.primaryBlueColor,
        height: 25,
      ),
      label: title,
    );
  }
}
