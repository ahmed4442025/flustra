import 'dart:ui';

import 'package:flustra_template/core/constants/app_images.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';

class LocalizationController {
  final List<LanguageOption> supportedLanguagesModels = [
    LanguageOption(
      id: 1,
      locale: Locale('en', 'US'),
      nameRaw: 'English',
      nameWithTr: () => AppStrings.english.tx(),
      flagAsset: AppAssetsImages.flags.flagOfUnitedKingdom,
    ),
    LanguageOption(
      id: 2,
      locale: Locale('ar', 'EG'),
      nameRaw: 'Arabic',
      nameWithTr: () => AppStrings.arabic.tx(),
      flagAsset: AppAssetsImages.flags.flagOfEgypt,
    ),
    LanguageOption(
      id: 3,
      locale: Locale('de', 'DE'),
      nameRaw: 'German',
      nameWithTr: () => AppStrings.german.tx(),
      flagAsset: AppAssetsImages.flags.flagOfGermany,
    ),
  ];

  late final List<Locale> supportedLanguagesLocales = supportedLanguagesModels.map((e) => e.locale).toList();

  Locale? _locale;

  Locale get locale => _locale ?? const Locale('en', 'US');
}

// ========================== 🔥 Model 🔥 ==========================
class LanguageOption {
  final int id;
  final Locale locale;
  final String nameRaw;
  final String Function() nameWithTr;
  final String flagAsset;

  const LanguageOption({
    required this.id,
    required this.locale,
    required this.nameRaw,
    required this.nameWithTr,
    required this.flagAsset,
  });
}
