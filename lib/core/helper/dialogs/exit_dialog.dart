import 'dart:io';

import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/core/services/console_printer.dart';
import 'package:flustra_template/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemNavigator;

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

Future<bool?> showExitConfirmationDialog() async {
  return await showDialog<bool>(
    context: AppContext!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppStrings.exitApp.tx()),
        content: SingleChildScrollView(child: ListBody(children: <Widget>[Text(AppStrings.exitDesc.tx())])),
        actions: <Widget>[
          TextButton(child: Text(AppStrings.cancel.tx()), onPressed: () => popIfUCan(result: false)),
          TextButton(onPressed: _safeExitApp, child: Text(AppStrings.exit.tx())),
        ],
      );
    },
  );
}
