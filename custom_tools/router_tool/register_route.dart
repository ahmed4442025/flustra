import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../core/project_utils.dart';

/// Visitor to find AppRoutes class and _buildRoutes method inside app_router.dart.
class AppRouterVisitor extends RecursiveAstVisitor<void> {
  ClassDeclaration? appRoutesClass;
  FunctionDeclaration? buildRoutesMethod;

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final namePart = node.namePart;
    if (namePart is NameWithTypeParameters) {
      if (namePart.typeName.lexeme == 'AppRoutes') {
        appRoutesClass = node;
      }
    }
    super.visitClassDeclaration(node);
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    if (node.name.lexeme == '_buildRoutes') {
      buildRoutesMethod = node;
    }
    super.visitFunctionDeclaration(node);
  }
}

/// Visitor to find the returned list literal inside _buildRoutes.
class ReturnListVisitor extends RecursiveAstVisitor<void> {
  ListLiteral? listLiteral;

  @override
  void visitListLiteral(ListLiteral node) {
    listLiteral ??= node; // Grab the first one
    super.visitListLiteral(node);
  }
}

/// Automatically injects route definitions into lib/core/router/app_router.dart.
void registerRoute({
  required String module,
  required String screenName,
}) {
  final rootDir = getProjectRoot();
  final packageName = getProjectName(rootDir);

  final pascalName = toPascalCase(screenName);
  final camelName = toCamelCase(screenName);
  final snakeName = toSnakeCase(screenName);

  final appRouterFilePath = '$rootDir/lib/core/router/app_router.dart';
  final file = File(appRouterFilePath);
  if (!file.existsSync()) {
    print('ERROR: Could not locate app_router.dart at: ${file.path}');
    exit(1);
  }

  var content = file.readAsStringSync();

  // Check if already registered
  if (content.contains('AppRoutes.$camelName')) {
    print('SKIPPED: Route "AppRoutes.$camelName" is already registered in app_router.dart.');
    exit(0);
  }

  final parseResult = parseString(content: content);
  final unit = parseResult.unit;

  final routerVisitor = AppRouterVisitor();
  unit.accept(routerVisitor);

  if (routerVisitor.appRoutesClass == null) {
    print('ERROR: Could not find class "AppRoutes" in ${file.path}');
    exit(1);
  }
  if (routerVisitor.buildRoutesMethod == null) {
    print('ERROR: Could not find method "_buildRoutes" in ${file.path}');
    exit(1);
  }

  // 1. Inject Import Directive at the top of the file
  int importOffset = 0;
  for (final directive in unit.directives) {
    if (directive is ImportDirective) {
      importOffset = directive.end;
    }
  }
  final importSnippet = "\nimport 'package:$packageName/modules/$module/views/$snakeName/$snakeName.dart';";
  content = content.substring(0, importOffset) + importSnippet + content.substring(importOffset);

  // Re-parse content to get updated offsets after first injection
  var updatedResult = parseString(content: content);
  final updatedRouterVisitor = AppRouterVisitor();
  updatedResult.unit.accept(updatedRouterVisitor);

  final appRoutesClass = updatedRouterVisitor.appRoutesClass!;
  final buildRoutesMethod = updatedRouterVisitor.buildRoutesMethod!;

  // 2. Inject static const route into AppRoutes class at the beginning
  final classBody = appRoutesClass.body;
  final classInsertOffset = (classBody is BlockClassBody) ? classBody.leftBracket.offset + 1 : classBody.beginToken.offset + 1;
  final classSnippet = "\n  static const String $camelName = '/$camelName';";
  content = content.substring(0, classInsertOffset) + classSnippet + content.substring(classInsertOffset);

  // Re-parse content to get updated offsets again
  updatedResult = parseString(content: content);
  final finalRouterVisitor = AppRouterVisitor();
  updatedResult.unit.accept(finalRouterVisitor);

  // 3. Inject GoRoute builder inside _buildRoutes list literal at the beginning
  final returnListVisitor = ReturnListVisitor();
  finalRouterVisitor.buildRoutesMethod!.accept(returnListVisitor);

  final listLiteral = returnListVisitor.listLiteral;
  if (listLiteral == null) {
    print('ERROR: Could not find return list inside _buildRoutes in ${file.path}');
    exit(1);
  }

  final listInsertOffset = listLiteral.leftBracket.offset + 1;
  final listSnippet = "\n    _baseGoRoute(AppRoutes.$camelName, (_) => $pascalName()),";
  content = content.substring(0, listInsertOffset) + listSnippet + content.substring(listInsertOffset);

  // Write changes
  file.writeAsStringSync(content);
  print('SUCCESS: Route "AppRoutes.$camelName" and import successfully registered in lib/core/router/app_router.dart!');
}
