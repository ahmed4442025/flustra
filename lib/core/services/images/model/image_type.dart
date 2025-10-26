import 'dart:io';
import 'dart:typed_data';

import 'local_image_upload.dart';

sealed class ImageSourceData {}

// ========================== 🔥 NetworkImageData 🔥 ==========================
class NetworkImageData extends ImageSourceData {
  final String url;

  NetworkImageData(this.url);
}

// ========================== 🔥 FileImageData 🔥 ==========================
class FileImageData extends ImageSourceData {
  final File file;

  FileImageData(this.file);
}

// ========================== 🔥 WebImageData 🔥 ==========================
class WebImageData extends ImageSourceData {
  final Uint8List bytes;

  WebImageData(this.bytes);
}

// ========================== 🔥 ImageSourceDataEX 🔥 ==========================
extension ImageSourceDataEX on ImageSourceData {
  LocalImageSource? getLocalImageSource() {
    return switch (this) {
      NetworkImageData() => null,
      FileImageData() => FileLocalImageData(file: (this as FileImageData).file),
      WebImageData() => WebLocalImageData(bytes: (this as WebImageData).bytes),
    };
  }
}
