// import 'dart:typed_data';
// import 'package:flustra_template/core/helper/widgets/custom_validation_widget.dart';
// import 'package:flustra_template/core/services/images/model/image_type.dart';
// import 'package:flustra_template/core/services/images/model/local_image_upload.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'dart:io';
//
// import 'package:flutter/material.dart';
//
// // ========================== 🔥 ImagePickerController 🔥 ==========================
// class ImagePickerController extends ChangeNotifier {
//   ImageSourceData? _image;
//   final String? Function(ImageSourceData? image)? validator;
//
//   ImagePickerController({this.validator, ImageSourceData? initialImage}) : _image = initialImage;
//
//   ImageSourceData? get image => _image;
//   late final ValidationController validationController = ValidationController(validator: () => validator?.call(_image));
//
//   bool hasImage() => _image != null;
//
//   LocalImageSource? get localImageSource => image?.getLocalImageSource();
//
//   // -------------------------- Pick image --------------------------
//   Future<void> pickImage() async {
//     ImageSource? source = await showImagePickerSheet();
//     if (source == null) return;
//
//     final pickedFile = await ImagePicker().pickImage(source: source);
//
//     if (pickedFile != null) {
//       if (kIsWeb) {
//         // على الويب هترجع bytes
//         final bytes = await pickedFile.readAsBytes();
//         setImage(WebImageData(bytes));
//       } else {
//         // على الموبايل هترجع File
//         setImage(FileImageData(File(pickedFile.path)));
//       }
//     }
//   }
//
//   // -------------------------- Set image --------------------------
//   void setImage(ImageSourceData? image) {
//     _image = image;
//     validationController.validate();
//     notifyListeners();
//   }
//
//   // -------------------------- Clear image --------------------------
//   void clearImage() => setImage(null);
//
//   // -------------------------- Get image file if available --------------------------
//   File? get file {
//     if (image is FileImageData) return (image as FileImageData).file;
//     return null;
//   }
//
//   // -------------------------- Get image bytes if available (Web) --------------------------
//   Uint8List? get webBytes {
//     if (image is WebImageData) return (image as WebImageData).bytes;
//     return null;
//   }
//
//   // -------------------------- Get network url if available --------------------------
//   String? get networkUrl {
//     if (image is NetworkImageData) {
//       return (image as NetworkImageData).url;
//     }
//     return null;
//   }
//
//   @override
//   void dispose() {
//     validationController.dispose();
//     super.dispose();
//   }
// }
//
// // ========================== 🔥 showImagePickerSheet 🔥 ==========================
// Future<ImageSource?> showImagePickerSheet() async {
//   return await showModalBottomSheet(
//     context: AppContext!,
//     backgroundColor: AppColors.cardBackground,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
//     builder: (context) {
//       return SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: Icon(Icons.photo_library_outlined),
//               title: Text(AppStrings.gallery.tx()),
//               onTap: () => Navigator.pop(context, ImageSource.gallery),
//             ),
//             if (!kIsWeb) // الكاميرا مش مدعومة في Flutter Web
//               ListTile(
//                 leading: Icon(Icons.camera_alt_outlined),
//                 title: Text(AppStrings.takePhoto.tx()),
//                 onTap: () => Navigator.pop(context, ImageSource.camera),
//               ),
//           ],
//         ),
//       );
//     },
//   );
// }
