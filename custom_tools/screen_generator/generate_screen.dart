import 'dart:io';

import '../core/project_utils.dart';
import '../router_tool/register_route.dart';

/// Generates screen and viewmodel template files.
/// Optionally registers the new screen in GoRouter if [addToRouter] is true.
void generateScreen({
  required String module,
  required String screenName,
  required bool addToRouter,
}) {
  final rootDir = getProjectRoot();
  final packageName = getProjectName(rootDir);

  final pascalName = toPascalCase(screenName);
  final camelName = toCamelCase(screenName);
  final snakeName = toSnakeCase(screenName);

  // Target directory: lib/modules/{module}/views/{snakeName}/
  final targetDirPath = '$rootDir/lib/modules/$module/views/$snakeName';
  final targetDir = Directory(targetDirPath);
  if (!targetDir.existsSync()) {
    targetDir.createSync(recursive: true);
  }

  // File paths
  final viewFilePath = '$targetDirPath/$snakeName.dart';
  final viewModelFilePath = '$targetDirPath/${snakeName}_view_model.dart';

  // 1. Generate ViewModel Template
  final viewModelContent = '''
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ${pascalName}ViewModel extends ChangeNotifier {
  // ========================== Constructor ========================== //
  ${pascalName}ViewModel();

  // ========================== 🔒 Private variables 🔒 ========================== //
  final CancelToken _cancel = CancelToken();
  final String stateKey = UniqueKey().toString();

  // ========================== 🗝️ Public getters 🗝️ ========================== //

  // ========================== 🌍 Public events 🌍 ========================== //
  void init() {}

  @override
  void dispose() {
    _cancel.cancel();
    super.dispose();
  }
}
'''
      .trim();

  // 2. Generate View Template
  final viewContent = '''
import 'package:flutter/material.dart';
import 'package:$packageName/core/constants/app_defults.dart';
import 'package:$packageName/core/router/route_help_methods.dart';
import 'package:$packageName/core/router/app_router.dart';
import '${snakeName}_view_model.dart';

class $pascalName extends StatefulWidget {
  const $pascalName({super.key});

  static const String name = AppRoutes.$camelName;
  static void navigateToMe() => navigateTo(name);

  @override
  State<$pascalName> createState() => _${pascalName}State();
}

class _${pascalName}State extends State<$pascalName> {
  late final ${pascalName}ViewModel _viewModel = ${pascalName}ViewModel();

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(_refresh);
    _viewModel.init();
  }

  @override
  void dispose() {
    _viewModel.removeListener(_refresh);
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  // --------------------------[ Body ]-------------------------- //
  Widget _buildBody() {
    return Column(
      children: [
        _buildHeader(),
        const SizedBox(height: 16),
        _buildContent(),
      ],
    );
  }

  // --------------------------[ Header ]-------------------------- //
  Widget _buildHeader() {
    return const Text('Header');
  }

  // --------------------------[ Content ]-------------------------- //
  Widget _buildContent() {
    return const Text('Content');
  }
}
'''
      .trim();

  // Write files
  File(viewFilePath).writeAsStringSync(viewContent);
  File(viewModelFilePath).writeAsStringSync(viewModelContent);

  print('GENERATED: Screen folder created successfully at lib/modules/$module/views/$snakeName/');
  print('  - Created screen widget: lib/modules/$module/views/$snakeName/$snakeName.dart');
  print('  - Created viewmodel: lib/modules/$module/views/$snakeName/${snakeName}_view_model.dart');

  // 3. Register route if requested
  if (addToRouter) {
    registerRoute(module: module, screenName: screenName);
  }
}
