import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/color.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/app_card.dart';
import 'package:flutter/material.dart';

class SettingsGroupWidget extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const SettingsGroupWidget({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: Dimensions.paddingSizeExtraSmall, bottom: Dimensions.paddingSizeSmall),
          child: Text(
            title,
            style: AppTextStyle.bodySmall.copyWith(color: AppColors.onSurfaceVariant, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
        ),
        AppCard(
          padding: EdgeInsets.zero,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, index) => Divider(height: 1, color: AppColors.outlineVariant.withOpacityEX(0.4)),
            itemBuilder: (_, index) => items[index],
          ),
        ),
      ],
    );
  }
}
