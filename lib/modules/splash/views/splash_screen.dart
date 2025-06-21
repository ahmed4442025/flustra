import 'dart:math';

import 'package:flustra_template/core/constants/app_constant.dart';
import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/constants/app_images.dart';
import 'package:flustra_template/core/data/cache/cache_key.dart';
import 'package:flustra_template/core/extensions/context_get_x.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'onboarding/onbearding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _gotoNext();
    super.initState();
  }

  Future<void> _gotoNext() async {
    int ms = 3000;
    if (kDebugMode) ms = 300;
    await Future.delayed(Duration(milliseconds: ms));

    // -------------------------- check first time open app --------------------------
    bool isSkipOnboarding = AppCache.getBool(key: CacheKey.skipOnBoarding) ?? false;
    if (!isSkipOnboarding) return OnboardingScreen.navigateToMe(type: NavigationType.finish);

    // -------------------------- check if login --------------------------
    bool isLogin = AppCache.getString(key: CacheKey.loginResponse)?.isNotEmpty ?? false;
    if (!isLogin) return navigateTo(AppRoutes.login, type: NavigationType.finish);

    navigateTo(AppRoutes.homeScreenWithNavigationBar, type: NavigationType.finish);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: AppColors.secondaryPrimary,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: min(context.width * .3, context.height * .3),
                  maxHeight: min(context.width * .3, context.height * .3),
                ),
                child: Image.asset(
                  AppAssetsImages.logo.logo,
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.width * .1),
                child: FittedBox(
                  child: Text(
                    AppConstant.appName,
                    style: AppTextStyle.displayLarge.copyWith(color: AppColors.primary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
