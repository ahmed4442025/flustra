import 'package:flutter/material.dart';

import '../widgets/shimmer_helper.dart';

class ShimmerTemplates {
  static Widget productCard({double width = double.infinity}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerHelper.buildBasicShimmer(height: 150, width: width, radios: 8),
        const SizedBox(height: 8),
        ShimmerHelper.buildBasicShimmer(height: 16, width: width * 0.6),
        const SizedBox(height: 4),
        ShimmerHelper.buildBasicShimmer(height: 14, width: width * 0.3),
      ],
    );
  }

  static Widget listTile() {
    return Row(
      children: [
        ShimmerHelper.buildBasicShimmerCircular(radios: 40),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerHelper.buildBasicShimmer(height: 16, width: double.infinity),
              const SizedBox(height: 8),
              ShimmerHelper.buildBasicShimmer(height: 12, width: 150),
            ],
          ),
        )
      ],
    );
  }

  static Widget profileHeader() {
    return Column(
      children: [
        ShimmerHelper.buildBasicShimmerCircular(radios: 60),
        const SizedBox(height: 12),
        ShimmerHelper.buildBasicShimmer(height: 18, width: 100),
        const SizedBox(height: 6),
        ShimmerHelper.buildBasicShimmer(height: 14, width: 150),
      ],
    );
  }

  static Widget horizontalListItem() {
    return Row(
      children: List.generate(5, (index) {
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ShimmerHelper.buildBasicShimmer(height: 100, width: 80, radios: 8),
        );
      }),
    );
  }

  static Widget gridItem() {
    return ShimmerHelper.buildBasicShimmer(height: 150, width: double.infinity, radios: 10);
  }

  static Widget postCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerHelper.buildBasicShimmer(height: 180, width: double.infinity, radios: 10),
        const SizedBox(height: 12),
        ShimmerHelper.buildBasicShimmer(height: 16, width: 200),
        const SizedBox(height: 8),
        ShimmerHelper.buildBasicShimmer(height: 14, width: 250),
      ],
    );
  }

  static Widget banner() {
    return ShimmerHelper.buildBasicShimmer(height: 120, width: double.infinity, radios: 10);
  }

  static Widget avatarWithText() {
    return Column(
      children: [
        ShimmerHelper.buildBasicShimmerCircular(radios: 50),
        const SizedBox(height: 8),
        ShimmerHelper.buildBasicShimmer(height: 14, width: 60),
      ],
    );
  }
}
