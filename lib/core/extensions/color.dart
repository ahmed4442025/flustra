import 'dart:math';

import 'package:flutter/material.dart';

extension ColorEx on List<MaterialColor> {
  Color random() => this[Random().nextInt(length)];
}
