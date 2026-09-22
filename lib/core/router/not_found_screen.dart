import 'package:flustra_template/core/constants/app_defults.dart';
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
          gradient: LinearGradient(colors: [AppColors.primaryHover, AppColors.primary], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 100, color: AppColors.onPrimary),
              const SizedBox(height: 20),
              Text('404', style: AppTextStyle.displayLarge.copyWith(fontSize: 80, color: AppColors.onPrimary)),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () => navigateTo(homeRoute),
                icon: Icon(Icons.home),
                label: Text(''),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.surfaceContainer,
                  foregroundColor: AppColors.primary,
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
