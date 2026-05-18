import 'package:flustra_template/core/config/app_settings/app_settings_cubit.dart';
import 'package:flustra_template/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData get _theme => AppSettingsCubit.i.themeController.currentTheme;

AppColorsBase get _colors => AppSettingsCubit.i.themeController.currentColors;

class AppColors {
  AppColors._();

  // ========================== Mode ==========================

  /// True when app is in dark mode — use for conditional shimmer, icons, etc.
  static bool get isDark => _theme.brightness == Brightness.dark;

  // ========================== Brand / Primary ==========================

  /// Main brand color — CTA buttons, FABs, active indicators.
  static Color get primary => _colors.primary;

  /// Hover/focus state color for primary buttons and interactive elements.
  static Color get primaryHover => _colors.primaryHover;

  /// Subtle primary color tint for active chips and soft container fills.
  static Color get primaryTint => _colors.primaryTint;

  /// Slightly stronger primary tint for selected states or interactive shapes.
  static Color get primaryTint2 => _colors.primaryTint2;

  /// Tinted variant — chips, secondary actions, links.
  static Color get secondary => _colors.secondary;

  /// Subtle secondary tint for sub-container background fills.
  static Color get secondaryTint => _colors.secondaryTint;

  /// Text/icon ON a primary-colored surface.
  static Color get onPrimary => _colors.onPrimary;

  // ========================== Surfaces ==========================

  /// Main page background (Scaffold).
  static Color get surface => _colors.surface;

  /// Elevated containers — cards, bottom sheets, dialogs.
  static Color get surfaceContainer => _colors.surfaceContainer;

  /// Highest-level surface — sticky headers, search bars.
  static Color get surfaceContainerHigh => _colors.surfaceContainerHigh;

  // ========================== Content / On-surface ==========================

  /// Primary text & icons — headings, body copy.
  static Color get onSurface => _colors.onSurface;

  /// Secondary text — subtitles, timestamps, hints.
  static Color get onSurfaceVariant => _colors.onSurfaceVariant;

  // ========================== Outline / Borders ==========================

  /// Medium-emphasis borders — input fields, card edges.
  static Color get outline => _colors.outline;

  /// Low-emphasis borders — dividers, separators.
  static Color get outlineVariant => _colors.outlineVariant;

  // ========================== States ==========================

  /// Disabled buttons, chips, inactive controls.
  static Color get disabledElement => _colors.disabledElement;

  // ========================== Accent / Green Success ==========================

  /// Accent color — success badges, tags, highlights.
  static Color get accent => _colors.accent;

  /// Darker accent variant for text and high-contrast indicators.
  static Color get accentDeep => _colors.accentDeep;

  /// Muted tint of accent color for chip backgrounds.
  static Color get accentTint => _colors.accentTint;

  // ========================== Status / Semantic ==========================

  /// Errors, destructive actions, validation.
  static Color get error => _colors.error;

  /// Muted error tint for card alerts.
  static Color get errorTint => _colors.errorTint;

  /// Success confirmations, completed.
  static Color get success => _colors.success;

  /// Warnings, caution banners, pending.
  static Color get warning => _colors.warning;

  /// Muted warning tint for warning backgrounds.
  static Color get warningTint => _colors.warningTint;

  /// Info messages, tips, neutral alerts.
  static Color get info => _colors.info;

  /// Muted info tint for supportive backgrounds.
  static Color get infoTint => _colors.infoTint;

  /// Neutral slate color.
  static Color get cold => _colors.cold;

  /// Muted slate tint.
  static Color get coldTint => _colors.coldTint;

  /// Hint color for placeholder text and subtle notes.
  static Color get hint => _colors.hint;

  /// Overlay color for modal backdrops.
  static Color get overlay => _colors.overlay;
}

// ╔══════════════════════════════════════════════════════════════════════════════╗
// ║  AppTextStyle — Pre-configured text styles from the theme.                   ║
// ║                                                                              ║
// ║  Pick the closest style and .copyWith() for tweaks.                          ║
// ╚══════════════════════════════════════════════════════════════════════════════╝

class AppTextStyle {
  AppTextStyle._();

  // --------------------------[ Display ]-------------------------- //
  static TextStyle get displayLarge => _theme.textTheme.displayLarge ?? TextStyle();

  static TextStyle get displayMedium => _theme.textTheme.displayMedium ?? TextStyle();

  static TextStyle get displaySmall => _theme.textTheme.displaySmall ?? TextStyle();

  // --------------------------[ Title ]-------------------------- //
  static TextStyle get titleLarge => _theme.textTheme.titleLarge ?? TextStyle();

  static TextStyle get titleMedium => _theme.textTheme.titleMedium ?? TextStyle();

  static TextStyle get titleSmall => _theme.textTheme.titleSmall ?? TextStyle();

  // --------------------------[ Body ]-------------------------- //
  static TextStyle get bodyLarge => _theme.textTheme.bodyLarge ?? TextStyle();

  static TextStyle get bodyMedium => _theme.textTheme.bodyMedium ?? TextStyle();

  static TextStyle get bodySmall => _theme.textTheme.bodySmall ?? TextStyle();
}
