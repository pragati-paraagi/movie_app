import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  String _profileName = 'Profile 1';
  bool _autoplayNextEpisode = true;
  bool _autoplayPreviews = true;

  String get profileName => _profileName;
  bool get autoplayNextEpisode => _autoplayNextEpisode;
  bool get autoplayPreviews => _autoplayPreviews;

  void updateProfileName(String newName) {
    _profileName = newName;
    notifyListeners();
  }

  void toggleAutoplayNextEpisode(bool value) {
    _autoplayNextEpisode = value;
    notifyListeners();
  }

  void toggleAutoplayPreviews(bool value) {
    _autoplayPreviews = value;
    notifyListeners();
  }
}
