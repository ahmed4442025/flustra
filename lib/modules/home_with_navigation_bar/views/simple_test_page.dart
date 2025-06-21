import 'package:flutter/material.dart';

class SimplePage extends StatelessWidget {
  final String pageName;

  const SimplePage({super.key, required this.pageName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        pageName,
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
    );
  }
}
