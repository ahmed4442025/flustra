import 'package:flutter/material.dart';

import '../constants/app_colors/app_colors.dart';
import 'base_theme_data.dart';

// ========================== 🔥 Types 🔥 ==========================

enum ThemeModeType { light, dark }

// ========================== 🔥 themes 🔥 ==========================

final ThemeData lightTheme = generateBaseThemeData(dark: false, c: ThemeModeType.light.getColors());

final ThemeData darkTheme = generateBaseThemeData(dark: true, c: ThemeModeType.dark.getColors());

// ========================== 🔥 ThemeModeExtension 🔥 ==========================

final _themeModeKeysMap = Map.fromEntries(ThemeModeType.values.map((e) => MapEntry(e.getThemeKey(), e)));

ThemeModeType? getThemeModeFromKey(String? key) => _themeModeKeysMap[key];

extension ThemeModeExtension on ThemeModeType? {
  String getThemeKey() {
    return switch (this) {
      ThemeModeType.light || null => 'light',
      ThemeModeType.dark => 'dark',
    };
  }

  ThemeData getTheme() => switch (this) {
    ThemeModeType.light || null => lightTheme,
    ThemeModeType.dark => darkTheme,
  };

  AppColorsBase getColors() => switch (this) {
    ThemeModeType.light || null => colorsManagerNormal,
    ThemeModeType.dark => colorsManagerDark,
  };
}
