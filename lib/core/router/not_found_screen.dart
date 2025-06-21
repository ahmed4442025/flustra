import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  final String homeRoute;

  const NotFoundScreen({super.key, required this.homeRoute});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade400, Colors.indigo.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 100, color: Colors.white),
              const SizedBox(height: 20),
              Text(
                '404',
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () => navigateTo(homeRoute),
                icon: Icon(Icons.home),
                label: Text(''),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.indigo,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
