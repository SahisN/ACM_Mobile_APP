import 'package:flutter/material.dart';
import 'package:acm_app/data/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;
  bool _darkModeSelected = false;
  ThemeData get themeData => _themeData;
  bool get darkModeSelected => _darkModeSelected;

  // Sets the theme depending on ThemeData value
  set themeData(ThemeData themeData) {
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
  }
}
