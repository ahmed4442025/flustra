import 'package:dio/dio.dart';
import 'package:flustra_template/core/get_it/get_it.dart';


IApiService get DioHelper => getIt<IApiService>();

abstract class IApiService {
  Future<Response> getData({required String uri, Map<String, dynamic>? query, Map<String, dynamic>? headers});

  Future<Response> postData({
    required String uri,
    dynamic data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  });

  Future<Response> putData({required String uri, dynamic data, Map<String, dynamic>? query, Map<String, dynamic>? headers});

  Future<Response> deleteData({required String uri, dynamic data, Map<String, dynamic>? query, Map<String, dynamic>? headers});

  // -------------------------- Proxy --------------------------
  String? setProxy(String? proxy);

  String? get proxyRun;
}
