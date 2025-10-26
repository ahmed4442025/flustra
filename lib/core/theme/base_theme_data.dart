import 'package:flustra_template/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData generateBaseThemeData({required AppColorsBase myColors, required bool dark}) {
  ColorScheme colorScheme = dark
      ? ColorScheme.dark(
          primary: myColors.primary,
          secondary: myColors.secondaryPrimary,
          surface: myColors.background,
          error: myColors.error,
        )
      : ColorScheme.light(
          brightness: dark ? Brightness.dark : Brightness.light,
          primary: myColors.primary,
          secondary: myColors.secondaryPrimary,
          surface: myColors.background,
          error: myColors.error,
        );

  return ThemeData(
    brightness: dark ? Brightness.dark : Brightness.light,
    scaffoldBackgroundColor: myColors.background,
    primaryColor: myColors.primary,
    colorScheme: colorScheme,

    // ========================== 🔥 AppBar 🔥 ==========================
    appBarTheme: AppBarTheme(
      backgroundColor: myColors.background,
      centerTitle: true,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: myColors.background, // Background color of the status bar [Android only]
        systemNavigationBarColor: myColors.background, // Background color of the navigation bar [Android only]

        statusBarIconBrightness: dark ? Brightness.light : Brightness.dark, // Icon brightness for status bar [IOS]
        systemNavigationBarIconBrightness: dark ? Brightness.light : Brightness.dark, // Icon brightness for nav bar [Android only]
      ),
    ),
    // -------------------------------------------------------------------------

    // ========================== 🔥 Fonts 🔥 ==========================
    fontFamily: "poppins",

    textTheme: TextTheme(
      // -------------------------- display --------------------------
      displayLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: myColors.textPrimary),
      displayMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: myColors.textPrimary),
      displaySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: myColors.textPrimary),

      // -------------------------- title --------------------------
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: myColors.textPrimary),
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: myColors.textPrimary),
      titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: myColors.textPrimary),

      // -------------------------- body --------------------------
      bodyLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: myColors.textPrimary),
      bodyMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: myColors.textSecondary),
      bodySmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: myColors.textSecondary),
    ),
    // -------------------------------------------------------------------------

    // ========================== 🔥 CircularProgressIndicator 🔥 ==========================
    progressIndicatorTheme: ProgressIndicatorThemeData(color: myColors.primary),

    // ========================== 🔥 Icon 🔥 ==========================
    iconTheme: IconThemeData(color: myColors.primary),

    // ========================== 🔥 Input decoration [TextField , DropDown , .... ] 🔥 ==========================
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: myColors.cardBackground,
      contentPadding: textFieldContentPadding,
      border: OutlineInputBorder(borderRadius: borderTextFieldRadius, borderSide: BorderSide(color: myColors.border)),
      enabledBorder: OutlineInputBorder(borderRadius: borderTextFieldRadius, borderSide: BorderSide(color: myColors.border)),
      errorBorder: OutlineInputBorder(borderRadius: borderTextFieldRadius, borderSide: BorderSide(color: myColors.error)),
      focusedBorder: OutlineInputBorder(borderRadius: borderTextFieldRadius, borderSide: BorderSide(color: myColors.primary, width: 1)),
      hintStyle: TextStyle(color: myColors.textSecondary),
    ),
    // -------------------------------------------------------------------------

// ========================== 🔥 Elevated Button 🔥 ==========================
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.disabled) ?  myColors.buttonDisabled : myColors.primary),
        foregroundColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.disabled) ? null : Colors.white),
        textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        minimumSize: WidgetStateProperty.all(buttonMinimumSize),
        padding: WidgetStateProperty.all(textFieldContentPadding),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: borderTextFieldRadius)),
      ),
    ),
    // -------------------------------------------------------------------------

    // ========================== 🔥 OutlinedButton 🔥 ==========================
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.disabled) ? Colors.grey : myColors.primary),
        side: WidgetStateProperty.resolveWith<BorderSide?>(
            (states) => (states.contains(WidgetState.disabled)) ? null : BorderSide(color: myColors.primary)),
        minimumSize: WidgetStateProperty.all(buttonMinimumSize),
        textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        padding: WidgetStateProperty.all(textFieldContentPadding),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: borderTextFieldRadius)),
      ),
    ),

    // -------------------------------------------------------------------------

    // ========================== 🔥 TextButton 🔥 ==========================
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: myColors.accentOrange,
        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),
    // -------------------------------------------------------------------------

    // ========================== 🔥 CardThemeData 🔥 ==========================
    cardColor: myColors.cardBackground,
    cardTheme: CardThemeData(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: borderTextFieldRadius),
      color: myColors.cardBackground,
    ),
    // -------------------------------------------------------------------------

    // ========================== 🔥 InkWell 🔥 ==========================
    splashFactory: NoSplash.splashFactory,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    // ========================== 🔥 FAB 🔥 ==========================
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: myColors.accentOrange,
      foregroundColor: Colors.white,
    ),
    // -------------------------------------------------------------------------
    // ========================== 🔥 DividerThemeData 🔥 ==========================
    dividerColor: myColors.divider,
    dividerTheme: DividerThemeData(color: myColors.divider),
    // -------------------------------------------------------------------------

    // ========================== 🔥 Switch Theme 🔥 ==========================
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) => Colors.white),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return myColors.secondaryPrimary;
        return myColors.buttonDisabled;
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) => Colors.transparent),
      thumbIcon: WidgetStateProperty.all(Icon(Icons.circle, color: Colors.white)),
    ),
    // -------------------------------------------------------------------------

    // ========== 🔥 BottomNavigationBarThemeData 🔥 ==========
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: myColors.primary,
      selectedItemColor: myColors.secondaryPrimary,
      unselectedItemColor: myColors.cardBackground,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
    ),
    // -------------------------------------------------------------------------
  );
}

const Size buttonMinimumSize = Size(100, 40);

final BorderRadius borderTextFieldRadius = BorderRadius.circular(5);

const EdgeInsets textFieldContentPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 12);
