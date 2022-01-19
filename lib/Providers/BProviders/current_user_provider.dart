import 'package:flutter/material.dart';

class CurrentUserProvider extends ChangeNotifier {
  String? email;
  String? name;
  String? photoUrl;

  Future changeUserDetails(String email, String name, String s,
      {String? photoUrl = ""}) async {
    this.email = email;
    this.name = name;
    this.photoUrl = photoUrl;
    notifyListeners();
  }
}
