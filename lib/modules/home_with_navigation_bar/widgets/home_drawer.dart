import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/modules/debug_helper/views/peoxy/proxy_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDrawer();
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Text(
              'القائمة الجانبية',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('الرئيسية'),
            onTap: () {
              popIfUCan();
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('الإعدادات'),
            onTap: () {
              popIfUCan();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('تسجيل الخروج'),
            onTap: () {
              popIfUCan();
            },
          ),
          if (kDebugMode) const Divider(),
          ...[
            ListTile(
              leading: const Icon(Icons.network_check_rounded),
              title: const Text('Proxy'),
              onTap: () {
                popIfUCan();
                ProxyView.navigateToMe();
              },
            ),
            ListTile(
              leading: const Icon(Icons.color_lens_outlined),
              title: const Text('Theme Showcase'),
              onTap: () {
                popIfUCan();
                navigateTo(AppRoutes.themeShowcaseScreen);
              },
            ),
          ],
        ],
      ),
    );
  }
}
