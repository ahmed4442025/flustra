import 'dart:async';

import 'package:flutter/material.dart';

import 'app_theme.dart';

final ThemeController themeController = ThemeController();

// ========================== 🔥 controller 🔥 ==========================

class ThemeController {
  // -------------------------- variables --------------------------
  ThemeModeType _mode = ThemeModeType.light;

  ThemeModeType get mode => _mode;

  ThemeData _currentTheme = lightTheme;

  ThemeData get currentTheme => _currentTheme;

  // -------------------------- stream --------------------------
  final _themeController = StreamController<ThemeModeType>.broadcast();

  Stream<ThemeModeType> get themeStream => _themeController.stream;

  // -------------------------- methods --------------------------

  void changeTheme({required ThemeModeType mode}) {
    _mode = mode;
    _currentTheme = mode.getTheme();
    _themeController.sink.add(mode);
  }

  void dispose() => _themeController.close();
}

// ========================== 🔥 Types 🔥 ==========================

enum ThemeModeType {
  light,
  dark,
}

// ========================== 🔥 ThemeModeExtension 🔥 ==========================
extension ThemeModeExtension on ThemeModeType? {
  ThemeData getTheme() => switch (this) {
        ThemeModeType.light || null => lightTheme,
        ThemeModeType.dark => darkTheme,
      };
}
