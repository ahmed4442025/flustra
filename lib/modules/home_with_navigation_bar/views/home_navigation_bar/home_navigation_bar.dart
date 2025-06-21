import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/helper/dialogs/exit_dialog.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flutter/material.dart';

import '../widgets/home_drawer.dart';
import 'simple_test_page.dart';

enum MainScreenPageType {
  home,
  search,
  profile,
  settings,
}

class HomeScreenWithNavigationBarData {
  final MainScreenPageType initialPage;

  HomeScreenWithNavigationBarData({required this.initialPage});
}

class HomeScreenWithNavigationBar extends StatefulWidget {
  final HomeScreenWithNavigationBarData? data;

  static void navigateToMe(HomeScreenWithNavigationBarData? data) => navigateTo(AppRoutes.homeScreenWithNavigationBar, arguments: data);

  const HomeScreenWithNavigationBar({super.key, this.data});

  @override
  State<HomeScreenWithNavigationBar> createState() => _HomeScreenWithNavigationBarState();
}

class _HomeScreenWithNavigationBarState extends State<HomeScreenWithNavigationBar> {
  int _selectedIndex = 0;

  // to change the page based on index
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _handleBackButton();
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: _buildAppBar(),
        drawer: HomeDrawerWidget(),
        body: _pages.elementAt(_selectedIndex),
        floatingActionButton: _buildFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _buildBottomAppBar(),
      ),
    );
  }

  void _handleBackButton() {
    // if drawer is open, close it
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.of(context).pop();
    }
    // if not home screen, go to home screen
    else if (_selectedIndex != 0) {
      _onItemTapped(0);
    }
    // if home screen, show exit confirmation dialog
    else {
      showExitConfirmationDialog();
    }
  }

  /// دالة لبناء الـ AppBar العلوي
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Modern UI'),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () {
            // أضف هنا وظيفة لزر الإشعارات
          },
        ),
      ],
    );
  }

  /// دالة لبناء الزر العائم (FAB)
  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        showExitConfirmationDialog();
        // AppSnackBar.show("message", type: ToastType.info);
      },
      shape: const CircleBorder(),
      child: const Icon(Icons.add),
    );
  }

  /// دالة لبناء شريط التنقل السفلي
  Widget _buildBottomAppBar() {
    return BottomAppBar(
      color: AppColors.primary,
      surfaceTintColor: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildNavItem(Icons.home, 'الرئيسية', 0),
          _buildNavItem(Icons.search, 'بحث', 1),
          const SizedBox(width: 40), // مساحة فارغة في المنتصف للـ FAB
          _buildNavItem(Icons.person, 'ملفي', 2),
          _buildNavItem(Icons.settings, 'الإعدادات', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    final color = isSelected ? Colors.white : Colors.grey;
    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        child: Column(
          children: [
            Icon(icon, color: color),
            Text(label, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}
