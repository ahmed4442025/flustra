import 'dart:async';
import 'dart:math';

import 'package:flustra_template/core/constants/app_constant.dart';
import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/constants/app_images.dart';
import 'package:flustra_template/core/data/cache/cache_key.dart';
import 'package:flustra_template/core/extensions/context_get_x.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flutter/material.dart';

import 'onboarding/onbearding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const Duration _splashDuration = Duration(seconds: 3);

  Timer? _timer;
  bool _hasNavigated = false;

  bool get _shouldShowOnboarding => !(AppCache.getBool(key: CacheKey.skipOnBoarding) ?? false);

  bool get _isUserLoggedIn => AppCache.getString(key: CacheKey.loginResponse)?.isNotEmpty ?? false;

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

  Future<void> _navigateToNextScreen() async {
    if (_hasNavigated) return;
    _hasNavigated = true;
    _timer?.cancel();

    if (_shouldShowOnboarding) {
      OnboardingScreen.navigateToMe(type: NavigationType.finish);
      return;
    }

    if (!_isUserLoggedIn) {
      navigateTo(AppRoutes.login, type: NavigationType.finish);
      return;
    }

    navigateTo(AppRoutes.homeScreenWithNavigationBar, type: NavigationType.finish);
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
