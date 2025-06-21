import 'package:flutter/material.dart';
import 'package:pripo/main.dart';

/// Enum to represent the type of device
enum DeviceScreenType { mobile, tablet, desktop }

/// Singleton utility class to detect screen size and type
class AppResponsive {
  AppResponsive._();


  /// Access to current context
  BuildContext get _context => navigatorKey.currentContext!;

  /// Get screen width
  double get screenWidth => MediaQuery.of(_context).size.width;

  /// Get screen height
  double get screenHeight => MediaQuery.of(_context).size.height;

  /// Get current orientation
  Orientation get orientation => MediaQuery.of(_context).orientation;

  /// Check if device is mobile
  bool get isMobile => screenWidth < 600;

  /// Check if device is tablet
  bool get isTablet => screenWidth >= 600 && screenWidth < 1200;

  /// Check if device is desktop
  bool get isDesktop => screenWidth >= 1200;

  /// Return device type as enum
  DeviceScreenType get deviceType {
    if (isDesktop) return DeviceScreenType.desktop;
    if (isTablet) return DeviceScreenType.tablet;
    return DeviceScreenType.mobile;
  }
}
