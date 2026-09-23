import 'dart:async';
import 'dart:math';

import 'package:flustra_template/core/constants/app_constant.dart';
import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/constants/app_images.dart';
import 'package:flustra_template/core/extensions/context_get_x.dart';
import 'package:flustra_template/core/router/navigation_manager.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const Duration _splashDuration = Duration(seconds: 3);

  Timer? _timer;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(_splashDuration, _navigateToNextScreen);
  }

  void _onTapScreen() {
    if (_hasNavigated) return;
    _timer?.cancel();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    if (_hasNavigated) return;
    _hasNavigated = true;
    _timer?.cancel();

    NavigationManager.navigateFromSplash();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onTapScreen,
        child: SizedBox.expand(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: min(context.width * .3, context.height * .3),
                    maxHeight: min(context.width * .3, context.height * .3),
                  ),
                  child: Image.asset(AppAssetsImages.logo.logo),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.width * .1),
                  child: FittedBox(
                    child: Text(AppConstant.appName, style: AppTextStyle.displayLarge.copyWith(color: AppColors.primary)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
