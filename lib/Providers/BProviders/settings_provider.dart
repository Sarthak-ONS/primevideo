import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool? isOverWifiOnly = false;
  bool? isNotificationOff = false;
  bool? autoPlayNextEpisode = true;

  SharedPreferences? _sharedPreferences;

  SettingsProvider() {
    getInstanceForSharedPreferences();
  }

  getInstanceForSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setNotificaiotnoffValue();
  }

  changeIsOverWifiOnly(bool? value) {
    isOverWifiOnly = !value!;
    notifyListeners();
  }

  changeNotificationOff(bool? value, context) async {
    await _sharedPreferences!.setBool("isNotificaionOff", value!);
    print("The value in Share Prefs for ChangeNotification oFf is $value");

    isNotificationOff = value;
    notifyListeners();
  }

  setNotificaiotnoffValue() async {
    final currentStatusOfNotification =
        _sharedPreferences!.getBool('isNotificaionOff');
    print('The current Status of Notification is $currentStatusOfNotification');

    isNotificationOff = currentStatusOfNotification;
    notifyListeners();
  }

  changeAutoPlayNextEpisode(bool? value) {
    isNotificationOff = autoPlayNextEpisode = value;
    notifyListeners();
  }
}


/// For turning on and off the notification we can check whether notification are paused by the user, 
/// if notificaition are paused then don't show notification using the plugin else show.