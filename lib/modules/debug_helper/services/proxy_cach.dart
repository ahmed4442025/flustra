import 'dart:convert';

import '../../../core/data/cache/cache_key.dart';

class ProxyManager {
  List<String> proxies = [];

  Future<void> addProxy(String proxy) async {
    proxies.add(proxy);
    proxies = proxies.toSet().toList();
    String jsonString = jsonEncode(proxies);
    await AppCache.saveData(key: CacheKey.proxyList, value: jsonString);
  }

  Future<void> removeProxy(String proxy) async {
    proxies.remove(proxy);
    proxies = proxies.toSet().toList();
    String jsonString = jsonEncode(proxies);
    await AppCache.saveData(key: CacheKey.proxyList, value: jsonString);
  }

  List<String> getStringArray() {
    String jsonString = AppCache.getData(key: CacheKey.proxyList) ?? '[]';
    proxies = (jsonDecode(jsonString) as List).map((e) => e.toString()).toList();
    proxies = proxies.toSet().toList();
    return proxies;
  }

  Future<void> setRunningProxy(String? proxy) async {
    if (proxy == null) {
      AppCache.remove(key: CacheKey.proxyRunning);
      return;
    }

    AppCache.saveData(key: CacheKey.proxyRunning, value: proxy);
  }

  String? getRunningProxy() => AppCache.getString(key: CacheKey.proxyRunning);
}
