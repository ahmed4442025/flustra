import 'package:flutter/material.dart';

class SimplePage extends StatelessWidget {
  final String pageName;

  const SimplePage({super.key, required this.pageName});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(pageName, style: Theme.of(context).textTheme.displaySmall));
  }
}
