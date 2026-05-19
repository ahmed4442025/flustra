import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/context_get_x.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/app_card.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/core/services/app_session_manager.dart';
import 'package:flutter/material.dart';

class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final amILogin = AppSessionManager.amILogin;
    final userName = AppSessionManager.name ?? '';
    final userEmail = AppSessionManager.email ?? '';
    final _ = context.theme; // هذا هو السحر

    return AppCard(
      child: Row(
        children: [
          // Dynamic Avatar or Initials
          _buildAvatar(userName),
          const SizedBox(width: Dimensions.paddingScreen),

          // Dynamic Profile Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  amILogin ? userName : AppStrings.guest.tx(),
                  style: AppTextStyle.titleMedium.copyWith(color: AppColors.onSurface, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                Text(
                  amILogin ? userEmail : AppStrings.guestDesc.tx(),
                  style: AppTextStyle.bodySmall.copyWith(color: AppColors.onSurfaceVariant),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (amILogin) ...[
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Row(
                    children: [
                      _buildBadge(AppStrings.admin.tx(), AppColors.primary, AppColors.primaryTint),
                      const SizedBox(width: Dimensions.paddingSizeSmall),
                      _buildOnlineBadge(),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String name) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        _getInitials(name),
        style: AppTextStyle.titleMedium.copyWith(color: AppColors.onPrimary, fontWeight: FontWeight.bold),
      ),
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty || name == '__') return 'G';
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  Widget _buildBadge(String text, Color textColor, Color bgColor) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(Dimensions.radiusPill)),
      child: Text(
        text,
        style: AppTextStyle.bodySmall.copyWith(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildOnlineBadge() {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
      decoration: BoxDecoration(color: AppColors.accentTint, borderRadius: BorderRadius.circular(Dimensions.radiusPill)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.accent, // Use accent from design system
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: Dimensions.paddingSizeExtraSmall),
          Text(
            AppStrings.online.tx(),
            style: AppTextStyle.bodySmall.copyWith(color: AppColors.accent, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
