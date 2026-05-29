import 'dart:io';

/// Resolves the absolute project root directory.
String getProjectRoot() {
  var rootDir = Directory.current.path.replaceAll('\\', '/');
  if (rootDir.endsWith('/custom_tools')) {
    rootDir = Directory(rootDir).parent.path.replaceAll('\\', '/');
  }
  return rootDir;
}

/// Reads and parses the project name from the root pubspec.yaml.
String getProjectName(String rootDir) {
  final file = File('$rootDir/pubspec.yaml');
  if (!file.existsSync()) {
    return 'academy'; // Safe fallback
  }
  final lines = file.readAsLinesSync();
  for (final line in lines) {
    if (line.trim().startsWith('name:')) {
      return line.split(':').last.trim().replaceAll("'", '').replaceAll('"', '');
    }
  }
  return 'academy';
}

/// Converts a string (snake_case, camelCase, PascalCase, or spaces) to PascalCase.
String toPascalCase(String input) {
  if (input.isEmpty) return '';
  final words = _splitIntoWords(input);
  return words.map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase()).join('');
}

/// Converts a string to camelCase.
String toCamelCase(String input) {
  if (input.isEmpty) return '';
  final pascal = toPascalCase(input);
  return pascal[0].toLowerCase() + pascal.substring(1);
}

/// Converts a string to snake_case.
String toSnakeCase(String input) {
  if (input.isEmpty) return '';
  final words = _splitIntoWords(input);
  return words.map((w) => w.toLowerCase()).join('_');
}

/// Splits string by non-alphanumeric boundaries and capital letter transitions.
List<String> _splitIntoWords(String input) {
  // Replace underscores, hyphens, and dots with spaces
  final cleaned = input.replaceAll(RegExp(r'[\-_.]'), ' ');
  // Insert spaces before capital letters to handle camelCase/PascalCase
  final spaced = cleaned.replaceAllMapped(RegExp(r'(?<=[a-z0-9])([A-Z])'), (match) => ' ${match.group(1)}');
  return spaced.split(' ').map((w) => w.trim()).where((w) => w.isNotEmpty).toList();
}
