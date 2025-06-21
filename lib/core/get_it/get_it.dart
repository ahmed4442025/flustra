import 'package:get_it/get_it.dart';
import 'package:flustra_template/core/data/cache/cache_service.dart';
import 'package:flustra_template/core/data/cache/shared_prefs_cache_service.dart';
import 'package:flustra_template/core/data/network/IApiService.dart';
import 'package:flustra_template/core/data/network/dio_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future setupGetIt() async {
  // ========================== 🔥 public services 🔥 ==========================

  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerSingleton<CacheService>(SharedPrefsCacheService(prefs: prefs));
  getIt.registerSingleton<IApiService>(DioApiService());

  // ========================== 🔥 cubits 🔥 ==========================

  // getIt.registerLazySingleton<QuranCubit>(() => QuranCubit());
}

