import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/main.dart';
import 'package:flutter/material.dart';

/// 🧩 Reusable confirmation dialog widget
Future<bool?> showCommonDialog({
  String? imagePath,
  IconData? icon,
  String? title,
  required String description,
  required String confirmText,
  required VoidCallback onConfirm,
  Color? programColor,
  bool showCancel = true,
}) async {
  return await showDialog<bool>(
    context: AppContext!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
        backgroundColor: AppColors.surfaceContainer,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🖼️ Image or Icon
              if (imagePath != null && imagePath.isNotEmpty)
                Image.asset(
                  imagePath,
                  width: 120,
                  height: 120,
                  errorBuilder: (_, _, _) => Icon(icon ?? Icons.info_outline, size: 80, color: AppColors.primary),
                )
              else
                Icon(icon ?? Icons.info_outline, size: 80, color: AppColors.primary),
              const SizedBox(height: 16),

              // 🧾 Title
              if (title != null) ...[
                Text(
                  title,
                  style: AppTextStyle.titleMedium.copyWith(fontWeight: FontWeight.w700, fontSize: 17),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
              ],
              // 📄 Description
              Text(
                description,
                textAlign: TextAlign.center,
                style: AppTextStyle.bodyMedium.copyWith(color: AppColors.onSurfaceVariant, height: 1.4),
              ),
              const SizedBox(height: 28),

              // 🧭 Action buttons
              Row(
                children: [
                  if (showCancel) ...[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => popIfUCan(result: false),
                        child: Text(
                          AppStrings.cancel.tx(),
                          style: AppTextStyle.bodyMedium.copyWith(color: AppColors.onSurface, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onConfirm,
                      child: FittedBox(
                        child: Text(
                          confirmText,
                          style: AppTextStyle.bodyMedium.copyWith(color: AppColors.onPrimary, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
