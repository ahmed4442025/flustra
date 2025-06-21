import 'package:flustra_template/core/constants/app_colors.dart';
import 'package:flustra_template/core/constants/app_constant.dart';
import 'package:flutter/material.dart';

import 'app_theme.dart';

// ========================== 🔥 Controller 🔥 ==========================

class ThemeController {
  // -------------------------- Mode --------------------------
  ThemeModeType _mode = AppConstant.defaultThemeMode;

  ThemeModeType get mode => _mode;

  // -------------------------- Current theme --------------------------
  late ThemeData _currentTheme = mode.getTheme();

  ThemeData get currentTheme => _currentTheme;

  // -------------------------- Current color --------------------------
  late AppColorsBase _currentColors = mode.getColors();

  AppColorsBase get currentColors => _currentColors;

  // -------------------------- methods --------------------------

  /// don't call this method directly use [AppSettingsCubit.changeTheme]
  void changeTheme({required ThemeModeType mode, required Function() onChanged}) {
    _mode = mode;
    _currentColors = mode.getColors();
    _currentTheme = mode.getTheme();
    onChanged();
  }
}
