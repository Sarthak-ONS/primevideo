import 'package:flutter/material.dart';
import 'package:prime_video/Providers/BProviders/settings_provider.dart';
import 'package:prime_video/Services/auth_service.dart';
import 'package:prime_video/prime_colors.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0x0f04688a),
            Color(0x0f04688a),
            Color(0x0f04688a),
            Color(0x0f04688a),
            //PrimeColors.primaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // final token = await NotificationApi().getbackgroundMessages();
            // print(token);
          },
        ),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Settings',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        body: ChangeNotifierProvider<SettingsProvider>(
          create: (_) => SettingsProvider(),
          child: ListView(
            children: [
              Consumer<SettingsProvider>(
                builder: (context, mySettings, child) => CheckboxListTile(
                  value: mySettings.isOverWifiOnly,
                  onChanged: (value) {
                    print("is Over Wifi Only: $value");
                    if (value!) {
                      mySettings.changeIsOverWifiOnly(false);
                      return;
                    } else {
                      mySettings.changeIsOverWifiOnly(true);
                      return;
                    }
                  },
                  title: const Text(
                    'Download Over Wifi only',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
              ),
              Consumer<SettingsProvider>(
                builder: (context, mySettings, child) => CheckboxListTile(
                  value: !mySettings.isNotificationOff!,
                  onChanged: (value) {
                    print("is Notification value : $value");
                    if (value!) {
                      mySettings.changeNotificationOff(false, context);
                      return;
                    } else {
                      mySettings.changeNotificationOff(true, context);
                      return;
                    }
                  },
                  title: const Text(
                    'Notification',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
              ),
              Consumer<SettingsProvider>(
                builder: (context, mySettings, child) => CheckboxListTile(
                  value: mySettings.autoPlayNextEpisode,
                  onChanged: (value) {
                    print("is Auto Play Next Episode : $value");
                    if (value!) {
                      mySettings.changeAutoPlayNextEpisode(false);
                      return;
                    } else {
                      mySettings.changeAutoPlayNextEpisode(true);
                      return;
                    }
                  },
                  activeColor: PrimeColors.primaryBlueColor,
                  title: const Text(
                    'Autoplay Next Episode',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
              ),
              ListTile(
                title: const Text(
                  'Signout of the Device',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () async {
                  await FirebaseAuthApi().signout();
                },
              ),
              const ListTile(
                title: Text(
                  'Help & Feedback',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const ListTile(
                title: Text(
                  'About and Legal',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
