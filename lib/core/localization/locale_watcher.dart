import 'package:easy_localization/easy_localization.dart';
import 'package:flustra_template/core/extensions/context_get_x.dart';
import 'package:flutter/material.dart';

class LocaleWatcher extends StatefulWidget {
  final Widget Function() child;

  const LocaleWatcher({required this.child, super.key});

  @override
  State<LocaleWatcher> createState() => _LocaleWatcherState();
}

class _LocaleWatcherState extends State<LocaleWatcher> {
  @override
  Widget build(BuildContext context) {
    final _ = context.locale; // هذا هو السحر
    final _ = context.theme; // هذا هو السحر
    return widget.child();
  }
}
