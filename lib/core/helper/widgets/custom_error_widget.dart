import 'package:flutter/material.dart';

import '../../constants/app_defults.dart';
import '../../extensions/color.dart';
import '../../extensions/trans_extention.dart';
import '../../localization/app_strings_localizations.dart';
import '../utils/dimensions.dart';

/// ✅ ويدجت موحدة لعرض حالات الخطأ وانقطاع الاتصال مع زر إعادة المحاولة
class CustomErrorWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const CustomErrorWidget({
    super.key,
    this.title,
    this.message,
    this.onRetry,
    this.icon,
    this.image,
  });

  // ========================== 🗝️ Public variables 🗝️ ========================== //
  final String? title;
  final String? message;
  final VoidCallback? onRetry;
  final IconData? icon;
  final String? image;

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // --------------------------[ Visual Icon/Image ]-------------------------- //
            _buildVisual(),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            // --------------------------[ Title ]-------------------------- //
            _buildTitle(),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            // --------------------------[ Message ]-------------------------- //
            _buildMessage(),
            if (onRetry != null) ...[
              const SizedBox(height: Dimensions.paddingSizeExtraLarge),
              // --------------------------[ Retry Button ]-------------------------- //
              _buildRetryButton(),
            ],
          ],
        ),
      ),
    );
  }

  // ========================== 🔒 Private methods 🔒 ========================== //

  // --------------------------[ _buildVisual ]-------------------------- //
  Widget _buildVisual() {
    if (image != null) {
      return Image.asset(image!, width: 100, height: 100);
    }
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: AppColors.error.withOpacityEX(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon ?? Icons.cloud_off_rounded,
        size: 36,
        color: AppColors.error,
      ),
    );
  }

  // --------------------------[ _buildTitle ]-------------------------- //
  Widget _buildTitle() {
    return Text(
      title ?? AppStrings.somethingWentWrong.tx(),
      textAlign: TextAlign.center,
      style: AppTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold),
    );
  }

  // --------------------------[ _buildMessage ]-------------------------- //
  Widget _buildMessage() {
    return Text(
      message ?? AppStrings.failedToLoadData.tx(),
      textAlign: TextAlign.center,
      style: AppTextStyle.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
    );
  }

  // --------------------------[ _buildRetryButton ]-------------------------- //
  Widget _buildRetryButton() {
    return ElevatedButton.icon(
      onPressed: onRetry,
      icon: const Icon(Icons.refresh_rounded, size: 18),
      label: Text(AppStrings.retry.tx()),
    );
  }
}
