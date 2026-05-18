import 'package:flustra_template/core/constants/app_colors/app_colors.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ╔══════════════════════════════════════════════════════════════════════════════╗
// ║  Theme Generator — Builds a complete ThemeData from semantic colors.        ║
// ║                                                                            ║
// ║  All component themes derive from [AppColorsBase] so that                  ║
// ║  Light ↔ Dark switching is a single-pivot change.                          ║
// ╚══════════════════════════════════════════════════════════════════════════════╝

ThemeData generateBaseThemeData({required AppColorsBase c, required bool dark}) {
  final brightness = dark ? Brightness.dark : Brightness.light;
  final iconBrightness = dark ? Brightness.light : Brightness.dark;

  // --------------------------[ ColorScheme ]-------------------------- //
  final colorScheme = (dark ? ColorScheme.dark : ColorScheme.light)(
    primary: c.primary,
    onPrimary: c.onPrimary,
    secondary: c.secondary,
    surface: c.surface,
    surfaceContainer: c.surfaceContainer,
    surfaceContainerHighest: c.surfaceContainerHigh,
    onSurface: c.onSurface,
    onSurfaceVariant: c.onSurfaceVariant,
    outline: c.outline,
    outlineVariant: c.outlineVariant,
    error: c.error,
  );

  return ThemeData(
    brightness: brightness,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: c.surface,
    hintColor: c.hint,
    fontFamily: "Cairo",

    // ========================== AppBar ==========================
    appBarTheme: AppBarTheme(
      backgroundColor: c.surface,
      centerTitle: true,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Modern UI: Transparent status bar
        systemNavigationBarColor: c.surface,
        statusBarIconBrightness: iconBrightness,
        systemNavigationBarIconBrightness: iconBrightness,
      ),
    ),

    // ========================== Typography ==========================
    textTheme: TextTheme(
      // -------------------------- display -------------------------- //
      displayLarge: TextStyle(fontSize: Dimensions.fontSizeOverLarge, fontWeight: FontWeight.bold, color: c.onSurface),
      displayMedium: TextStyle(fontSize: Dimensions.fontSizeOverLarge - 2, fontWeight: FontWeight.w600, color: c.onSurface),
      displaySmall: TextStyle(fontSize: Dimensions.fontSizeExtraLarge, fontWeight: FontWeight.w600, color: c.onSurface),
      // -------------------------- title -------------------------- //
      titleLarge: TextStyle(fontSize: Dimensions.fontSizeExtraLarge, fontWeight: FontWeight.bold, color: c.onSurface),
      titleMedium: TextStyle(fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.w600, color: c.onSurface),
      titleSmall: TextStyle(fontSize: Dimensions.fontSizeDefault, fontWeight: FontWeight.w400, color: c.onSurface),
      // -------------------------- body -------------------------- //
      bodyLarge: TextStyle(fontSize: Dimensions.fontSizeDefault, fontWeight: FontWeight.normal, color: c.onSurfaceVariant),
      bodyMedium: TextStyle(fontSize: Dimensions.fontSizeSmall, fontWeight: FontWeight.normal, color: c.onSurfaceVariant),
      bodySmall: TextStyle(fontSize: Dimensions.fontSizeExtraSmall, fontWeight: FontWeight.w400, color: c.onSurfaceVariant),
    ),

    // ========================== Progress / Icons / Dividers ==========================
    progressIndicatorTheme: ProgressIndicatorThemeData(color: c.primary),
    iconTheme: IconThemeData(color: c.primary),
    dividerTheme: DividerThemeData(color: c.outlineVariant),

    // ========================== Input Decoration ==========================
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: c.surfaceContainer,
      contentPadding: textFieldContentPadding,
      border: OutlineInputBorder(
        borderRadius: borderTextFieldRadius,
        borderSide: BorderSide(color: c.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderTextFieldRadius,
        borderSide: BorderSide(color: c.outline),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: borderTextFieldRadius,
        borderSide: BorderSide(color: c.error),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderTextFieldRadius,
        borderSide: BorderSide(color: c.primary, width: 1),
      ),
      hintStyle: TextStyle(color: c.hint),
    ),

    // ========================== Elevated Button ==========================
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: c.primary,
        foregroundColor: c.onPrimary,
        disabledBackgroundColor: c.disabledElement,
        disabledForegroundColor: c.onSurfaceVariant,
        textStyle: TextStyle(fontSize: Dimensions.fontSizeDefault, fontWeight: FontWeight.w600),
        minimumSize: buttonMinimumSize,
        padding: textFieldContentPadding,
        shape: RoundedRectangleBorder(borderRadius: borderTextFieldRadius),
      ),
    ),

    // ========================== Outlined Button ==========================
    outlinedButtonTheme: OutlinedButtonThemeData(
      style:
          OutlinedButton.styleFrom(
            foregroundColor: c.primary,
            disabledForegroundColor: c.disabledElement,
            side: BorderSide(color: c.primary),
            textStyle: TextStyle(fontSize: Dimensions.fontSizeDefault, fontWeight: FontWeight.w500),
            minimumSize: buttonMinimumSize,
            padding: textFieldContentPadding,
            shape: RoundedRectangleBorder(borderRadius: borderTextFieldRadius),
          ).copyWith(
            side: WidgetStateProperty.resolveWith(
              (states) => BorderSide(color: states.contains(WidgetState.disabled) ? c.disabledElement : c.primary),
            ),
          ),
    ),

    // ========================== Card ==========================
    cardTheme: CardThemeData(
      color: c.surfaceContainer,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: borderTextFieldRadius,
        side: BorderSide(color: c.outlineVariant, width: 1),
      ),
      margin: EdgeInsets.zero,
    ),

    // ========================== Dialog ==========================
    dialogTheme: DialogThemeData(
      backgroundColor: c.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge)),
    ),

    // ========================== Bottom Sheet ==========================
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: c.surfaceContainer,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.radiusExtraLarge))),
    ),

    // ========================== Chip ==========================
    chipTheme: ChipThemeData(
      backgroundColor: c.secondaryTint,
      selectedColor: c.primaryTint,
      labelStyle: TextStyle(fontSize: Dimensions.fontSizeSmall, color: c.onSurface),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusPill),
        side: BorderSide(color: c.outlineVariant),
      ),
    ),

    // ========================== Splash Factory ==========================
    splashFactory: NoSplash.splashFactory,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,

    // ========================== Bottom Navigation ==========================
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: c.surface,
      selectedItemColor: c.primary,
      unselectedItemColor: c.onSurfaceVariant,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
    ),
  );
}

// ========================== Shared Constants ==========================

const Size buttonMinimumSize = Size(100, 40);
final BorderRadius borderTextFieldRadius = BorderRadius.circular(Dimensions.radiusDefault);
const EdgeInsets textFieldContentPadding = EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeDefault);
