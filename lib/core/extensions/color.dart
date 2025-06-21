import 'dart:math';

import 'package:flutter/material.dart';

extension ColorEx on List<MaterialColor> {
  Color random() => this[Random().nextInt(length)];
}

// ========================== 🔥 Color 🔥 ==========================

extension ColorExtension on Color {
  Color withOpacityEX(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0, 'Opacity must be between 0.0 and 1.0');
    return withAlpha((opacity * 255).round().clamp(0, 255));
  }
}
