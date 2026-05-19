import 'package:flustra_template/core/helper/dialogs/logout_delete.dart';
import 'package:flustra_template/core/helper/dialogs/logout_dialog.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/core/services/app_session_manager.dart';
import 'package:flustra_template/modules/debug_helper/views/peoxy/proxy_view.dart';
import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {
  // ========================== Constructor ========================== //
  SettingsViewModel();

  // ========================== 🔒 Private variables 🔒 ========================== //
  final String settingsState = UniqueKey().toString();

  // ========================== 🗝️ Public getters 🗝️ ========================== //
  String get userName => AppSessionManager.name ?? '';

  String get userEmail => AppSessionManager.email ?? '';

  bool get amILogin => AppSessionManager.amILogin;

  // ========================== 🌍 Public events 🌍 ========================== //
  void init() {
    debugPrint('🔵 SettingsViewModel.init() called, amILogin=$amILogin');
  }

  // --------------------------[ onLogout ]-------------------------- //
  void onLogout() {
    showLogoutConfirmationDialog();
  }

  // --------------------------[ onDeleteAccount ]-------------------------- //
  void onDeleteAccount() {
    showDeleteAccountDialog();
  }

  // --------------------------[ onLogin ]-------------------------- //
  void onLogin() {
    navigateTo(AppRoutes.login);
  }

  // --------------------------[ onChangeLanguage ]-------------------------- //
  void onChangeLanguage() {
    navigateTo(AppRoutes.languageSelectionScreen);
  }

  // --------------------------[ onNotificationsTap ]-------------------------- //
  void onNotificationsTap() {
    // TODO: Implement Notifications screen
    print('SettingsViewModel.onNotificationsTap() triggered');
  }

  // --------------------------[ onBillingTap ]-------------------------- //
  void onBillingTap() {
    // TODO: Implement Billing screen
    print('SettingsViewModel.onBillingTap() triggered');
  }

  // --------------------------[ onProxyTap ]-------------------------- //
  void onProxyTap() {
    ProxyView.navigateToMe();
  }

  // --------------------------[ onThemeShowcaseTap ]-------------------------- //
  void onThemeShowcaseTap() {
    navigateTo(AppRoutes.themeShowcaseScreen);
  }
}
