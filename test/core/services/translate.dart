import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Localization Coverage Tests', () {
    const appStringsPath = 'lib/core/localization/app_strings_localizations.dart';
    final translationFiles = {
      'Arabic': {'path': 'lib/core/localization/tr/ar.dart', 'rootMap': 'arJson'},
      'English': {'path': 'lib/core/localization/tr/en.dart', 'rootMap': 'enJson'},
      'German': {'path': 'lib/core/localization/tr/de.dart', 'rootMap': 'deJson'},
    };

    late Set<String> appStringsFieldNames;

    setUpAll(() {
      final file = File(appStringsPath);
      if (!file.existsSync()) {
        fail('❌ Required file not found: $appStringsPath');
      }
      final content = file.readAsStringSync();
      final result = parseString(content: content);

      appStringsFieldNames = _extractAppStringsStaticFieldNames(result.unit);

      if (appStringsFieldNames.isEmpty) {
        fail('❌ No static fields found in AppStrings class in $appStringsPath');
      }

      print('ℹ️ Found ${appStringsFieldNames.length} keys defined in AppStrings.');
    });

    for (var entry in translationFiles.entries) {
      final langName = entry.key;
      final config = entry.value;
      final filePath = config['path']!;
      final rootMapName = config['rootMap']!;

      test('All AppStrings keys should be reachable from $rootMapName in $langName', () {
        final file = File(filePath);
        if (!file.existsSync()) {
          fail('❌ Translation file for $langName not found at $filePath');
        }

        final content = file.readAsStringSync();
        final result = parseString(content: content);

        final collector = _MapKeyCollector(result.unit);
        final collectedKeys = collector.collectKeysFrom(rootMapName);

        // Keys that are in AppStrings but NOT in the collected keys from the map
        final missingKeys = appStringsFieldNames.difference(collectedKeys.staticKeys).toList()..sort();

        // Keys that are in the map but NOT in AppStrings (including string literals)
        final extraStaticKeys = collectedKeys.staticKeys.difference(appStringsFieldNames).toList()..sort();
        final stringLiteralKeys = collectedKeys.stringKeys.toList()..sort();

        if (missingKeys.isNotEmpty) {
          print('\n❌ MISSING translations in $langName ($rootMapName):');
          for (var key in missingKeys) {
            print('   - AppStrings.$key');
          }
        }

        if (extraStaticKeys.isNotEmpty || stringLiteralKeys.isNotEmpty) {
          print('\n⚠️ EXTRA/INVALID keys found in $langName ($rootMapName):');
          for (var key in extraStaticKeys) {
            print('   - AppStrings.$key (Not defined in AppStrings class)');
          }
          for (var key in stringLiteralKeys) {
            print('   - "$key" (String literal used as key instead of AppStrings constant)');
          }
        }

        expect(missingKeys, isEmpty, reason: 'There are ${missingKeys.length} missing translation(s) in $langName. See output above.');

        expect(
          extraStaticKeys,
          isEmpty,
          reason: 'There are ${extraStaticKeys.length} extra AppStrings keys in $langName that are not defined in the class.',
        );

        expect(
          stringLiteralKeys,
          isEmpty,
          reason: 'There are ${stringLiteralKeys.length} string literal keys in $langName. Should use AppStrings constants.',
        );
      });
    }
  });
}

Set<String> _extractAppStringsStaticFieldNames(CompilationUnit unit) {
  final Set<String> names = {};
  for (var declaration in unit.declarations) {
    if (declaration is ClassDeclaration && declaration.name.lexeme == 'AppStrings') {
      for (var member in declaration.members) {
        if (member is FieldDeclaration && member.isStatic) {
          for (var variable in member.fields.variables) {
            names.add(variable.name.lexeme);
          }
        }
      }
    }
  }
  return names;
}

class CollectedKeys {
  final Set<String> staticKeys = {}; // Names like 'english' from AppStrings.english
  final Set<String> stringKeys = {}; // Actual string literals used as keys
}

class _MapKeyCollector {
  final CompilationUnit unit;
  final Set<String> _visitedMaps = {};

  _MapKeyCollector(this.unit);

  CollectedKeys collectKeysFrom(String mapVariableName) {
    final result = CollectedKeys();
    _collectRecursive(mapVariableName, result);
    return result;
  }

  void _collectRecursive(String variableName, CollectedKeys result) {
    if (_visitedMaps.contains(variableName)) return;
    _visitedMaps.add(variableName);

    final mapLiteral = _findMapLiteral(variableName);
    if (mapLiteral == null) return;

    for (var entry in mapLiteral.elements) {
      if (entry is MapLiteralEntry) {
        final key = entry.key;
        if (key is PrefixedIdentifier) {
          if (key.prefix.name == 'AppStrings') {
            result.staticKeys.add(key.identifier.name);
          }
        } else if (key is PropertyAccess) {
          if (key.target is Identifier && (key.target as Identifier).name == 'AppStrings') {
            result.staticKeys.add(key.propertyName.name);
          }
        } else if (key is StringLiteral) {
          result.stringKeys.add(key.stringValue ?? key.toString());
        } else if (key is Identifier) {
          // If AppStrings is imported without prefix and used directly (rare in this project but possible)
          // We could handle it if needed.
        }
      } else if (entry is SpreadElement) {
        final expression = entry.expression;
        if (expression is Identifier) {
          _collectRecursive(expression.name, result);
        }
      }
    }
  }

  SetOrMapLiteral? _findMapLiteral(String variableName) {
    for (var declaration in unit.declarations) {
      if (declaration is TopLevelVariableDeclaration) {
        for (var variable in declaration.variables.variables) {
          if (variable.name.lexeme == variableName) {
            final initializer = variable.initializer;
            if (initializer is SetOrMapLiteral) {
              return initializer;
            }
          }
        }
      }
    }
    return null;
  }
}
