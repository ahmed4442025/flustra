import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:flustra_template/main.dart';

// ========================== 🔥 help navigation methods 🔥 ==========================

bool _printNavigation = true;

Future navigateAndReplace(String routeName, {arguments, BuildContext? context}) async {
  return await _navigateTo(routeName, arguments: arguments, type: NavigationType.replace, context: context);
}

void navigateAndFinish(String routeName, {arguments, BuildContext? context}) async {
  await _navigateTo(routeName, arguments: arguments, type: NavigationType.finish, context: context);
}

Future<dynamic> navigateTo(String routeName, {arguments, BuildContext? context}) async {
  return await _navigateTo(routeName, arguments: arguments, type: NavigationType.normal, context: context);
}

// ========================== 🔥 privet 🔥 ==========================

Future<dynamic> _navigateTo(String routeName, {arguments, BuildContext? context, NavigationType type = NavigationType.normal}) async {
  context ??= navigatorKey.currentContext;
  print("color _navigateTo type($type), routeName($routeName), arguments($arguments)");
  if (context == null) return print("error context = null");
  switch (type) {
    case NavigationType.normal:
      return await context.push(routeName);
    case NavigationType.replace:
      context.pushReplacement(routeName);
      break;
    case NavigationType.finish:
      context.pushReplacement(routeName);
      break;
  }
}
// ========================== 🔥 pop 🔥 ==========================

popIfUCan({BuildContext? context, dynamic result}) {
  if (kDebugMode && _printNavigation) print("navigate popIfUCan");

  context ??= navigatorKey.currentContext;

  if (context == null) return print("error context = null");

  // if (Navigator.of(context).canPop()) Navigator.of(context).pop(result);
  if (context.canPop()) context.pop(result);
}

enum NavigationType { normal, finish, replace }
