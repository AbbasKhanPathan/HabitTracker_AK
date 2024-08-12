import 'package:flutter/material.dart';
import 'package:habittracker/theme/light_mode.dart';
import 'package:habittracker/theme/dark_mode.dart';

class Themeprovider extends ChangeNotifier {
  ThemeData _themeData = darkMode;
  ThemeData get themedata => _themeData;
  bool get isDarkMode => _themeData == darkMode;

  set themedata(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themedata = darkMode;
    } else {
      themedata = lightMode;
    }
  }
}
