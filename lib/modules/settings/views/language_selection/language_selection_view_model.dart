import 'package:flutter/material.dart';

import '../../../../core/localization/localization_supported_data.dart';

class LanguageSelectionViewModel extends ChangeNotifier {
  // ========================== Constructor ========================== //
  LanguageSelectionViewModel();

  // ========================== 🔒 Private variables 🔒 ========================== //
  LanguageOption? _selectedLanguage;

  // ========================== 🗝️ Public getters 🗝️ ========================== //
  LanguageOption? get selectedLanguage => _selectedLanguage;

  // ========================== 🌍 Public events 🌍 ========================== //

  // --------------------------[ init ]-------------------------- //
  void init() {
    _selectedLanguage = AppLocalizationController.currentLanguage;
    notifyListeners();
  }

  // --------------------------[ onLanguageSelected ]-------------------------- //
  void onLanguageSelected(LanguageOption lang) {
    if (_selectedLanguage == lang) return;
    _selectedLanguage = lang;
    AppLocalizationController.changeLanguage(lang);
    notifyListeners();
  }
}
