import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _rememberMe = false;

  bool get rememberMe => _rememberMe;

  void toggleRememberMe(bool? value) {
    _rememberMe = value ?? false;
    notifyListeners();
  }
}
