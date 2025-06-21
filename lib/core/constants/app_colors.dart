import 'package:flutter/material.dart';

AppColorsBase colorsManagerNormal = _ColorsManagerNormal();
AppColorsBase colorsManagerDark = _ColorsManagerDark();

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
}

// ========================== 🔥 ColorsManagerNormal 🔥 ==========================

class _ColorsManagerNormal implements AppColorsBase {
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
}

// ========================== 🔥 ColorsManagerDark 🔥 ==========================

class _ColorsManagerDark implements AppColorsBase {
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
}
