import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  ThemeData? _themeData;

  getTheme() => _themeData;

  setDarkTheme() async {
    _themeData = ThemeData(
      primarySwatch: Colors.blueGrey,
      brightness: Brightness.dark,
    );
    notifyListeners();
  }

  setLightTheme() async {
    _themeData = ThemeData(
      primarySwatch: Colors.red,
    );
    notifyListeners();
  }
}
