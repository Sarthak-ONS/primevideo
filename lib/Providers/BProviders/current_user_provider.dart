import 'package:flutter/material.dart';

class CurrentUser extends ChangeNotifier {
  String? email;
  String? name;
  String? photoUrl;

  void changeUserDetails(String email, String name, String photoUrl) {
    this.email = email;
    this.name = name;
    this.photoUrl = photoUrl;
    notifyListeners();
  }
}
