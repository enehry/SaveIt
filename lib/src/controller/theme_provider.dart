import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:save_it/src/utils/constant.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  late Box _themeModeBox;

  // Set the theme mode to the value of the theme mode passed in.
  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    // save index to hive
    Hive.box(kThemeModeBox).put(kThemeModeData, themeMode.index);
    notifyListeners();
  }

  // lazy load the theme data
  ThemeProvider(Box box) {
    _themeModeBox = box;
    _initTheme();
  }

  void _initTheme() {
    // get data from hive

    final themeIndex = _themeModeBox.get(kThemeModeData);
    if (themeIndex != null) {
      _themeMode = ThemeMode.values[themeIndex];
    }
    notifyListeners();
  }
}
