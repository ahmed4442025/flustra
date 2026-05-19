import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/color.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  final String message;

  const BannerWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    if (message.isEmpty) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeExtraLarge,
        vertical: Dimensions.paddingSizeLarge,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacityEX(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -10,
            bottom: -20,
            child: Icon(
              Icons.local_offer_outlined,
              size: 90,
              color: AppColors.onPrimary.withOpacityEX(0.08),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.onPrimary.withOpacityEX(0.15),
                  borderRadius: BorderRadius.circular(
                    Dimensions.radiusExtraSmall,
                  ),
                ),
                child: Text(
                  'SPECIAL OFFER',
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Text(
                message,
                style: AppTextStyle.titleLarge.copyWith(
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.w800,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
