import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/color.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/shimmer_helper.dart';
import 'package:flutter/material.dart';

class CategoryListWidget extends StatelessWidget {
  final bool loading;
  final List<String>? categories;
  final String? selectedCategory;
  final ValueChanged<String?>? onCategorySelected;

  const CategoryListWidget({
    super.key,
    required this.loading,
    this.categories,
    this.selectedCategory,
    this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: AppTextStyle.titleMedium.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        SizedBox(
          height: 42,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: loading ? 6 : (categories?.length ?? 0) + 1,
            itemBuilder: (context, index) {
              if (loading) {
                return ShimmerHelper.buildBasicShimmer(
                  height: 38,
                  width: 90,
                  radios: Dimensions.radiusSmall,
                );
              }

              final isAll = index == 0;
              final category = isAll ? 'All' : categories![index - 1];
              final isSelected = isAll
                  ? (selectedCategory == null)
                  : selectedCategory == category;

              return GestureDetector(
                onTap: () {
                  if (onCategorySelected != null) {
                    onCategorySelected!(isAll ? null : category);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.surfaceContainer,
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.outlineVariant,
                      width: 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withOpacityEX(0.15),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      category,
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: isSelected
                            ? AppColors.onPrimary
                            : AppColors.onSurfaceVariant,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(width: Dimensions.paddingSizeSmall),
          ),
        ),
      ],
    );
  }
}
