import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';

import '../failure.dart';
import '../res/error_source.dart';

enum DataSourceDioError { connectTimeOut, sendTimeOut, receiveTimeOut, transformTimeout, defaultError, cancel }

Failure dioHandleError(DioException error) {
  debugPrint("from dio error ${error.response?.statusCode}");
  return switch (error.type) {
    DioExceptionType.connectionTimeout => Failure(ErrorCodes.connectTimeout, AppStrings.errorConnectionTimeout.tx(), TypeMsg.error),
    DioExceptionType.sendTimeout => Failure(ErrorCodes.sendTimeout, AppStrings.errorSendTimeout.tx(), TypeMsg.error),
    DioExceptionType.receiveTimeout => Failure(ErrorCodes.receiveTimeout, AppStrings.errorReceiveTimeout.tx(), TypeMsg.error),
    DioExceptionType.badCertificate => Failure(ErrorCodes.badCertificate, AppStrings.errorBadCertificate.tx(), TypeMsg.error),
    DioExceptionType.badResponse => Failure(error.response?.statusCode ?? ErrorCodes.badResponse, AppStrings.errorBadResponse.tx(), TypeMsg.error),
    DioExceptionType.cancel => Failure(ErrorCodes.cancel, AppStrings.errorRequestCancelled.tx(), TypeMsg.error),
    DioExceptionType.connectionError => Failure(ErrorCodes.connectionError, AppStrings.errorConnection.tx(), TypeMsg.error),
    DioExceptionType.transformTimeout => Failure(ErrorCodes.transformTimeout, AppStrings.errorTransformTimeout.tx(), TypeMsg.error),
    DioExceptionType.unknown => Failure(ErrorCodes.unknown, AppStrings.errorUnknown.tx(), TypeMsg.error),
  };
}
