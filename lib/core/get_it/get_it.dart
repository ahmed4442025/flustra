import 'package:flustra_template/core/data/cache/cache_service.dart';
import 'package:flustra_template/core/data/cache/shared_prefs_cache_service.dart';
import 'package:flustra_template/core/data/network/api_service_repo.dart';
import 'package:flustra_template/core/data/network/dio_api_service.dart';
import 'package:flustra_template/modules/products/logic/products_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_settings/app_settings_cubit.dart';
import '../services/app_session_manager.dart';

final getIt = GetIt.instance;

Future setupGetIt() async {
  await initPublicServices();
  initCubits();
}

// ========================== 🔥 Public services 🔥 ==========================
Future initPublicServices() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerSingleton<CacheServices>(SharedPrefsCacheService(prefs: prefs));
  AppSessionManager.init();
  getIt.registerSingleton<IApiService>(DioApiService());
}
// ========================== 🔥 repositories 🔥 ==========================

void initRepositories() {}
// ========================== 🔥 cubits 🔥 ==========================
void initCubits() {
  getIt.registerLazySingleton<AppSettingsCubit>(() => AppSettingsCubit());
  getIt.registerLazySingleton<ProductsCubit>(() => ProductsCubit());
}
