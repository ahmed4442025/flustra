import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flustra_template/core/constants/app_constant.dart';
import 'package:flustra_template/core/localization/codegen_loader.g.dart';
import 'package:flustra_template/core/theme/theme_controller.dart';

import 'router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      assetLoader: const CodegenLoader(),
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: StreamBuilder(
              stream: themeController.themeStream,
              builder: (context, asyncSnapshot) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  title: AppConstant.appName,
                  theme: themeController.currentTheme,
                  routerConfig: routerConfig,
                );
              }),
        ),
      ),
    );
  }
}
