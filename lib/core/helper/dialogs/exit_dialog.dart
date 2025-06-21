import 'dart:io';

import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemNavigator;

void _safeExitApp() {
  if (Platform.isAndroid) {
    // على الويب لا يمكن إغلاق التطبيق يدويًا
    return;
  }

  if (Platform.isAndroid || Platform.isFuchsia) {
    SystemNavigator.pop();
  } else if (Platform.isIOS) {
    // iOS ما بيسمحش بإغلاق التطبيق يدويًا، عادةً ما يتم تجاهلها
  } else {
    // Windows, macOS, Linux
    exit(0);
  }
}

Future<bool?> showExitConfirmationDialog() async {
  return await showDialog<bool>(
    context: AppContext!,
    barrierDismissible: false, // لا يمكن إغلاق الصندوق بالضغط خارجه
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('تأكيد الخروج'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('هل أنت متأكد من رغبتك في الخروج من التطبيق؟'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('إلغاء'),
            onPressed: () => popIfUCan(result: false),
          ),
          TextButton(
            onPressed: _safeExitApp,
            child: const Text('خروج'),
          ),
        ],
      );
    },
  );
}
