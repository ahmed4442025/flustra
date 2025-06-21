import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/helper/dialogs/exit_dialog.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flutter/material.dart';

import '../../widgets/home_drawer.dart';
import 'home_navigation_bar_controller.dart';

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
  void _refresh() {
    if (mounted) setState(() {});
  }

  late final HomeNavigationBarController _controller = HomeNavigationBarController.i;

  @override
  void initState() {
    _controller.addListener(_refresh);
    Future.delayed(Duration(milliseconds: 100), () => _controller.onItemTapped(widget.data?.initialPage ?? MainScreenPageType.home));

    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_refresh);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _controller.handleBackButton(context);
      },
      child: Scaffold(
        key: _controller.scaffoldKey,
        appBar: _buildAppBar(),
        drawer: HomeDrawerWidget(),
        body: _controller.selectedPage,
        floatingActionButton: _buildFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _buildBottomAppBar(),
      ),
    );
  }

  // -------------------------- App Bar --------------------------
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Modern UI'),
      centerTitle: true,
      leading: IconButton(icon: const Icon(Icons.menu), onPressed: _controller.onTapDrawer),
    );
  }

// -------------------------- FAB --------------------------
  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      heroTag: "add home",
      onPressed: () {
        print("widget.data?.initialPage ${widget.data?.initialPage}");
        _controller.onItemTapped(widget.data?.initialPage ?? MainScreenPageType.home);
        // showExitConfirmationDialog();
      },
      shape: const CircleBorder(),
      child: const Icon(Icons.add),
    );
  }

// -------------------------- BottomAppBar --------------------------
  Widget _buildBottomAppBar() {
    return BottomAppBar(
      color: AppColors.primary,
      surfaceTintColor: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _controller.navBarItems,
      ),
    );
  }
}
