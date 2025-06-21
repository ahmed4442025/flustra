import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/main.dart';
import 'package:flutter/material.dart';

enum ToastType {
  success,
  error,
  info,
  warning,
}

class AppSnackBar {
  AppSnackBar._();

  static void show(String? message, {BuildContext? context, ToastType? type}) {
    if (message == null) return;
    context ??= AppContext!;

    Color bgColor = switch (type) {
      ToastType.success || null => AppColors.success,
      ToastType.info => AppColors.info,
      ToastType.error => AppColors.error,
      ToastType.warning => AppColors.warning,
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor,
      ),
    );
  }
}
