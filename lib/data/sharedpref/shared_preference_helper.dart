import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------
  Future<String?> get authToken async {
    return _sharedPreference.getString(Preferences.auth_token);
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _sharedPreference.setString(Preferences.auth_token, authToken);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreference.remove(Preferences.auth_token);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    return _sharedPreference.getBool(Preferences.is_logged_in) ?? false;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreference.setBool(Preferences.is_logged_in, value);
  }

  // User:---------------------------------------------------
  String? get currentUser {
    return _sharedPreference.getString(Preferences.current_user);
  }

  Future<void> setLoggedUser(String userEmail) {
    return _sharedPreference.setString(Preferences.current_user, userEmail);
  }


  String? get loggedTimeStamp {
    return _sharedPreference.getString(Preferences.logged_time_stamp);
  }

  Future<void> setLoggedTimeStamp(String dateTime) {
    return _sharedPreference.setString(Preferences.logged_time_stamp, dateTime);
  }


}