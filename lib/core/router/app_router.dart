import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flustra_template/main.dart';
import 'package:flustra_template/modules/auth/login/login_screen.dart';
import 'package:flustra_template/modules/auth/theme_showcase_screen.dart';
import 'package:flustra_template/modules/splash/views/splash_screen.dart';

import 'not_found_screen.dart';

// ========================== 🔥 Routers 🔥 ==========================

abstract class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String pubScreen = '/pubScreen';
  static const String themeShowcaseScreen = '/ThemeShowcaseScreen';
}

// ========================== 🔥 routerConfig 🔥 ==========================

final GoRouter routerConfig = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: AppRoutes.themeShowcaseScreen,
  errorBuilder: (context, state) => NotFoundScreen(homeRoute: AppRoutes.login),
  routes: _buildRoutes(),
);


// ========================== 🔥 _buildRoutes 🔥 ==========================

/// Build and return all application routes
List<RouteBase> _buildRoutes() {
  return [
    _baseGoRoute<LoginScreenData>(AppRoutes.login, (data) => LoginScreen(data: data)),
    _baseGoRoute(AppRoutes.splash, (_) => SplashScreen()),
    _baseGoRoute(AppRoutes.themeShowcaseScreen, (_) => ThemeShowcaseScreen()),
  ];
}

// ========================== 🔥 base GoRoute 🔥 ==========================
GoRoute _baseGoRoute<T>(String path, Widget Function(T? data) screen) {
  // if first char in path not "/" add it
  if (path.isNotEmpty && path[0] != '/') path = '/$path';

  return GoRoute(
    path: path,
    name: path,
    builder: (context, state) => screen(getTheObjectOrNull(state.extra)),
  );
}

// -------------------------- getTheObjectOrNull --------------------------

T? getTheObjectOrNull<T>(Object? extra) {
  if (T != dynamic) return null;
  if (extra == null || extra is! T) return null;
  return extra as T;
}
