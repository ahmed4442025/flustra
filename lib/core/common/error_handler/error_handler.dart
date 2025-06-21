import 'package:dio/dio.dart';

import 'errors_data_source/dio_error.dart';
import 'failure.dart';

class ErrorHandlerCustom implements Exception {
  static Failure handle(dynamic error) {
    if (error is DioException) return dioHandleError(error);

    return Failure(-2, error.toString(), TypeMsg.error);
  }
}
