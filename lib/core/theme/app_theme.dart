import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'base_theme_data.dart';

// ========================== 🔥 Types 🔥 ==========================

enum ThemeModeType {
  lightDeepBlue,
  darkDeepBlue,
  purple,
  lightCyan,
  darkCyan,
}

// ========================== 🔥 themes 🔥 ==========================

final ThemeData lightDeepBlueTheme = generateBaseThemeData(dark: false, myColors: ThemeModeType.lightDeepBlue.getColors());

final ThemeData purpleTheme = generateBaseThemeData(dark: false, myColors: ThemeModeType.purple.getColors());

final ThemeData darkDeepBlueTheme = generateBaseThemeData(dark: true, myColors: ThemeModeType.darkDeepBlue.getColors());

final ThemeData lightCyanTheme = generateBaseThemeData(dark: false, myColors: ThemeModeType.lightCyan.getColors());

final ThemeData darkCyanTheme = generateBaseThemeData(dark: true, myColors: ThemeModeType.darkCyan.getColors());

// ========================== 🔥 ThemeModeExtension 🔥 ==========================
final _themeModeKeysMap = Map.fromEntries(ThemeModeType.values.map((e) => MapEntry(e.getThemeKey(), e)));

ThemeModeType? getThemeModeFromKey(String? key) => _themeModeKeysMap[key];

extension ThemeModeExtension on ThemeModeType? {
  String getThemeKey() {
    return switch (this) {
      ThemeModeType.lightDeepBlue || null => 'lightDeepBlue',
      ThemeModeType.darkDeepBlue => 'darkDeepBlue',
      ThemeModeType.purple => 'purple',
      ThemeModeType.lightCyan => 'lightCyan',
      ThemeModeType.darkCyan => 'darkCyan',
    };
  }

  ThemeData getTheme() => switch (this) {
        ThemeModeType.lightDeepBlue || null => lightDeepBlueTheme,
        ThemeModeType.darkDeepBlue => darkDeepBlueTheme,
        ThemeModeType.purple => purpleTheme,
        ThemeModeType.lightCyan => lightCyanTheme,
        ThemeModeType.darkCyan => darkCyanTheme,
      };

  AppColorsBase getColors() => switch (this) {
        ThemeModeType.lightDeepBlue || null => colorsManagerNormal,
        ThemeModeType.darkDeepBlue => colorsManagerDark,
        ThemeModeType.purple => colorsManagerPurple,
        ThemeModeType.lightCyan => colorsManagerCyan,
        ThemeModeType.darkCyan => colorsManagerCyanDark,
      };
}
