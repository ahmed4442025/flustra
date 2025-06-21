import 'package:flustra_template/core/data/cache/cache_key.dart';
import 'package:flustra_template/core/get_it/get_it.dart';

import '../helper/base_cubit/bse_cubit.dart';
import '../theme/app_theme.dart';
import '../theme/theme_controller.dart';
import 'app_settings/app_settings_model.dart';

enum AppSettingsCubitTypes {
  none,
  theme,
}

class AppSettingsCubit extends BaseCubit<AppSettingsCubitTypes> {
  AppSettingsCubit() : super(AppSettingsCubitTypes.none);

  static AppSettingsCubit get i => getIt<AppSettingsCubit>();

// ========================== 🔥 init 🔥 ==========================
  @override
  void init() {
    _settings = loadSettings();
    changeTheme(_settings.themeMode);
  }

// ========================== 🔥 Theme 🔥 ==========================
  final ThemeController themeController = ThemeController();

  void changeTheme(ThemeModeType mode) {
    void onChanged() {
      _settings.themeMode = mode;
      saveSettings(_settings);
      fire(AppSettingsCubitTypes.theme);
    }

    themeController.changeTheme(mode: mode, onChanged: onChanged);
  }

// ========================== 🔥 handel settings 🔥 ==========================
  AppSettingsModel _settings = AppSettingsModel.defaults();

  void saveSettings(AppSettingsModel settings) => AppCache.saveData(key: CacheKey.loginResponse, value: settings.toJson());

  AppSettingsModel loadSettings() {
    Map<String, dynamic>? data = AppCache.getMap(key: CacheKey.loginResponse);
    return AppSettingsModel.fromJson(data ?? {});
  }
}
