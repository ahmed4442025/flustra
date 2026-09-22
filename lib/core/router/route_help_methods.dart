import 'package:flustra_template/main.dart';
import 'package:flustra_template/core/services/console_printer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

// ========================== 🔥 help navigation methods 🔥 ==========================

bool _printNavigation = true;
//
// Future navigateAndReplace(String routeName, {arguments, BuildContext? context}) async {
//   return await _navigateTo(routeName, arguments: arguments, type: NavigationType.replace, context: context);
// }
//
// void navigateAndFinish(String routeName, {arguments, BuildContext? context}) async {
//   await _navigateTo(routeName, arguments: arguments, type: NavigationType.finish, context: context);
// }
//
// Future<dynamic> navigateTo(String routeName, {arguments, BuildContext? context}) async {
//   return await _navigateTo(routeName, arguments: arguments, type: NavigationType.normal, context: context);
// }

// ========================== 🔥 privet 🔥 ==========================

Future<dynamic> navigateTo(String routeName, {arguments, BuildContext? context, NavigationType type = NavigationType.normal}) async {
  context ??= AppContext;
  "color _navigateTo type($type), routeName($routeName), arguments($arguments)".printWithColor(textColor: ConsoleColor.cyan);
  if (context == null) return "error context = null".printWithColor(textColor: ConsoleColor.red);
  switch (type) {
    case NavigationType.normal:
      return await context.push(routeName, extra: arguments);
    case NavigationType.replace:
      context.pushReplacement(routeName, extra: arguments);
      break;
    case NavigationType.finish:
      context.goNamed(routeName, extra: arguments);
      break;
  }
}
// ========================== 🔥 pop 🔥 ==========================

popIfUCan({BuildContext? context, dynamic result}) {
  if (kDebugMode && _printNavigation) "navigate popIfUCan".printWithColor(textColor: ConsoleColor.cyan);

  context ??= AppContext;

  if (context == null) return "error context = null".printWithColor(textColor: ConsoleColor.red);

  // if (Navigator.of(context).canPop()) Navigator.of(context).pop(result);
  if (context.canPop()) context.pop(result);
}

enum NavigationType { normal, finish, replace }
