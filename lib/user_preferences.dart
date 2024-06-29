import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const _themeKey = 'theme';

  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setTheme(bool isDarkMode) async {
    await _preferences.setBool(_themeKey, isDarkMode);
  }

  static bool getTheme() {
    return _preferences.getBool(_themeKey) ?? false;
  }
}
