import 'package:flustra_template/core/data/cache/cache_key.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/core/services/app_session_manager.dart';
import 'package:flustra_template/modules/home_with_navigation_bar/views/home_navigation_bar/home_navigation_bar.dart';
import 'package:flustra_template/modules/splash/views/onboarding/onbearding_screen.dart';

class NavigationManager {
  NavigationManager._();

  static bool get _hasCompletedOnboarding => AppCache.getBool(key: CacheKey.skipOnBoarding) ?? false;

  static bool get _isLoggedIn => AppSessionManager.amILogin;

  // --------------------------[ navigateFromSplash ]-------------------------- //
  static void navigateFromSplash() {
    if (!_hasCompletedOnboarding) {
      OnboardingScreen.navigateToMe(type: NavigationType.finish);
      return;
    }

    if (!_isLoggedIn) {
      navigateToLogin();
      return;
    }

    navigateToHome();
  }

  // --------------------------[ navigateToLogin ]-------------------------- //
  static void navigateToLogin() => navigateTo(AppRoutes.login, type: NavigationType.finish);

  // --------------------------[ navigateToHome ]-------------------------- //
  static void navigateToHome() => HomeScreenWithNavigationBar.navigateToMe(null, type: NavigationType.finish);
}
