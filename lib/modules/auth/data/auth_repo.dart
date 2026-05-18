import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flustra_template/core/constants/app_api.dart';

import '../../../core/common/default_app_response.dart';
import '../../../core/common/error_handler/failure.dart';
import '../../../core/helper/shared_methods.dart';
import 'requests/login_request.dart';
import 'responses/login_response.dart';

abstract class AuthRepo {
  // -------------------------- login --------------------------
  Future<Either<Failure, LoginResponse>> login({required LoginRequest loginRequest, CancelToken? cancelToken});
}

class AuthImp implements AuthRepo {
  // -------------------------- login --------------------------
  @override
  Future<Either<Failure, LoginResponse>> login({required LoginRequest loginRequest, CancelToken? cancelToken}) async {
    return await handleResponse(
      endPoint: ApiConstants.auth.login,
      asObject: (e) => LoginResponse.fromJson(e),
      method: DioMethod.post,
      cancelToken: cancelToken,
      data: loginRequest.toJson(),
    );
  }
}
