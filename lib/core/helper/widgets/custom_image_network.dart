import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/app_images.dart';

class CachedImageWidget extends StatelessWidget {
  final String? imageUrl;
  final Widget? errorWidget;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool isCircle;
  final bool enableBorder;
  final BorderRadiusGeometry? borderRadius;

  const CachedImageWidget(
      {super.key,
        required this.imageUrl,
        this.width,
        this.height,
        this.fit,
        this.borderRadius,
        this.isCircle = false,
        this.enableBorder = false,
        this.errorWidget});

  @override
  Widget build(BuildContext context) {
    if (borderRadius != null) return buildClipRRect(borderRadius!);
    return buildCachedNetworkImage();
  }

  ClipRRect buildClipRRect(BorderRadiusGeometry radius) {
    return ClipRRect(
      borderRadius: radius,
      child: buildCachedNetworkImage(),
    );
  }

  Widget buildCachedNetworkImage() {
    if (imageUrl == null || imageUrl!.isEmpty) return buildErrorWidget();
    return RepaintBoundary(
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        height: height,
        width: width,
        fit: fit,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            border: enableBorder == true ? Border.all(color: const Color(0xff9DFFDC), width: 0.6) : null,
            shape: isCircle == true ? BoxShape.circle : BoxShape.rectangle,
            image: DecorationImage(
              image: imageProvider,
              fit: fit ?? BoxFit.cover,
            ),
          ),
        ),
        errorWidget: (_, __, ___) => buildErrorWidget(),
      ),
    );
  }

  Widget buildErrorWidget() {
    if (errorWidget != null) return errorWidget!;
    if (isCircle) return CircleAvatar(backgroundImage: AssetImage(AppAssetsImages.logo.logo), radius: (width ?? 50) / 2);
    return Image.asset(
      AppAssetsImages.logo.logo,
      width: width,
      height: height,
    );
  }
}
