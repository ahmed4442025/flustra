import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

import 'tr/ar.dart';
import 'tr/en.dart';

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    return Future.value(mapLocales[locale.toString()]);
  }

  static Map<String, Map<String, dynamic>> get mapLocales {
    return {
      "en": enJson,
      "ar": arJson,
      "de": enJson, // todo : add other languages
    };
  }
}
