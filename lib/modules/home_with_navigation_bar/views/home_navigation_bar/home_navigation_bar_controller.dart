import 'package:flustra_template/core/helper/dialogs/exit_dialog.dart';
import 'package:flustra_template/modules/products/views/products_home/products_home.dart';
import 'package:flutter/material.dart';

import '../../widgets/nav_bar_icon_widget.dart';
import '../simple_test_page.dart';
import 'home_navigation_bar.dart';

/// HomeNavigationBarController can be used to manage state and notify listeners about changes.
class HomeNavigationBarController extends ChangeNotifier {
  // ========================== Constructor ==========================
  HomeNavigationBarController._();

  static final HomeNavigationBarController i = HomeNavigationBarController._();

  // ========================== 🔒 Private variables 🔒 ==========================
  /// Private variables These variables should be private to the controller and accessed through public methods.

  // ========================== 🗝️ Public variables 🗝️ ==========================
  /// These variables are accessible to the widgets or other parts of the app.

  MainScreenPageType selectedPageType = MainScreenPageType.home;

  // مفتاح للوصول إلى حالة الـ Scaffold (مهم لمعرفة هل الـ Drawer مفتوح أم لا)
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Widget get selectedPage => _pages[selectedPageType]?.screen ?? Text('404');

  List<Widget> get navBarItems => _pages.values.map((e) => e.buttonIcon).toList();

  // -------------------------- pages --------------------------
   Map<MainScreenPageType, NavBarItemModel> get _pages => {
    MainScreenPageType.home: NavBarItemModel(
      screen: ProductsHomeScreen(),
      buttonIcon: NavBarIconWidget(
        isSelected: selectedPageType == MainScreenPageType.home,
        onTap: () => onItemTapped(MainScreenPageType.home),
        icon: Icons.home,
        label: () => "home",
      ),
    ),
    MainScreenPageType.search: NavBarItemModel(
      screen: SimplePage(pageName: 'البحث (Search)'),
      buttonIcon: NavBarIconWidget(
        isSelected: selectedPageType == MainScreenPageType.search,
        onTap: () => onItemTapped(MainScreenPageType.search),
        icon: Icons.search,
        label: () => "search",
      ),
    ),
    MainScreenPageType.profile: NavBarItemModel(
      screen: SimplePage(pageName: 'الملف الشخصي (Profile)'),
      buttonIcon: NavBarIconWidget(
        isSelected: selectedPageType == MainScreenPageType.profile,
        onTap: () => onItemTapped(MainScreenPageType.profile),
        icon: Icons.person,
        label: () => "profile",
      ),
    ),
    MainScreenPageType.settings: NavBarItemModel(
      screen: SimplePage(pageName: 'الإعدادات (Settings)'),
      buttonIcon: NavBarIconWidget(
        isSelected: selectedPageType == MainScreenPageType.settings,
        onTap: () => onItemTapped(MainScreenPageType.settings),
        icon: Icons.settings,
        label: () => "settings",
      ),
    ),
  };

  // ========================== 🔥 initialization 🔥 ==========================
  ///  Initialization logic and variables or call initialization methods.
  void init() {}

  // ========================== 🌍 Public methods and events 🌍 ==========================
  /// These methods are used by the UI or other logic to interact with the controller. => Call notifyListeners() to update the UI

  // -------------------------- onTapDrawer --------------------------
  void onTapDrawer() => scaffoldKey.currentState?.openDrawer();
  // -------------------------- onItemTapped --------------------------
  void onItemTapped(MainScreenPageType type) {
    selectedPageType = type;
    notifyListeners();
  }

  // -------------------------- handleBackButton --------------------------
  void handleBackButton(context) {
    if (scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.of(context).pop(); // if drawer is open, close it
    } else if (selectedPageType != MainScreenPageType.home) {
      onItemTapped(MainScreenPageType.home); // if not home screen, go to home screen
    } else {
      showExitConfirmationDialog(); // if home screen, show exit confirmation dialog
    }
  }

// ========================== 🔒 Private methods 🔒 ==========================
  /// These are internal methods specific to the controller, Use them to encapsulate any logic that doesn't need to be exposed.
}

class NavBarItemModel {
  final Widget screen;
  final Widget buttonIcon;

  NavBarItemModel({required this.screen, required this.buttonIcon});
}
