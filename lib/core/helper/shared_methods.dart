// this method for only this project
import 'dart:io';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flustra_template/core/common/error_handler/error_handler.dart';
import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/data/network/IApiService.dart';
import 'package:flustra_template/core/localization/app_localizations.dart';
import 'package:flustra_template/main.dart' show navigatorKey;

// ==================== other ====================
bool isAr() => navigatorKey.currentContext!.locale.toString() == "ar";

bool get isDesktop => !kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS);

void calcTime({required Function() call, int callbackTimes = 1, int repeatCount = 1}) {
  for (int i = 0; i < repeatCount; i++) {
    DateTime d1 = DateTime.now();
    for (int j = 0; j < callbackTimes; j++) {
      call();
    }
    print(DateTime.now().difference(d1));
  }
}

void unFocusKeyboard() => FocusScope.of(navigatorKey.currentContext!).requestFocus(FocusNode());

//
// Future<dynamic> showDialogLoginFirst(String msg, {Function()? onTapLogin}) async {
//   return await showDialog(
//       context: navigatorKey.currentContext!,
//       builder: (contexts) => Dialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
//           alignment: Alignment.bottomCenter,
//           insetPadding: EdgeInsets.symmetric(vertical: Dimensions.paddingSize, horizontal: Dimensions.paddingSize),
//           child: ShowDialogLogin(
//               title: msg,
//               onTapLogin: () {
//                 Navigator.pop(navigatorKey.currentContext!);
//                 if (onTapLogin != null) onTapLogin();
//               })));
// }

// ==================== random ====================
Color get randomColor => Colors.primaries[Random().nextInt(Colors.primaries.length)];

String randomText([int wordsCount = 20]) {
  return List.generate(wordsCount, (i) => List.generate(8, (i) => 'abcdefghijklmnopqrstuvwxyz'[Random().nextInt(26)]).join("")).join(" ");
}
// ==================== dio ====================

Failure? _handleServerError(Map<String, dynamic> responseJson) {
  // if (responseJson.containsKey("success") && responseJson.containsKey("message")) {
  //   if (!responseJson["success"]) return Failure(-1, responseJson['message'], TypeMsg.error);
  // }
  return null;
}

enum DioMethod { post, get, delete, put }

Future<Either<Failure, T>> handleResponse<T>({
  required String endPoint,
  dynamic data,
  DioMethod method = DioMethod.get,
  required T Function(Map<String, dynamic> map) asObject,
  Map<String, dynamic>? query,
  Map<String, dynamic>? headers,
  int? page,
  void Function(int count, int total)? onSendProgress,
  CancelToken? cancelToken,
}) async {
  try {
    query ??= {};
    if (page != null) query["page"] = page;
    Response? res;
    Map<String, dynamic> json = {};
    if (method == DioMethod.get) res = (await DioHelper.getData(uri: endPoint, query: query, headers: headers ?? {}));
    if (method == DioMethod.post) {
      res = (await DioHelper.postData(
        uri: endPoint,
        data: data,
        query: query,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        headers: headers ?? {},
      ));
    }
    if (method == DioMethod.delete) res = (await DioHelper.deleteData(uri: endPoint, data: data, query: query));
    if (method == DioMethod.put) res = (await DioHelper.putData(uri: endPoint, data: data, query: query));

    if (res?.data is Map) json = res?.data ?? {};
    if (res?.data is! Map) return left(Failure(-63773, LocaleKeys.weDidNotReceiveTheExpectedData.tr(), TypeMsg.error));

    if (_handleServerError(json) != null) return left(_handleServerError(json)!); // check id success is true
    return right(asObject(json));
  } catch (e, s) {
    if (kDebugMode) print("ERROR IN handleResponse : $e \n\n$s");
    return left(ErrorHandlerCustom.handle(e));
  }
}
