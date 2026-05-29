import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

// ============================================================
// CONFIGURATION — Edit here to add or modify languages/paths
// ============================================================

/// Path to the AppStrings base class file.
const String kAppStringsPath = 'lib/core/localization/app_strings_localizations.dart';

/// Maps each language code to its single translation file path.
/// To support a new language, add a new entry here.
const Map<String, String> kLanguagePaths = {
  'en': 'lib/core/localization/tr/en.dart',
  'ar': 'lib/core/localization/tr/ar.dart',
};

/// Maps each language code to the const Map variable name inside its file.
const Map<String, String> kLanguageMapName = {
  'en': 'enJson',
  'ar': 'arJson',
};

// ============================================================
// INPUT FORMAT (CSV-style)
//
// Row separator  : ;
// Column separator: |
// First row      : column headers (must include "key" + language codes)
//
// Example:
//   key|en|ar;loginBtn|Log In|تسجيل الدخول;logoutBtn|Log Out|تسجيل الخروج
//
// The "key" column maps to the AppStrings class.
// Each language column (e.g. "en", "ar") maps to its translation file
// as configured in kLanguagePaths above.
// ============================================================

// ============================================================
// AST VISITORS
// ============================================================

/// Reads all static const String fields from the AppStrings class.
class AppStringsVisitor extends RecursiveAstVisitor<void> {
  final Map<String, String> keysAndValues = {};
  ClassDeclaration? appStringsClass;

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final namePart = node.namePart;
    if (namePart is NameWithTypeParameters) {
      if (namePart.typeName.lexeme == 'AppStrings') {
        appStringsClass = node;
        super.visitClassDeclaration(node);
      }
    }
  }

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    if (node.isStatic && node.fields.isConst) {
      for (final variable in node.fields.variables) {
        final name = variable.name.lexeme;
        final initializer = variable.initializer;
        String? value;
        if (initializer is SimpleStringLiteral) {
          value = initializer.value;
        } else if (initializer is AdjacentStrings) {
          value = initializer.strings.map((s) {
            if (s is SimpleStringLiteral) return s.value;
            return '';
          }).join('');
        }
        if (value != null) keysAndValues[name] = value;
      }
    }
    super.visitFieldDeclaration(node);
  }
}

/// Reads all entries from a specific const Map inside a translation file.
class TranslationsVisitor extends RecursiveAstVisitor<void> {
  final Map<String, String> translations = {};
  final String mapName;
  SetOrMapLiteral? mapLiteral;

  TranslationsVisitor(this.mapName);

  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    final initializer = node.initializer;
    if (initializer is SetOrMapLiteral) {
      if (node.name.lexeme == mapName) mapLiteral = initializer;

      for (final element in initializer.elements) {
        if (element is MapLiteralEntry) {
          String? keyName;
          final k = element.key;
          if (k is PrefixedIdentifier && k.prefix.name == 'AppStrings') {
            keyName = k.identifier.name;
          } else if (k is SimpleIdentifier) {
            keyName = k.name;
          } else if (k is SimpleStringLiteral) {
            keyName = k.value;
          }

          final v = element.value;
          String? valString;
          if (v is SimpleStringLiteral) {
            valString = v.value;
          } else if (v is AdjacentStrings) {
            valString = v.strings.map((s) {
              if (s is SimpleStringLiteral) return s.value;
              return '';
            }).join('');
          }

          if (keyName != null && valString != null) {
            translations[keyName] = valString;
          }
        }
      }
    }
    super.visitVariableDeclaration(node);
  }
}

// ============================================================
// HELPERS
// ============================================================

/// Parses the CSV-style input string and returns a list of rows
/// as maps keyed by the header columns.
List<Map<String, String>> parseCsv(String input) {
  final rows = input.trim().split(';').map((r) => r.trim()).where((r) => r.isNotEmpty).toList();

  if (rows.length < 2) {
    print('ERROR: Input must have at least a header row and one data row.');
    exit(1);
  }

  final headers = rows.first.split('|').map((h) => h.trim()).toList();

  final result = <Map<String, String>>[];
  for (final row in rows.skip(1)) {
    final cells = row.split('|').map((c) => c.trim()).toList();
    if (cells.length != headers.length) {
      print('ERROR: Row "$row" has ${cells.length} columns but header has ${headers.length}.');
      exit(1);
    }
    result.add({for (var i = 0; i < headers.length; i++) headers[i]: cells[i]});
  }
  return result;
}

// ============================================================
// MAIN / LIB EXPORTS
// ============================================================

void main(List<String> args) {
  if (args.isEmpty) {
    print('ERROR: No arguments provided.');
    print('Usage: dart run localization_tool/add_translation.dart "key|en|ar;myKey|Hello|مرحبا"');
    exit(1);
  }
  addTranslation(args[0]);
  exit(0);
}

void addTranslation(String csvInput) {
  // ── 1. Parse CSV input ────────────────────────────────────
  final rows = parseCsv(csvInput);

  // Re-derive headers from the first row's keys (order preserved).
  final rawRows = csvInput.trim().split(';').where((r) => r.isNotEmpty).toList();
  final headers = rawRows.first.split('|').map((h) => h.trim()).toList();

  if (!headers.contains('key')) {
    print('ERROR: CSV header must contain a "key" column.');
    exit(1);
  }

  // Identify which headers are language codes.
  final langHeaders = headers.where((h) => h != 'key').toList();
  for (final lang in langHeaders) {
    if (!kLanguagePaths.containsKey(lang)) {
      print('ERROR: Unknown language column "$lang". '
          'Supported languages: ${kLanguagePaths.keys.join(', ')}.');
      exit(1);
    }
  }

  // ── 2. Resolve project root ───────────────────────────────
  var rootDir = Directory.current.path.replaceAll('\\', '/');
  if (rootDir.endsWith('/custom_tools')) {
    rootDir = Directory(rootDir).parent.path.replaceAll('\\', '/');
  }

  // ── 3. Locate and parse AppStrings file ───────────────────
  final appStringsFile = File('$rootDir/$kAppStringsPath');
  if (!appStringsFile.existsSync()) {
    print('ERROR: Could not locate AppStrings file at: ${appStringsFile.path}');
    exit(1);
  }

  final appStringsContent = appStringsFile.readAsStringSync();
  final appStringsVisitor = AppStringsVisitor();
  parseString(content: appStringsContent).unit.accept(appStringsVisitor);

  if (appStringsVisitor.appStringsClass == null) {
    print('ERROR: Could not find "class AppStrings" in ${appStringsFile.path}.');
    exit(1);
  }

  // ── 4. Locate and parse each language file ────────────────
  final langFile = <String, File>{};
  final langContent = <String, String>{};
  final langVisitor = <String, TranslationsVisitor>{};

  for (final lang in langHeaders) {
    final path = kLanguagePaths[lang]!;
    final mapName = kLanguageMapName[lang]!;

    final file = File('$rootDir/$path');
    if (!file.existsSync()) {
      print('ERROR: Could not locate "$lang" translation file at: ${file.path}');
      exit(1);
    }

    final content = file.readAsStringSync();
    final visitor = TranslationsVisitor(mapName);
    parseString(content: content).unit.accept(visitor);

    if (visitor.mapLiteral == null) {
      print('ERROR: Could not find map "$mapName" in ${file.path}.');
      exit(1);
    }

    langFile[lang] = file;
    langContent[lang] = content;
    langVisitor[lang] = visitor;
  }

  // ── 5. Process and validate all rows ──────────────────────
  final existingKeys = appStringsVisitor.keysAndValues;

  final toAdd = <Map<String, String>>[];
  final alreadyExisted = <String>[];
  final duplicatesToReuse = <Map<String, String>>[];

  for (final row in rows) {
    final key = row['key']!;
    final refLang = langHeaders.first;
    final incomingRefVal = row[refLang]!;

    // 1. Check if the key already exists
    if (existingKeys.containsKey(key)) {
      bool isIdentical = true;
      for (final lang in langHeaders) {
        final currentVal = langVisitor[lang]!.translations[key];
        final incomingVal = row[lang]!;
        if (currentVal != incomingVal) {
          isIdentical = false;
          break;
        }
      }

      if (isIdentical) {
        alreadyExisted.add(key);
      } else {
        final currentRefVal = langVisitor[refLang]!.translations[key];
        print("CONFLICT: The key '$key' already exists with a different value "
            "('$currentRefVal' vs '$incomingRefVal').");
        exit(1);
      }
      continue;
    }

    // 2. Check if the value exists under a DIFFERENT key (Reusability Check)
    String? existingKeyToReuse;
    String? existingValueToReuse;
    String? existingLangToReuse;

    for (final lang in langHeaders) {
      final incomingVal = row[lang]!;
      for (final entry in langVisitor[lang]!.translations.entries) {
        if (entry.value == incomingVal && entry.key != key) {
          existingKeyToReuse = entry.key;
          existingValueToReuse = entry.value;
          existingLangToReuse = lang;
          break;
        }
      }
      if (existingKeyToReuse != null) break;
    }

    if (existingKeyToReuse != null) {
      duplicatesToReuse.add({
        'incomingKey': key,
        'existingKey': existingKeyToReuse,
        'value': existingValueToReuse!,
        'lang': existingLangToReuse!,
      });
    } else {
      toAdd.add(row);
    }
  }

  final totalSuccessCount = toAdd.length + alreadyExisted.length;

  // ── 6. Inject new strings if any ──────────────────────────
  if (toAdd.isNotEmpty) {
    // Modify AppStrings file
    {
      final classBody = appStringsVisitor.appStringsClass!.body;
      final offset = (classBody is BlockClassBody) ? classBody.leftBracket.offset + 1 : classBody.beginToken.offset + 1;

      final snippet = StringBuffer('\n');
      for (final row in toAdd) {
        final key = row['key']!;
        final refLang = langHeaders.first;
        final refVal = row[refLang]!.replaceAll("'", "\\'");
        snippet.writeln("  static const String $key = '$refVal';");
      }

      final modified = appStringsContent.substring(0, offset) + snippet.toString() + appStringsContent.substring(offset);
      appStringsFile.writeAsStringSync(modified);
    }

    // Modify each language file
    for (final lang in langHeaders) {
      final mapLit = langVisitor[lang]!.mapLiteral!;
      final offset = mapLit.leftBracket.offset + 1;
      final content = langContent[lang]!;

      final snippet = StringBuffer('\n');
      for (final row in toAdd) {
        final key = row['key']!;
        final val = row[lang]!.replaceAll("'", "\\'");
        snippet.writeln("  AppStrings.$key: '$val',");
      }

      final modified = content.substring(0, offset) + snippet.toString() + content.substring(offset);

      try {
        langFile[lang]!.writeAsStringSync(modified);
      } catch (e) {
        print('ERROR: Failed to write "$lang" translation file: $e');
        exit(1);
      }
    }
  }

  // ── 7. Print final report ────────────────────────────────
  print('SUCCESS: Processed $totalSuccessCount keys successfully.');

  if (duplicatesToReuse.isNotEmpty) {
    print('\nREUSE SUGGESTIONS (The following values already exist under other keys):');
    for (final dup in duplicatesToReuse) {
      print('  - "${dup['value']}" already exists under AppStrings.${dup['existingKey']}. '
          'Please use "${dup['existingKey']}" instead of "${dup['incomingKey']}".');
    }
  }
}
