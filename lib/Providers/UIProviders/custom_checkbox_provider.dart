import 'package:flutter/cupertino.dart';

class CheckBoxProvider extends ChangeNotifier {
  bool _initialValue = false;

  bool get getInitialValue => _initialValue;

  void showPassword() {
    _initialValue = !_initialValue;
    notifyListeners();
  }
}
