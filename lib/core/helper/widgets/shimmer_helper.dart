import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHelper {
  static Color get _shimmerBase => AppColors.isDark ? Colors.grey.shade800 : Colors.grey.shade200;

  static Color get _shimmerHighlighted => AppColors.isDark ? Colors.grey.shade700 : Colors.grey.shade300;

  static Widget buildBasicShimmer({double height = double.infinity, double width = double.infinity, double radios = 0}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radios),
      child: Shimmer.fromColors(
        baseColor: _shimmerBase,
        highlightColor: _shimmerHighlighted,
        child: Container(
          color: Colors.white,
          height: height,
          width: width,
        ),
      ),
    );
  }

  static Widget buildBasicShimmerCircular({double radios = 50}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radios),
      child: buildBasicShimmer(height: radios, width: radios),
    );
  }
}
