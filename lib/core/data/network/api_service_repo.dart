import 'package:dio/dio.dart';
import 'package:flustra_template/core/get_it/get_it.dart';

import 'dio_api_service.dart';

IApiService get DioHelper => getIt<DioApiService>();

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
}
