import 'package:flustra_template/core/get_it/get_it.dart';

import 'cache_service.dart';

CacheService get cache => getIt<CacheService>();

enum CacheKey { proxyRunning }

extension CacheKeyExtension on CacheKey {
  String get key {
    return switch (this) {
      CacheKey.proxyRunning => "proxyRunning",
    };
  }
}
