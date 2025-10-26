import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flustra_template/core/services/images/compress_image.dart';

abstract class LocalImageSource {}

// ========================== 🔥 FileLocalImageData 🔥 ==========================
class FileLocalImageData implements LocalImageSource {
  final File file;

  FileLocalImageData({required this.file});
}

// ========================== 🔥 WebLocalImageData 🔥 ==========================
class WebLocalImageData implements LocalImageSource {
  final Uint8List bytes;

  WebLocalImageData({required this.bytes});
}

// ========================== 🔥 LocalImageSourceX 🔥 ==========================
// extension LocalImageSourceX on LocalImageSource? {
//   /// Convert [LocalImageSource] to a [MultipartFile].
//   /// - Returns `null` if source is null.
//   /// - Compress file if it's [FileLocalImageData].
//   /// - Directly wraps bytes if it's [WebLocalImageData].
//   Future<MultipartFile?> toMultipartFile() async {
//     if (this == null) return null;
//
//     switch (this) {
//       case FileLocalImageData(:final file):
//         // Try to compress before upload
//         final compressed = await CompressImage.compressImage(file);
//         if (compressed == null) return null;
//         return MultipartFile.fromFile(compressed.path);
//
//       case WebLocalImageData(:final bytes):
//         // Send raw bytes with a default filename
//         return MultipartFile.fromBytes(bytes);
//
//       default:
//         return null;
//     }
//   }
// }
