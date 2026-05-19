import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/dialogs/exit_dialog.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/modules/products/views/products_home/products_home.dart';
import 'package:flustra_template/modules/settings/views/settings/settings_screen.dart';
import 'package:flutter/material.dart';

import '../../widgets/nav_bar_icon_widget.dart';
import '../simple_test_page.dart';
import 'home_navigation_bar.dart';

/// HomeNavigationBarController manages the bottom navigation bar active tab state and pages list.
class HomeNavigationBarController extends ChangeNotifier {
  // ========================== Constructor ==========================
  HomeNavigationBarController._();

  static final HomeNavigationBarController i = HomeNavigationBarController._();

  // ========================== 🔒 Private variables 🔒 ==========================
  /// Private variables These variables should be private to the controller and accessed through public methods.

  // ========================== 🗝️ Public variables 🗝️ ==========================
  /// These variables are accessible to the widgets or other parts of the app.

  MainScreenPageType selectedPageType = MainScreenPageType.home;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Widget get selectedPage => _pages[selectedPageType]?.screen ?? const Text('404');

  List<Widget> get navBarItems => _pages.values.map((e) => e.buttonIcon).toList();

  // -------------------------- pages --------------------------
  Map<MainScreenPageType, NavBarItemModel> get _pages => {
    MainScreenPageType.home: NavBarItemModel(
      screen: const ProductsHomeScreen(),
      buttonIcon: NavBarIconWidget(
        isSelected: selectedPageType == MainScreenPageType.home,
        onTap: () => onItemTapped(MainScreenPageType.home),
        icon: Icons.home_outlined,
        label: () => AppStrings.home.tx(),
      ),
    ),
    MainScreenPageType.leads: NavBarItemModel(
      screen: const SimplePage(pageName: 'Leads'),
      buttonIcon: NavBarIconWidget(
        isSelected: selectedPageType == MainScreenPageType.leads,
        onTap: () => onItemTapped(MainScreenPageType.leads),
        icon: Icons.people_outline_rounded,
        label: () => AppStrings.leads.tx(),
      ),
    ),
    MainScreenPageType.chat: NavBarItemModel(
      screen: const SimplePage(pageName: 'Chat'),
      buttonIcon: NavBarIconWidget(
        isSelected: selectedPageType == MainScreenPageType.chat,
        onTap: () => onItemTapped(MainScreenPageType.chat),
        icon: Icons.chat_bubble_outline_rounded,
        label: () => AppStrings.chat.tx(),
      ),
    ),
    MainScreenPageType.alerts: NavBarItemModel(
      screen: const SimplePage(pageName: 'Alerts'),
      buttonIcon: NavBarIconWidget(
        isSelected: selectedPageType == MainScreenPageType.alerts,
        onTap: () => onItemTapped(MainScreenPageType.alerts),
        icon: Icons.notifications_outlined,
        label: () => AppStrings.alerts.tx(),
        badgeCount: 3,
      ),
    ),
    MainScreenPageType.settings: NavBarItemModel(
      screen: const SettingsScreen(),
      buttonIcon: NavBarIconWidget(
        isSelected: selectedPageType == MainScreenPageType.settings,
        onTap: () => onItemTapped(MainScreenPageType.settings),
        icon: Icons.settings_outlined,
        label: () => AppStrings.settings.tx(),
      ),
    ),
  };

  // ========================== 🔥 initialization 🔥 ==========================
  void init() {}

  // ========================== 🌍 Public methods and events 🌍 ==========================
  // -------------------------- onItemTapped --------------------------
  void onItemTapped(MainScreenPageType type) {
    selectedPageType = type;
    notifyListeners();
  }

  // -------------------------- handleBackButton --------------------------
  void handleBackButton(BuildContext context) {
    if (selectedPageType != MainScreenPageType.home) {
      onItemTapped(MainScreenPageType.home);
    } else {
      showExitConfirmationDialog();
    }
  }

  // ========================== 🔒 Private methods 🔒 ==========================
}

class NavBarItemModel {
  final Widget screen;
  final Widget buttonIcon;

  NavBarItemModel({required this.screen, required this.buttonIcon});
}
