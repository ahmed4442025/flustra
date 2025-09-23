import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Manages system UI elements like the status bar and system navigation bar.
class AppStatusBarManager {
  /// Sets the system status bar and navigation bar styles.
  ///
  /// [isDarkIcons] determines if the status bar icons (Android) and status bar text (iOS)
  /// should be dark or light.
  ///
  /// [statusBarAndroidColor] sets the background color of the status bar (Android only).
  /// Default is transparent.
  ///
  /// [navigationBarAndroidColor] sets the color of the system navigation bar (Android only).
  /// Default is black.

  static SystemUiOverlayStyle getSystemUIOverlayStyle({
    required bool isDarkIcons,
    Color statusBarAndroidColor = Colors.transparent, // Android only
    Color navigationBarAndroidColor = Colors.black, // Android only
  }) {
    return SystemUiOverlayStyle(
      // Android only
      statusBarColor: statusBarAndroidColor,
      statusBarIconBrightness: isDarkIcons ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: navigationBarAndroidColor,
      systemNavigationBarIconBrightness: isDarkIcons ? Brightness.dark : Brightness.light,

      // iOS only
      statusBarBrightness: isDarkIcons ? Brightness.light : Brightness.dark,
    );
  }

  static void changeStatusBarColorBasedOnCurrentTheme() async {
    var r = getSystemUIOverlayStyle(
      isDarkIcons: !AppColors.isDark,
      // isDarkIcons: true,
      navigationBarAndroidColor: AppColors.isDark ? Colors.black : Colors.white,
      statusBarAndroidColor: AppColors.isDark ? Colors.black : Colors.white,
    );
    // await Future.delayed(Duration(milliseconds: 1000));
    SystemChrome.setSystemUIOverlayStyle(r);
  }
}
