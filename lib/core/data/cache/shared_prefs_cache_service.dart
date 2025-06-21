import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'cache_key.dart';
import 'cache_service.dart';

class SharedPrefsCacheService implements CacheServices {
  final SharedPreferences _prefs;

  SharedPrefsCacheService({required SharedPreferences prefs}) : _prefs = prefs;

  @override
  Future<bool> saveData({required CacheKey key, required dynamic value}) async {
    final k = key.key;
    if (value is int) return await _prefs.setInt(k, value);
    if (value is double) return await _prefs.setDouble(k, value);
    if (value is bool) return await _prefs.setBool(k, value);
    if (value is String) return await _prefs.setString(k, value);
    if (value is Map<String, dynamic>) return await _prefs.setString(k, json.encode(value));
    return false;
  }

  @override
  dynamic getData({required CacheKey key}) => _prefs.get(key.key);

  @override
  int? getInt({required CacheKey key}) => _prefs.getInt(key.key);

  @override
  String? getString({required CacheKey key}) => _prefs.getString(key.key);

  @override
  bool? getBool({required CacheKey key}) => _prefs.getBool(key.key);

  @override
  double? getDouble({required CacheKey key}) => _prefs.getDouble(key.key);

  @override
  Map<String, dynamic>? getMap({required CacheKey key}) {
    final jsonString = _prefs.getString(key.key);
    if (jsonString == null) return null;
    try {
      return json.decode(jsonString);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> remove({required CacheKey key}) async => await _prefs.remove(key.key);

  @override
  Future<bool> clear() async => await _prefs.clear();
}
