import 'package:flustra_template/core/constants/app_images.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';

import 'common_dialog.dart';
import 'logout_dialog.dart';

/// 🗑️ Delete Account Dialog
Future<bool?> showDeleteAccountDialog() async {
  return await showCommonDialog(
    imagePath: AppAssetsImages.other.deleteAcc,
    title: AppStrings.deleteAccount.tx(),
    description: AppStrings.deleteAccountDesc.tx(),
    confirmText: AppStrings.yesDelete.tx(),
    onConfirm: safeLogout,
  );
}
