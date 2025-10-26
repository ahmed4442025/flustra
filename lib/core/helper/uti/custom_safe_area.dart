import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomSafeArea extends StatelessWidget {
  final Widget child;

  const CustomSafeArea({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return child;
    }
    if (Platform.isAndroid) return SafeArea(child: child);
    return child;
  }
}
