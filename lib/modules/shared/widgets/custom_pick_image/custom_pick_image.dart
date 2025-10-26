// import 'package:flustra_template/core/constants/app_defults.dart';
// import 'package:flustra_template/core/extensions/color.dart';
// import 'package:flustra_template/core/helper/widgets/custom_image_network.dart';
// import 'package:flustra_template/core/helper/widgets/custom_validation_widget.dart';
// import 'package:flustra_template/core/localization/app_strings_localizations.dart';
// import 'package:flustra_template/core/theme/base_theme_data.dart';
// import 'package:flutter/material.dart';
//
// import 'custom_pick_image_controller.dart';
//
// class ImagePreviewWidget extends StatelessWidget {
//   final ImagePickerController controller;
//
//   const ImagePreviewWidget({super.key, required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return ValidationWidget(
//       controller: controller.validationController,
//       autoValidateMode: AutovalidateMode.onUserInteraction,
//       child: AnimatedBuilder(
//         animation: controller,
//         builder: (context, _) {
//           final hasImage = controller.hasImage();
//
//           final imageWidget = () {
//             switch (controller.image) {
//               // ============ Network ============
//               case NetworkImageData(:final url):
//                 return CachedImageWidget(
//                   imageUrl: url,
//                   width: 75,
//                   height: 75,
//                   fit: BoxFit.cover,
//                   isCircle: false,
//                   enableBorder: true,
//                   errorWidget: fallback(),
//                 );
//
//               // ============ Mobile File ============
//               case FileImageData(:final file):
//                 return ClipRRect(
//                   borderRadius: borderTextFieldRadius,
//                   child: Image.file(file, width: 75, height: 75, fit: BoxFit.cover),
//                 );
//
//               // ============ Web Bytes ============
//               case WebImageData(:final bytes):
//                 return ClipRRect(
//                   borderRadius: borderTextFieldRadius,
//                   child: Image.memory(bytes, width: 75, height: 75, fit: BoxFit.cover),
//                 );
//
//               // ============ Fallback ============
//               case null:
//                 return fallback();
//             }
//           }();
//
//           return GestureDetector(
//             onTap: controller.pickImage,
//             child: Container(
//               color: Colors.transparent,
//               child: Row(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Stack(
//                     children: [
//                       imageWidget,
//                       if (hasImage)
//                         Positioned(
//                           top: 0,
//                           right: 0,
//                           child: GestureDetector(
//                             onTap: controller.clearImage,
//                             child: Container(
//                               margin: const EdgeInsets.all(2),
//                               decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
//                               child: const Icon(Icons.close, size: 16, color: Colors.white),
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                   const SizedBox(width: 8),
//                   // Text(AppStrings.addAnImageToView.tx(), style: AppTextStyle.bodyLarge),
//                   Text("addAnImageToView", style: AppTextStyle.bodyLarge),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget fallback() {
//     return Container(
//       width: 75,
//       height: 75,
//       decoration: BoxDecoration(color: AppColors.divider.withOpacityEX(.3), borderRadius: borderTextFieldRadius),
//       child: Icon(Icons.add_a_photo, size: 40, color: AppColors.primary),
//     );
//   }
// }
