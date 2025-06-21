import 'package:flutter/material.dart';

import '../../../main.dart';

/// Enum to represent the type of device
enum DeviceScreenType { mobile, tablet, desktop }

/// Singleton utility class to detect screen size and type
class AppResponsive {
  AppResponsive._();


  /// Access to current context
  static BuildContext get _context => navigatorKey.currentContext!;

  /// Get screen width
  static double get screenWidth => MediaQuery.of(_context).size.width;

  /// Get screen height
  static double get screenHeight => MediaQuery.of(_context).size.height;

  /// Get current orientation
  static Orientation get orientation => MediaQuery.of(_context).orientation;

  /// Check if device is mobile
  static bool get isMobile => screenWidth < 600;

  /// Check if device is tablet
  static bool get isTablet => screenWidth >= 600 && screenWidth < 1200;

  /// Check if device is desktop
  static bool get isDesktop => screenWidth >= 1200;

  /// Return device type as enum
  static DeviceScreenType get deviceType {
    if (isDesktop) return DeviceScreenType.desktop;
    if (isTablet) return DeviceScreenType.tablet;
    return DeviceScreenType.mobile;
  }
}
