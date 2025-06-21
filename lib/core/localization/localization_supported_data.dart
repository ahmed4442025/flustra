import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flustra_template/core/constants/app_images.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';

import '../../main.dart';
import 'tr/ar.dart';
import 'tr/en.dart';

class AppLocalizationController {
  AppLocalizationController._();

  static final Map<String, LanguageOption> supportedLanguagesMap = {
    'en': LanguageOption(
      json: enJson,
      locale: const Locale('en'),
      nameRaw: 'English',
      nameWithTr: () => AppStrings.english.tx(),
      flagAsset: AppAssetsImages.flags.flagOfUnitedKingdom,
    ),
    'ar': LanguageOption(
      json: arJson,
      locale: const Locale('ar'),
      nameRaw: 'العربية',
      nameWithTr: () => AppStrings.arabic.tx(),
      flagAsset: AppAssetsImages.flags.flagOfEgypt,
    ),
    'de': LanguageOption(
      json: enJson,
      // todo : add DE json languages
      locale: const Locale('de'),
      nameRaw: 'Deutsch',
      nameWithTr: () => AppStrings.german.tx(),
      flagAsset: AppAssetsImages.flags.flagOfGermany,
    ),
  };

  static LanguageOption? get currentLanguage => supportedLanguagesMap[AppContext!.locale.languageCode];

  static final List<Locale> supportedLanguagesLocales = supportedLanguagesMap.values.map((e) => e.locale).toList();

  static void changeLanguage(LanguageOption languageOption) => AppContext?.setLocale(languageOption.locale);
}

// ========================== 🔥 Model 🔥 ==========================
class LanguageOption {
  final Locale locale;
  final String nameRaw;
  final String Function() nameWithTr;
  final String flagAsset;
  final Map<String, String> json;

  const LanguageOption({
    required this.json,
    required this.locale,
    required this.nameRaw,
    required this.nameWithTr,
    required this.flagAsset,
  });

  @override
  bool operator ==(Object other) => identical(this, other) || other is LanguageOption && runtimeType == other.runtimeType && locale == other.locale;

  @override
  int get hashCode => locale.hashCode;
}
