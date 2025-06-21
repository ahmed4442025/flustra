// ========================== 🔥 botToast 🔥 ==========================

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:pripo/core/constants/app_defults.dart';

import '../app_snake_bar.dart';
export '../app_snake_bar.dart';

class AppBotToast {
  static void show(String? message, {ToastType? type}) {
    if (message == null || message.trim().isEmpty) return;

    Color bgColor = switch (type) {
      ToastType.success || null => AppColors.success,
      ToastType.info => AppColors.info,
      ToastType.error => AppColors.error,
      ToastType.warning => AppColors.warning,
    };

    BotToast.showCustomText(
      duration: const Duration(seconds: 3),
      toastBuilder: (_) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(message, style: AppTextStyle.bodyMedium.copyWith(color: Colors.white)),
      ),
      onlyOne: true,
      clickClose: true,
      crossPage: true,
      align: Alignment.bottomCenter,
    );
  }
}
