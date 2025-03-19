import 'dart:convert';

import 'package:acm_app/model/event_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const _themeStateKey = 'theme';
  static const _notificationStateKey = 'notify';
  static const _daysKey = 'day';
  static const _hoursKey = 'hour';
  static const _minutesKey = 'minute';
  static const _favoritesKey = 'favorite';
  static const _favoriteEventKey = 'event';

  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setTheme(bool isDarkMode) async {
    await _preferences.setBool(_themeStateKey, isDarkMode);
  }

  static Future setNotification(bool allowNotification) async {
    await _preferences.setBool(_notificationStateKey, allowNotification);
  }

  static Future setTime(List<int> time) async {
    await _preferences.setInt(_daysKey, time[0]);
    await _preferences.setInt(_hoursKey, time[1]);
    await _preferences.setInt(_minutesKey, time[2]);
  }

  static Future setFavoriteOnly(bool isFavorite) async {
    await _preferences.setBool(_favoritesKey, isFavorite);
  }

  static bool getFavorite() {
    return _preferences.getBool(_favoritesKey) ?? false;
  }

  static bool getTheme() {
    return _preferences.getBool(_themeStateKey) ?? false;
  }

  static bool getNotification() {
    return _preferences.getBool(_notificationStateKey) ?? false;
  }

  static List<int> getTime() {
    return [
      _preferences.getInt(_daysKey) ?? 0,
      _preferences.getInt(_hoursKey) ?? 1,
      _preferences.getInt(_minutesKey) ?? 0,
    ];
  }

  static void setFavoriteEvent(List<EventItem> favoriteEvents) async {
    final jsonString =
        jsonEncode(favoriteEvents.map((event) => event.toJson()).toList());

    await _preferences.setString(_favoriteEventKey, jsonString);
  }

  static Future<List<EventItem>> getFavoriteEvents() async {
    final jsonString = _preferences.getString(_favoriteEventKey);

    if (jsonString == null) {
      return [];
    }

    final List<dynamic> jsonList = jsonDecode(jsonString);

    return jsonList.map((json) => EventItem.fromJson(json)).toList();
  }
}
