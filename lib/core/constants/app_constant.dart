import 'dart:ui';

import '../localization/localization_supported_data.dart';
import '../theme/app_theme.dart';

class AppConstant {
  AppConstant._();

  static const String appName = "Flustra template";

  // -------------------------- Localization --------------------------
  static LanguageOption defaultLanguage = AppLocalizationController.supportedLanguagesMap.values.first;
  static final List<LanguageOption> supportedLanguagesModels = AppLocalizationController.supportedLanguagesMap.values.toList();
  static final List<Locale> supportedLanguagesLocales = AppLocalizationController.supportedLanguagesLocales;

  // -------------------------- Theme --------------------------
  static ThemeModeType defaultThemeMode = ThemeModeType.lightDeepBlue;
}
