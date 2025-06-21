import 'package:flustra_template/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageAssetWidget extends StatelessWidget {
  /// The path to the asset, e.g., 'assets/images/my_logo.svg'.
  final String assetPath;

  /// The width of the image.
  final double? width;

  /// when use it will return circular image
  final bool? circular;

  /// The height of the image.
  final double? height;

  /// How the image should be inscribed into the box.
  /// Defaults to [BoxFit.cover].
  final BoxFit fit;

  /// The color to tint the image.
  /// For SVGs, this directly applies a color filter.
  /// For raster images, this is used with [colorBlendMode].
  final Color? color;

  /// The blend mode to apply when using [color].
  /// Defaults to [BlendMode.srcIn] for raster images.
  final BlendMode? colorBlendMode;

  /// The border radius to clip the image.
  /// If null, the image will not be clipped.
  final BorderRadius? borderRadius;

  /// A semantic description of the image for accessibility.
  final String? semanticsLabel;

  const ImageAssetWidget({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.circular,
    this.fit = BoxFit.cover,
    this.color,
    this.borderRadius,
    this.colorBlendMode,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    // The core logic: check if the asset path ends with .svg (case-insensitive)
    final bool isSvg = assetPath.toLowerCase().endsWith('.svg');

    Widget imageWidget;

    if (isSvg) {
      imageWidget = SvgPicture.asset(
        assetPath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => _buildErrorWidget(),
        colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        semanticsLabel: semanticsLabel,
      );
    } else {
      imageWidget = Image.asset(
        assetPath,
        width: width,
        height: height,
        fit: fit,
        color: color,
        errorBuilder: (_, __, ___) => _buildErrorWidget(),
        colorBlendMode: colorBlendMode,
        semanticLabel: semanticsLabel,
      );
    }

    // If borderRadius is provided, wrap the image widget in a ClipRRect
    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    if (circular == true) {
      return Center(
        child: ClipOval(
          child: imageWidget,
        ),
      );
    }

    return imageWidget;
  }

  /// Builds a placeholder widget to display when the asset fails to load.
  Widget _buildErrorWidget() {
    return Icon(
        Icons.image_not_supported_outlined,
        color: Colors.grey.shade400,
        // Make the icon size proportional to the widget size, with a fallback.
        size: width != null ? width!  : 24,
      );
    return Image.asset(AppAssetsImages.logo.logo,width: width,height: height);
  }
}
