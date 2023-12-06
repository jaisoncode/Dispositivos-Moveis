import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends ChangeNotifier {
  static AppController instance = AppController();

  late SharedPreferences _prefs;

  bool isDarkTheme = false;

  AppController() {
    _startSettings();
  }
  _startSettings() async {
    await _startPreferences();
    await _readDarkTheme();
  }

  Future _startPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  _readDarkTheme() async {
    isDarkTheme = _prefs.getBool('is_dark_theme') ?? true;
    notifyListeners();
  }

  chengeTheme(bool isDarkTheme) async {
    this.isDarkTheme = isDarkTheme;
    await _prefs.setBool('is_dark_theme', isDarkTheme);
    _readDarkTheme();
  }
}
