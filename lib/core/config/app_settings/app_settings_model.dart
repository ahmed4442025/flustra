import '../../constants/app_constant.dart';
import '../../theme/app_theme.dart';

class AppSettingsModel {
  ThemeModeType themeMode;

  AppSettingsModel({required this.themeMode});

  // ========================== 🔥 From json 🔥 ==========================

  factory AppSettingsModel.defaults() {
    return AppSettingsModel(themeMode: AppConstant.defaultThemeMode);
  }

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) {
    return AppSettingsModel(themeMode: getThemeModeFromKey(json['themeModeName']) ?? AppConstant.defaultThemeMode);
  }

  // ========================== 🔥 To json 🔥 ==========================
  Map<String, dynamic> toJson() {
    return {'themeModeName': themeMode.getThemeKey()};
  }
}
