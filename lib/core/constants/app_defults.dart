import 'package:flustra_template/core/config/app_settings/app_settings_cubit.dart';
import 'package:flustra_template/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData get _theme => AppSettingsCubit.i.themeController.currentTheme;

AppColorsBase get _getAppColorsBase => AppSettingsCubit.i.themeController.currentColors;

// ========================== 🔥 App colors 🔥 ==========================

class AppColors {
  AppColors._();

  // ==========================  Primary Colors  ==========================
  /// Main primary color used throughout the app.
  static Color get primary => _theme.primaryColor;

  static Color get secondaryPrimary3 => _getAppColorsBase.accentOrange;

  static Color get secondaryPrimary => _theme.colorScheme.secondary;

  // ==========================  Text Colors  ==========================

  /// Default text color for general content.
  static Color get textPrimary => _getAppColorsBase.textPrimary;

  /// Secondary text color for less emphasis content.
  static Color get textSecondary => _getAppColorsBase.textSecondary;

  // ==========================  Background Colors  ==========================

  /// General background color for screens and containers.
  static Color get background => _theme.colorScheme.surface;

  /// Background color for cards and elevated containers.
  static Color get cardBackground => _theme.cardColor;

  /// Divider or section background to separate content.
  static Color get divider => _theme.dividerColor;

  // ==========================  Border Colors  ==========================

  /// Standard border color for inputs and containers.
  static Color get border => _getAppColorsBase.border;

  // ==========================  Button Colors  ==========================

  /// Disabled button color for inactive states.
  static Color get buttonDisabled => _getAppColorsBase.buttonDisabled;

  // ==========================  Status Colors  ==========================

  /// Success color for positive feedback.
  static Color get success => _getAppColorsBase.success;

  /// Warning color for caution messages.
  static Color get warning => _getAppColorsBase.warning;

  /// Error color for error messages and indicators.
  static Color get error => _theme.colorScheme.error;

  static Color get info => _getAppColorsBase.info;
}

// ========================== 🔥 Text Styles 🔥 ==========================
class AppTextStyle {
  AppTextStyle._();

  // -------------------------- display --------------------------
  static TextStyle get displayLarge => _theme.textTheme.displayLarge ?? TextStyle();

  static TextStyle get displayMedium => _theme.textTheme.displayMedium ?? TextStyle();

  static TextStyle get displaySmall => _theme.textTheme.displaySmall ?? TextStyle();

  // -------------------------- Title --------------------------
  static TextStyle get titleLarge => _theme.textTheme.titleLarge ?? TextStyle();

  static TextStyle get titleMedium => _theme.textTheme.titleMedium ?? TextStyle();

  static TextStyle get titleSmall => _theme.textTheme.titleSmall ?? TextStyle();

  // -------------------------- Body  --------------------------
  static TextStyle get bodyLarge => _theme.textTheme.bodyLarge ?? TextStyle();

  static TextStyle get bodyMedium => _theme.textTheme.bodyMedium ?? TextStyle();

  static TextStyle get bodySmall => _theme.textTheme.bodySmall ?? TextStyle();
}
