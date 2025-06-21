import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flustra_template/core/localization/app_localizations.dart';

import '../failure.dart';
import '../res/error_source.dart';

enum DataSourceDioError { connectTimeOut, sendTimeOut, receiveTimeOut, defaultError, cancel }

Failure dioHandleError(DioException error) {
  print("from dio error ${error.response?.statusCode}");
  return switch (error.type) {
    DioExceptionType.connectionTimeout => Failure(ErrorCodes.connectTimeout, LocaleKeys.errorConnectionTimeout.tr(), TypeMsg.error),
    DioExceptionType.sendTimeout => Failure(ErrorCodes.sendTimeout, LocaleKeys.errorSendTimeout.tr(), TypeMsg.error),
    DioExceptionType.receiveTimeout => Failure(ErrorCodes.receiveTimeout, LocaleKeys.errorReceiveTimeout.tr(), TypeMsg.error),
    DioExceptionType.badCertificate => Failure(ErrorCodes.badCertificate, LocaleKeys.errorBadCertificate.tr(), TypeMsg.error),
    DioExceptionType.badResponse => Failure(error.response?.statusCode ?? ErrorCodes.badResponse, LocaleKeys.errorBadResponse.tr(), TypeMsg.error),
    DioExceptionType.cancel => Failure(ErrorCodes.cancel, LocaleKeys.errorRequestCancelled.tr(), TypeMsg.error),
    DioExceptionType.connectionError => Failure(ErrorCodes.connectionError, LocaleKeys.errorConnection.tr(), TypeMsg.error),
    DioExceptionType.unknown => Failure(ErrorCodes.unknown, LocaleKeys.errorUnknown.tr(), TypeMsg.error),
  };
}
