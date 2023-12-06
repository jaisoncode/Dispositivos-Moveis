import 'package:flutter/material.dart';
import 'package:todo_app/database_provider.dart';

class AppController extends ChangeNotifier {
  static AppController instance = AppController();
  late DatabaseProvider _databaseProvider;

  bool isDarkTheme = false;

  AppController() {
    _databaseProvider = DatabaseProvider();
    _startSettings();
  }

  _startSettings() async {
    await _readDarkTheme();
  }

  _readDarkTheme() async {
    isDarkTheme = await _databaseProvider.getDarkTheme();
    notifyListeners();
  }

  changeTheme(bool isDarkTheme) async {
    this.isDarkTheme = isDarkTheme;
    await _databaseProvider.updateDarkTheme(isDarkTheme);
    notifyListeners();
  }
}
