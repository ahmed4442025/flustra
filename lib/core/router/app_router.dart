import 'package:bot_toast/bot_toast.dart';
import 'package:flustra_template/core/localization/locale_watcher.dart';
import 'package:flustra_template/main.dart';
import 'package:flustra_template/modules/auth/login/login_screen.dart';
import 'package:flustra_template/modules/debug_helper/views/peoxy/proxy_view.dart';
import 'package:flustra_template/modules/debug_helper/views/theme_showcase_screen.dart';
import 'package:flustra_template/modules/home_with_navigation_bar/views/home_navigation_bar/home_navigation_bar.dart';
import 'package:flustra_template/modules/splash/views/onboarding/onbearding_screen.dart';
import 'package:flustra_template/modules/splash/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'not_found_screen.dart';

// ========================== 🔥 Routers 🔥 ==========================

abstract class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String onboarding = '/onboarding';
  static const String homeScreenWithNavigationBar = '/homeScreenWithNavigationBar';
  static const String themeShowcaseScreen = '/ThemeShowcaseScreen';
  static const String proxyView = '/ProxyView';

}

// ========================== 🔥 routerConfig 🔥 ==========================

final GoRouter routerConfig = GoRouter(
  navigatorKey: navigatorKey,
  observers: [BotToastNavigatorObserver()],
  initialLocation: AppRoutes.splash,
  errorBuilder: (context, state) => NotFoundScreen(homeRoute: AppRoutes.home),
  routes: _buildRoutes(),
);

// ========================== 🔥 _buildRoutes 🔥 ==========================

/// Build and return all application routes
List<RouteBase> _buildRoutes() {
  return [
    _baseGoRoute(AppRoutes.login, (_) => LoginScreen()),
    _baseGoRoute(AppRoutes.splash, (_) => SplashScreen()),
    _baseGoRoute(AppRoutes.onboarding, (_) => OnboardingScreen()),
    _baseGoRoute(AppRoutes.themeShowcaseScreen, (_) => ThemeShowcaseScreen()),
    _baseGoRoute<HomeScreenWithNavigationBarData>(AppRoutes.homeScreenWithNavigationBar, (data) => HomeScreenWithNavigationBar(data: data)),
    _baseGoRoute(AppRoutes.proxyView, (_) => ProxyView()),
  ];
}

// ========================== 🔥 base GoRoute 🔥 ==========================
GoRoute _baseGoRoute<T>(String path, Widget Function(T? data) screen) {
  // if first char in path not "/" add it
  if (path.isNotEmpty && path[0] != '/') path = '/$path';

  return GoRoute(
    path: path,
    name: path,
    builder: (context, state) => LocaleWatcher(child: ()=>screen(getTheObjectOrNull(state.extra))),
  );
}

// -------------------------- getTheObjectOrNull --------------------------

T? getTheObjectOrNull<T>(Object? extra) {
  print("extra : $extra type ${extra.runtimeType}");

  if (extra == null || extra is! T) return null;
  print("2");
  return extra as T;
}
