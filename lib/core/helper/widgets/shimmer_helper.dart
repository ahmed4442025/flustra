import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHelper {
  static final Color _shimmerBase = Colors.grey.shade200;
  static final Color _shimmerHighlighted = Colors.grey.shade300;

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
