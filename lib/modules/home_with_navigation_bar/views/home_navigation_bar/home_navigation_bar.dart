import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flutter/material.dart';

import 'home_navigation_bar_controller.dart';

enum MainScreenPageType { home, leads, chat, alerts, settings }

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
  // --------------------------[ Controller & State ]-------------------------- //
  void _refresh() {
    if (mounted) setState(() {});
  }

  late final HomeNavigationBarController _controller = HomeNavigationBarController.i;

  @override
  void initState() {
    super.initState();
    _controller.selectedPageType = widget.data?.initialPage ?? MainScreenPageType.home;
    _controller.addListener(_refresh);
  }

  @override
  void dispose() {
    _controller.removeListener(_refresh);
    super.dispose();
  }

  // --------------------------[ Build ]-------------------------- //
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _controller.handleBackButton(context);
      },
      child: Scaffold(body: _controller.selectedPage, bottomNavigationBar: _buildBottomAppBar()),
    );
  }

  // --------------------------[ BottomAppBar ]-------------------------- //
  Widget _buildBottomAppBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        border: Border(top: BorderSide(color: AppColors.outlineVariant, width: 1.0)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.only(top: 6, bottom: 10, start: 8, end: 8),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: _controller.navBarItems),
        ),
      ),
    );
  }
}
