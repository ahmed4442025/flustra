import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flustra_template/core/config/app_settings/app_settings_cubit.dart';
import 'package:flustra_template/core/constants/app_constant.dart';
import 'package:flutter/material.dart';

import 'helper/base_cubit/block_builder_widget.dart';
import 'router/app_router.dart';

final _botToastBuilder = BotToastInit();  //1. call BotToastInit

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlockBuilderWidget<AppSettingsCubit, AppSettingsCubitTypes>(
      types: const [AppSettingsCubitTypes.theme],
      showOnlyBodyInAllCases: true,
      body: (_) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        builder: (_, child) {
          child = _botToastBuilder(context,child);
          return child;
        },

        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: AppConstant.appName,
        theme: AppSettingsCubit.i.themeController.currentTheme,
        routerConfig: routerConfig,
      ),
    );
  }
}
