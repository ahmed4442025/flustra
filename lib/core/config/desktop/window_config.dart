import 'package:flustra_template/core/constants/app_constant.dart';
import 'package:flustra_template/core/helper/shared_methods.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WindowInitializer {
  static Future<void> init() async {
    if (!isDesktop) {
      // ❌ لو مش على desktop، بلاش تشغل window_manager
      return;
    }
    await windowManager.ensureInitialized();

    const windowOptions = WindowOptions(
      size: Size(600, 700),
      minimumSize: Size(300, 600),
      center: true,
      backgroundColor: Colors.transparent,
      // skipTaskbar: false,
      title: AppConstant.appName,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
}
