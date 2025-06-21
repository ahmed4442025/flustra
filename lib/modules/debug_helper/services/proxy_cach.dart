import 'dart:convert';
import '../../../core/data/cache/cache_key.dart';

class ProxyManager {
  List<String> proxies = [];

  Future<void> addProxy(String proxy) async {
    proxies.add(proxy);
    proxies = proxies.toSet().toList();
    String jsonString = jsonEncode(proxies);
    await AppCache.saveData(key: CacheKey.proxyRunning, value: jsonString);
  }

  Future<void> removeProxy(String proxy) async {
    proxies.remove(proxy);
    proxies = proxies.toSet().toList();
    String jsonString = jsonEncode(proxies);
    await AppCache.saveData(key: CacheKey.proxyRunning, value: jsonString);
  }

  List<String> getStringArray() {
    String jsonString = AppCache.getData(key: CacheKey.proxyRunning) ?? '[]';
    proxies = (jsonDecode(jsonString) as List).map((e) => e.toString()).toList();
    proxies = proxies.toSet().toList();
    return proxies;
  }
}
