import 'package:flustra_template/core/theme/app_status_bar_manager.dart';
import 'package:flutter/services.dart';

class MobileConfig {
  static void init() {
    lockOrientationToPortrait();
    Future.delayed(Duration(milliseconds: 0), () => AppStatusBarManager.changeStatusBarColorBasedOnCurrentTheme());
    Future.delayed(Duration(milliseconds: 2000), () => AppStatusBarManager.changeStatusBarColorBasedOnCurrentTheme());
  }

  /// Locks the device orientation to portrait mode only.
  static Future<void> lockOrientationToPortrait() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
