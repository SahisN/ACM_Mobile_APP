import 'package:acm_app/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:acm_app/data/theme.dart';

class StateProvider with ChangeNotifier {
  bool _darkModeSelected = UserPreferences.getTheme();

  ThemeData _themeData = UserPreferences.getTheme() ? darkMode : lightMode;
  ThemeData get themeData => _themeData;
  bool get darkModeSelected => _darkModeSelected;

  bool _allowNotification = UserPreferences.getNotification();
  bool get notificationState => _allowNotification;

  final List<int> _reminderTime = UserPreferences.getTime();
  List<int> get time => _reminderTime;

  final bool _favoritesOnly = UserPreferences.getFavorite();
  bool get favoriteOnlyState => _favoritesOnly;

  // Sets the theme depending on ThemeData value
  set themeData(ThemeData themeData) {
    if (_darkModeSelected) {}
    _themeData = themeData;
    notifyListeners();
  }

  // this function toggles between light and dark mode
  // can be used in another dart class and passed as a function
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
      _darkModeSelected = true;
    } else {
      themeData = lightMode;
      _darkModeSelected = false;
    }

    UserPreferences.setTheme(_darkModeSelected);
  }

  void toggleNofication() {
    if (_allowNotification == true) {
      _allowNotification = false;
    } else {
      _allowNotification = true;
    }

    UserPreferences.setNotification(_allowNotification);
  }
}
