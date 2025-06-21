import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flustra_template/core/constants/app_api.dart';
import 'package:flustra_template/core/data/cache/cache_key.dart';
import 'package:flustra_template/core/data/cache/cache_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_service_repo.dart';


class DioApiService implements IApiService {
  final Dio _dio = Dio();
  final CacheServices _cacheService = AppCache;

  DioApiService() {
    _dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 6000),
      receiveTimeout: const Duration(seconds: 6000),
      responseType: ResponseType.json,
    );

    // -------------------------- proxy --------------------------
    String? proxy = AppCache.getString(key: CacheKey.proxyRunning);
    if (proxy != null) setProxy(proxy);

    // -------------------------- logger --------------------------
    bool showLoges = true;
    // customization
    if (showLoges) {
      _dio.interceptors.add(
        PrettyDioLogger(requestHeader: true, requestBody: true, responseBody: true, responseHeader: false, error: true, compact: true, maxWidth: 90),
      );
    }
  }

  @override
  Future<Response> getData({required String uri, Map<String, dynamic>? query, Map<String, dynamic>? headers}) async {
    return await _dio.get(uri, queryParameters: query, options: _buildOptions(customHeaders: headers));
  }

  @override
  Future<Response> postData({
    required String uri,
    dynamic data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    return await _dio.post(
      uri,
      data: data,
      queryParameters: query,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      options: _buildOptions(customHeaders: headers),
    );
  }

  @override
  Future<Response> putData({required String uri, dynamic data, Map<String, dynamic>? query, Map<String, dynamic>? headers}) async {
    return await _dio.put(uri, data: data, queryParameters: query, options: _buildOptions(customHeaders: headers));
  }

  @override
  Future<Response> deleteData({required String uri, dynamic data, Map<String, dynamic>? query, Map<String, dynamic>? headers}) async {
    return await _dio.delete(uri, data: data, queryParameters: query, options: _buildOptions(customHeaders: headers));
  }

  // ========================== 🔥 privet 🔥 ==========================
  Options _buildOptions({Map<String, dynamic>? customHeaders}) {
    final token = _cacheService.getString(key: CacheKey.proxyRunning); // افتراضًا من مكان تاني todo

    final headers = {
      if (token != null) 'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (customHeaders != null) ...customHeaders,
    };

    return Options(headers: headers);
  }

  // -------------------------- proxy --------------------------
  String? _proxyRun;

  @override
  String? get proxyRun => _proxyRun;

  @override
  String? setProxy(String? proxy) {
    try {
      _dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final client = HttpClient();
          client.findProxy = (uri) => proxy == null ? 'DIRECT' : 'PROXY $proxy';
          client.badCertificateCallback = (X509Certificate cert, String host, int port) => proxy != null;
          return client;
        },
      );
      _proxyRun = proxy;
      if (proxy != null) AppCache.saveData(key: CacheKey.proxyRunning, value: proxy);
      if (proxy == null) AppCache.remove(key: CacheKey.proxyRunning);
      return null;
    } catch (e, s) {
      _proxyRun = null;
      AppCache.remove(key: CacheKey.proxyRunning);
      print("$e$s");
      return e.toString();
    }
  }
}

