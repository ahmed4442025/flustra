import 'package:flustra_template/core/constants/app_images.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/core/services/app_session_manager.dart';
import 'package:flutter/material.dart';

import 'common_dialog.dart';

void safeLogout() {
  popIfUCan();
  AppSessionManager.logout();
  navigateTo(AppRoutes.login);
}

/// 🚪 Logout Dialog
Future<bool?> showLogoutConfirmationDialog() async {
  return await showCommonDialog(
    imagePath: AppAssetsImages.other.loggingOut,
    title: AppStrings.logout.tx(),
    description: AppStrings.logoutDesc.tx(),
    confirmText: AppStrings.yesLogOut.tx(),
    onConfirm: safeLogout,
  );
}
