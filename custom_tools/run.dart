/// ============================================================================
/// DEVELOPER TOOLS CLI ROUTER
/// ============================================================================
/// This file serves as the single entry point for all custom automation tools.
/// AI Agents and Developers should ONLY trigger operations through this router.
///
/// Usage:
///   dart run custom_tools/run.dart <command> "<arguments>"
///
/// Supported Commands:
///
/// 1. add_trans
///    Adds CSV-formatted localizations to AppStrings and translation maps.
///    Format: key|en|ar;...
///    Example:
///      dart run custom_tools/run.dart add_trans "key|en|ar;loginBtn|Log In|تسجيل الدخول"
///
/// 2. create_screen
///    Creates feature module screen and viewmodel files matching project rules,
///    and optionally registers the new screen inside GoRouter.
///    Format: module_name|screen_name|add_to_router
///    Example:
///      dart run custom_tools/run.dart create_screen "auth|login_page|true"
///
/// 3. add_route
///    Manually registers an existing screen in lib/core/router/app_router.dart.
///    Format: module_name|screen_name
///    Example:
///      dart run custom_tools/run.dart add_route "auth|login_page"
/// ============================================================================

import 'dart:io';

import 'localization_tool/add_translation.dart';
import 'router_tool/register_route.dart';
import 'screen_generator/generate_screen.dart';

void main(List<String> args) {
  if (args.isEmpty || args[0] == '--help' || args[0] == '-h') {
    _printHelpMenu();
    exit(0);
  }

  final command = args[0];
  if (args.length < 2) {
    print('ERROR: Command "$command" requires an argument payload.');
    print('Run with --help for command formatting rules.');
    exit(1);
  }

  final payload = args[1].trim();

  try {
    switch (command) {
      case 'add_trans':
        print('Running: Add Translations...');
        addTranslation(payload);
        break;

      case 'create_screen':
        print('Running: Create Screen & ViewModel...');
        final parts = payload.split('|').map((s) => s.trim()).toList();
        if (parts.length < 2) {
          print('ERROR: Format must be "module_name|screen_name" or "module_name|screen_name|add_to_router"');
          exit(1);
        }
        final module = parts[0];
        final screenName = parts[1];
        final addToRouter = parts.length > 2 && parts[2].toLowerCase() == 'true';

        generateScreen(
          module: module,
          screenName: screenName,
          addToRouter: addToRouter,
        );
        break;

      case 'add_route':
        print('Running: Add Route to app_router.dart...');
        final parts = payload.split('|').map((s) => s.trim()).toList();
        if (parts.length < 2) {
          print('ERROR: Format must be "module_name|screen_name"');
          exit(1);
        }
        registerRoute(
          module: parts[0],
          screenName: parts[1],
        );
        break;

      default:
        print('ERROR: Unknown command "$command".');
        _printHelpMenu();
        exit(1);
    }
  } catch (e, stackTrace) {
    print('FATAL ERROR during command execution: $e');
    print(stackTrace);
    exit(1);
  }
}

void _printHelpMenu() {
  print('''
================================================================================
DEVELOPER TOOLS CLI ROUTER — HELP MENU
================================================================================
Trigger scripts via:
  dart run custom_tools/run.dart <command> "<arguments>"

Commands:
  add_trans       Add localizations in CSV format.
                  Format: "key|en|ar;newKey|English|العربية"
                  Example: dart run custom_tools/run.dart add_trans "key|en|ar;testBtn|Click me|اضغط هنا"

  create_screen   Generate screen and viewmodel files matching project rules.
                  Format: "module_name|screen_name|add_to_router"
                  Example: dart run custom_tools/run.dart create_screen "auth|login_page|true"

  add_route       Register an existing screen in app_router.dart using AST.
                  Format: "module_name|screen_name"
                  Example: dart run custom_tools/run.dart add_route "auth|login_page"
================================================================================
''');
}
