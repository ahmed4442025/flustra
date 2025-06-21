import 'package:flutter/material.dart';

import 'home_navigation_bar.dart';

class HomeNavigationBarController {

  // مفتاح للوصول إلى حالة الـ Scaffold (مهم لمعرفة هل الـ Drawer مفتوح أم لا)
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // قائمة الصفحات التي سيتم عرضها
  static const Map<MainScreenPageType, Widget> _pages = {
    SimplePage(pageName: 'الرئيسية (Home)'),
    SimplePage(pageName: 'البحث (Search)'),
    SimplePage(pageName: 'الملف الشخصي (Profile)'),
    SimplePage(pageName: 'الإعدادات (Settings)'),
  };
}


extension on MainScreenPageType {
  Widget get screen() =>
}