import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flutter/material.dart';

import 'common_dialog.dart';
import 'logout_dialog.dart';

/// 🗑️ Delete Account Dialog
Future<bool?> showDeleteAccountDialog() async {
  return await showCommonDialog(
    icon: Icons.delete_forever_rounded,
    title: AppStrings.deleteAccount.tx(),
    description: AppStrings.deleteAccountDesc.tx(),
    confirmText: AppStrings.yesDelete.tx(),
    onConfirm: safeLogout,
  );
}
