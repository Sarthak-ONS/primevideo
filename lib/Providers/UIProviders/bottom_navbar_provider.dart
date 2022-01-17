import 'package:flutter/cupertino.dart';

class BottomNavBarProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get currentIndex => _selectedIndex;

  void changeCurrentIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
