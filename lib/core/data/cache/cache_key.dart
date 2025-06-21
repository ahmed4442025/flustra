import 'package:flustra_template/core/get_it/get_it.dart';

import 'cache_service.dart';

CacheServices get AppCache => getIt<CacheServices>();

enum CacheKey {
  publicSettings,
  skipOnBoarding,
  loginResponse,
  proxyRunning,
}

extension CacheKeyExtension on CacheKey {
  String get key {
    return switch (this) {
      CacheKey.proxyRunning => "proxyRunning",
      CacheKey.publicSettings => "publicSettings",
      CacheKey.skipOnBoarding => "skipOnBoarding",
      CacheKey.loginResponse => "loginResponse",
    };
  }
}
