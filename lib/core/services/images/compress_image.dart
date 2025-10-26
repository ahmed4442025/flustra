// import 'dart:io';
//
// import 'package:flustra_template/core/services/console_printer.dart';
// import 'package:flutter/foundation.dart';
// import 'package:path/path.dart' as p;
//
// class CompressImage {
//   CompressImage._();
//
//   static Future<File?> compressImage(File? file) async {
//     if (kIsWeb) return null;
//
//     if (!(Platform.isAndroid || Platform.isIOS)) return null;
//
//     if (file == null) return null;
//     String? newName = _reNameFile(file.absolute.path, "jpg");
//     if (newName == null) return null;
//
//     XFile? result = await FlutterImageCompress.compressAndGetFile(
//       file.absolute.path,
//       newName,
//       quality: 25, // Set the image quality (0 to 100)
//       minHeight: 1024, // Set the minimum height of the compressed image
//       minWidth: 1024, // Set the minimum width of the compressed image
//       format: CompressFormat.jpeg,
//     );
//     File newFile = result == null ? file : File(result.path);
//     printColored(
//       "file size : ${_formatFileSize(file.lengthSync())} , newFile size : ${_formatFileSize(newFile.lengthSync())}, lose : ${(100 - (newFile.lengthSync() / file.lengthSync() * 100)).toStringAsFixed(1)}%",
//       textColor: ConsoleColor.green,
//     );
//     if (newFile.lengthSync() > file.lengthSync()) newFile = file;
//     printColored(
//       "returned size : ${_formatFileSize(newFile.lengthSync())}",
//       textColor: ConsoleColor.blue,
//       backgroundColor: ConsoleColor.black,
//       styles: [ConsoleTextStyle.bold, ConsoleTextStyle.italic],
//     );
//     return newFile;
//   }
//
//   static String _formatFileSize(int bytes, {int decimals = 2}) {
//     if (bytes <= 0) return '0 B';
//
//     const units = ['B', 'KB', 'MB', 'GB', 'TB'];
//     int unitIndex = 0;
//     double size = bytes.toDouble();
//
//     while (size >= 1024 && unitIndex < units.length - 1) {
//       size /= 1024;
//       unitIndex++;
//     }
//
//     return '${size.toStringAsFixed(decimals)} ${units[unitIndex]}';
//   }
//
//   static String? _reNameFile(String filePath, String format) {
//     try {
//       if (filePath.isEmpty || format.isEmpty) return null;
//       final dir = p.dirname(filePath);
//       final baseName = p.basenameWithoutExtension(filePath);
//       return p.join(dir, '${baseName}_compressed.$format');
//     } catch (e) {
//       return null;
//     }
//   }
// }
