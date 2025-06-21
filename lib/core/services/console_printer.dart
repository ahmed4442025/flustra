import 'package:flutter/cupertino.dart';

enum ConsoleColor {
  black,
  red,
  green,
  yellow,
  blue,
  magenta,
  cyan,
  white,
  brightBlack,
  brightRed,
  brightGreen,
  brightYellow,
  brightBlue,
  brightMagenta,
  brightCyan,
  brightWhite,
  defaultColor,
}

enum ConsoleTextStyle {
  bold,
  italic,
  underline,
}

const Map<ConsoleColor, String> _foregroundColorMap = {
  ConsoleColor.black: '\x1B[30m',
  ConsoleColor.red: '\x1B[31m',
  ConsoleColor.green: '\x1B[32m',
  ConsoleColor.yellow: '\x1B[33m',
  ConsoleColor.blue: '\x1B[34m',
  ConsoleColor.magenta: '\x1B[35m',
  ConsoleColor.cyan: '\x1B[36m',
  ConsoleColor.white: '\x1B[37m',
  ConsoleColor.brightBlack: '\x1B[90m',
  ConsoleColor.brightRed: '\x1B[91m',
  ConsoleColor.brightGreen: '\x1B[92m',
  ConsoleColor.brightYellow: '\x1B[93m',
  ConsoleColor.brightBlue: '\x1B[94m',
  ConsoleColor.brightMagenta: '\x1B[95m',
  ConsoleColor.brightCyan: '\x1B[96m',
  ConsoleColor.brightWhite: '\x1B[97m',
  ConsoleColor.defaultColor: '',
};

const Map<ConsoleColor, String> _backgroundColorMap = {
  ConsoleColor.black: '\x1B[40m',
  ConsoleColor.red: '\x1B[41m',
  ConsoleColor.green: '\x1B[42m',
  ConsoleColor.yellow: '\x1B[43m',
  ConsoleColor.blue: '\x1B[44m',
  ConsoleColor.magenta: '\x1B[45m',
  ConsoleColor.cyan: '\x1B[46m',
  ConsoleColor.white: '\x1B[47m',
  ConsoleColor.brightBlack: '\x1B[100m',
  ConsoleColor.brightRed: '\x1B[101m',
  ConsoleColor.brightGreen: '\x1B[102m',
  ConsoleColor.brightYellow: '\x1B[103m',
  ConsoleColor.brightBlue: '\x1B[104m',
  ConsoleColor.brightMagenta: '\x1B[105m',
  ConsoleColor.brightCyan: '\x1B[106m',
  ConsoleColor.brightWhite: '\x1B[107m',
  ConsoleColor.defaultColor: '',
};

const Map<ConsoleTextStyle, String> _textStyleMap = {
  ConsoleTextStyle.bold: '\x1B[1m',
  ConsoleTextStyle.italic: '\x1B[3m',
  ConsoleTextStyle.underline: '\x1B[4m',
};

void printColored(
    Object? message, {
      ConsoleColor textColor = ConsoleColor.defaultColor,
      ConsoleColor backgroundColor = ConsoleColor.defaultColor,
      List<ConsoleTextStyle> styles = const [],
    }) {
  final textColorCode = _foregroundColorMap[textColor] ?? '';
  final bgColorCode = _backgroundColorMap[backgroundColor] ?? '';
  final styleCodes = styles.map((s) => _textStyleMap[s] ?? '').join();
  const reset = '\x1B[0m';

  debugPrint('$textColorCode$bgColorCode$styleCodes$message$reset');
}

extension ColoredPrintExtension on Object? {
  void printWithColor({
    ConsoleColor textColor = ConsoleColor.defaultColor,
    ConsoleColor backgroundColor = ConsoleColor.defaultColor,
    List<ConsoleTextStyle> styles = const [],
  }) {
    printColored(
      this,
      textColor: textColor,
      backgroundColor: backgroundColor,
      styles: styles,
    );
  }
}
