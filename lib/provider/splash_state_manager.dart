import 'package:flutter/material.dart';

class SplashScreenProvider extends ChangeNotifier {
  bool _showSplash = true;

  bool get showSplash => _showSplash;

  void completeSplash() {
    _showSplash = false;
    notifyListeners();
  }
}
