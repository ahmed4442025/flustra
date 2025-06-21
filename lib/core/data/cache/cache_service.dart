import 'cache_key.dart';

abstract class CacheServices {
  Future<bool> saveData({required CacheKey key, required dynamic value});

  dynamic getData({required CacheKey key});

  int? getInt({required CacheKey key});

  String? getString({required CacheKey key});

  bool? getBool({required CacheKey key});

  double? getDouble({required CacheKey key});

  Map<String, dynamic>? getMap({required CacheKey key});

  Future<bool> remove({required CacheKey key});

  Future<bool> clear();
}
