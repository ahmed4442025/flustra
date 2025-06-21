import 'package:flutter/material.dart';

AppColorsBase colorsManagerNormal = _ColorsManagerDeepBlue();
AppColorsBase colorsManagerDark = _ColorsManagerDeepBlueDark();

AppColorsBase colorsManagerPurple = _ColorsManagerPurple();

AppColorsBase colorsManagerCyan = _ColorsManagerCyan();
AppColorsBase colorsManagerCyanDark = _ColorsManagerCyanDark();

// ========================== 🔥 Abstract Base Colors Class 🔥 ==========================

abstract class AppColorsBase {
  // ========================== 🔥 Primary Colors 🔥 ==========================

  /// Main primary color used throughout the app.
  Color get primary;

  Color get accentOrange;

  Color get secondaryPrimary;

  // ========================== 🔥 Text Colors 🔥 ==========================

  /// Default text color for general content.
  Color get textPrimary;

  /// Secondary text color for less emphasis content.
  Color get textSecondary;

  // ========================== 🔥 Background Colors 🔥 ==========================

  /// General background color for screens and containers.
  Color get background;

  /// Background color for cards and elevated containers.
  Color get cardBackground;

  /// Divider or section background to separate content.
  Color get divider;

  // ========================== 🔥 Border Colors 🔥 ==========================

  /// Standard border color for inputs and containers.
  Color get border;

  // ========================== 🔥 Button Colors 🔥 ==========================

  /// Disabled button color for inactive states.
  Color get buttonDisabled;

  // ========================== 🔥 Status Colors 🔥 ==========================

  /// Success color for positive feedback.
  Color get success;

  /// Warning color for caution messages.
  Color get warning;

  /// Error color for error messages and indicators.
  Color get error;

  Color get info;
}

// ========================== 🔥 ColorsManagerNormal 🔥 ==========================

class _ColorsManagerDeepBlue implements AppColorsBase {
  // ========================== 🔥 Primary Colors 🔥 ==========================
  @override
  Color get primary => const Color(0xFF103E61);

  @override
  Color get accentOrange => const Color(0xFFFF5F18);

  @override
  Color get secondaryPrimary => const Color(0xFF1F78B4);

  // ========================== 🔥 Text Colors 🔥 ==========================
  @override
  Color get textPrimary => const Color(0xFF000000);

  @override
  Color get textSecondary => const Color(0xFF4F4F4F);

  // ========================== 🔥 Background Colors 🔥 ==========================
  @override
  Color get background => const Color(0xFFFFFFFF);

  @override
  Color get cardBackground => const Color(0xFFFFFFFF);

  @override
  Color get divider => const Color(0xFFC5C5C5);

  // ========================== 🔥 Border Colors 🔥 ==========================
  @override
  Color get border => const Color(0xFFCBCBCB);

  // ========================== 🔥 Button Colors 🔥 ==========================
  @override
  Color get buttonDisabled => const Color(0xFFBDBDBD);

  // ========================== 🔥 Status Colors 🔥 ==========================
  @override
  Color get success => const Color(0xFF4CAF50);

  @override
  Color get warning => const Color(0xFFFFC107);

  @override
  Color get error => const Color(0xFFF44336);

  @override
  Color get info => const Color(0xFF2196F3);
}

// ========================== 🔥 ColorsManagerDark 🔥 ==========================

class _ColorsManagerDeepBlueDark implements AppColorsBase {
  // ========================== 🔥 Primary Colors 🔥 ==========================
  @override
  Color get primary => const Color(0xFF90CAF9); // نسخة أفتح من الأزرق الأساسي

  @override
  Color get accentOrange => const Color(0xFFFFA726); // برتقالي دافئ للوضع الداكن

  @override
  Color get secondaryPrimary => const Color(0xFF64B5F6); // أزرق ثانوي مناسب للوضع الداكن

  // ========================== 🔥 Text Colors 🔥 ==========================
  @override
  Color get textPrimary => const Color(0xFFFFFFFF); // أبيض ليتباين مع الخلفية الداكنة

  @override
  Color get textSecondary => const Color(0xFFB0BEC5); // رمادي فاتح

  // ========================== 🔥 Background Colors 🔥 ==========================
  @override
  Color get background => const Color(0xFF121212); // خلفية داكنة قياسية

  @override
  Color get cardBackground => const Color(0xFF1E1E1E); // خلفية أفتح قليلاً للبطاقات

  @override
  Color get divider => const Color(0xFF424242); // رمادي متوسط

  // ========================== 🔥 Border Colors 🔥 ==========================
  @override
  Color get border => const Color(0xFF616161); // رمادي غامق

  // ========================== 🔥 Button Colors 🔥 ==========================
  @override
  Color get buttonDisabled => const Color(0xFF757575); // رمادي متوسط

  // ========================== 🔥 Status Colors 🔥 ==========================
  @override
  Color get success => const Color(0xFF81C784); // أخضر فاتح

  @override
  Color get warning => const Color(0xFFFFB74D); // برتقالي فاتح

  @override
  Color get error => const Color(0xFFE57373); // أحمر فاتح

  @override
  Color get info => const Color(0xFF64B5F6);
}

// ========================== 🔥 ColorsManagerPurple 🔥 ==========================
class _ColorsManagerPurple implements AppColorsBase {
  // ========================== 🔥 Primary Colors 🔥 ==========================
  @override
  Color get primary => const Color(0xFF6A0DAD); // Royal Purple

  @override
  Color get accentOrange => const Color(0xFFFFA500); // Vibrant Orange

  @override
  Color get secondaryPrimary => const Color(0xFF9D00FF); // Electric Purple

  // ========================== 🔥 Text Colors 🔥 ==========================
  @override
  Color get textPrimary => const Color(0xFF1E1E1E); // Dark Gray

  @override
  Color get textSecondary => const Color(0xFF6C6C6C); // Medium Gray

  // ========================== 🔥 Background Colors 🔥 ==========================
  @override
  Color get background => const Color(0xFFF5F5F5); // Light Gray

  @override
  Color get cardBackground => const Color(0xFFFFFFFF); // White

  @override
  Color get divider => const Color(0xFFE0E0E0); // Light Gray

  // ========================== 🔥 Border Colors 🔥 ==========================
  @override
  Color get border => const Color(0xFFCCCCCC); // Light Gray

  // ========================== 🔥 Button Colors 🔥 ==========================
  @override
  Color get buttonDisabled => const Color(0xFFBDBDBD); // Gray

  // ========================== 🔥 Status Colors 🔥 ==========================
  @override
  Color get success => const Color(0xFF4CAF50); // Green

  @override
  Color get warning => const Color(0xFFFFC107); // Amber

  @override
  Color get error => const Color(0xFFF44336); // Red

  @override
  Color get info => const Color(0xFF2196F3); // Blue
}

// ========================== 🔥 ColorsManager  🔥 ==========================
class _ColorsManagerCyan implements AppColorsBase {
  // ========================== 🔥 Primary Colors 🔥 ==========================
  @override
  Color get primary => const Color(0xFF00AEEF); // اللون الأساسي الجديد

  @override
  Color get accentOrange => const Color(0xFFFF6F3C); // برتقالي مكمل للسيان

  @override
  Color get secondaryPrimary => const Color(0xFF007C9D); // سيان داكن مكمل

  // ========================== 🔥 Text Colors 🔥 ==========================
  @override
  Color get textPrimary => const Color(0xFF002B3D); // لون نص داكن يتماشى مع السيان

  @override
  Color get textSecondary => const Color(0xFF4A4A4A);

  // ========================== 🔥 Background Colors 🔥 ==========================
  @override
  Color get background => const Color(0xFFFFFFFF);

  @override
  Color get cardBackground => const Color(0xFFF7FBFD); // خلفية فاتحة بمسحة سيان

  @override
  Color get divider => const Color(0xFFC0E7F5); // Divider بلون سيان فاتح

  // ========================== 🔥 Border Colors 🔥 ==========================
  @override
  Color get border => const Color(0xFFB1DDF0); // حدود ناعمة بلون مكمل

  // ========================== 🔥 Button Colors 🔥 ==========================
  @override
  Color get buttonDisabled => const Color(0xFFBFD9E5); // لون أزرار معطلة بدرجة باهتة

  // ========================== 🔥 Status Colors 🔥 ==========================
  @override
  Color get success => const Color(0xFF4CAF50);

  @override
  Color get warning => const Color(0xFFFFC107);

  @override
  Color get error => const Color(0xFFF44336);

  @override
  Color get info => const Color(0xFF00BCD4); // لون info قريب من السيان
}

// ========================== 🔥 ColorsManager dark  🔥 ==========================

class _ColorsManagerCyanDark implements AppColorsBase {
  // ========================== 🔥 Primary Colors 🔥 ==========================
  @override
  Color get primary => const Color(0xFF00AEEF);

  @override
  Color get accentOrange => const Color(0xFFFF6F3C);

  @override
  Color get secondaryPrimary => const Color(0xFF00B4D8);

  // ========================== 🔥 Text Colors 🔥 ==========================
  @override
  Color get textPrimary => const Color(0xFFFFFFFF);

  @override
  Color get textSecondary => const Color(0xFFB0BEC5);

  // ========================== 🔥 Background Colors 🔥 ==========================
  @override
  Color get background => const Color(0xFF121212); // خلفية داكنة

  @override
  Color get cardBackground => const Color(0xFF1E1E1E); // بطاقات بدرجة داكنة متوسطة

  @override
  Color get divider => const Color(0xFF2C2C2C); // Divider خافت

  // ========================== 🔥 Border Colors 🔥 ==========================
  @override
  Color get border => const Color(0xFF37474F); // حدود بوضوح متوسط

  // ========================== 🔥 Button Colors 🔥 ==========================
  @override
  Color get buttonDisabled => const Color(0xFF455A64); // زر معطل بدرجة رمادية باردة

  // ========================== 🔥 Status Colors 🔥 ==========================
  @override
  Color get success => const Color(0xFF66BB6A);

  @override
  Color get warning => const Color(0xFFFFCA28);

  @override
  Color get error => const Color(0xFFEF5350);

  @override
  Color get info => const Color(0xFF00BCD4);
}
