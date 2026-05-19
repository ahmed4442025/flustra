import 'dart:io';

import 'package:flustra_template/core/constants/app_images.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/core/services/console_printer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show SystemNavigator;

import 'common_dialog.dart';

// --------------------------[ _safeExitApp ]-------------------------- //
void _safeExitApp() {
  if (kIsWeb) return;

  if (Platform.isAndroid || Platform.isFuchsia) {
    SystemNavigator.pop();
  } else if (Platform.isIOS) {
    ("iOS doesn't allow programmatically exiting the app.").printWithColor(textColor: ConsoleColor.red);
  } else {
    // Windows, macOS, Linux
    exit(0);
  }
}

// --------------------------[ showExitConfirmationDialog ]-------------------------- //
/// 🚪 Exit Confirmation Dialog
Future<bool?> showExitConfirmationDialog() async {
  return await showCommonDialog(
    imagePath: AppAssetsImages.other.exitApp,
    title: AppStrings.exitApp.tx(),
    description: AppStrings.exitDesc.tx(),
    confirmText: AppStrings.exit.tx(),
    onConfirm: _safeExitApp,
  );
}
