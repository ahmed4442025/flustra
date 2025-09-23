import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'core/app.dart';
import 'core/config/desktop/window_config.dart';
import 'core/config/mobile/mobile_config.dart';
import 'core/constants/app_constant.dart';
import 'core/get_it/get_it.dart';
import 'core/helper/shared_methods.dart';
import 'core/localization/codegen_loader.g.dart';
import 'core/services/internet_connection/internet_cubit.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();

BuildContext? get AppContext => navigatorKey.currentContext;

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Important!

  await EasyLocalization.ensureInitialized(); // ✅ Needed for EasyLocalization

  if (isDesktop) await WindowInitializer.init(); // ✅ إعداد حجم ومكان النافذة في الويندوز

  await setupGetIt();
  InternetCubit.i;

  MobileConfig.init();

  runApp(EasyLocalization(
      assetLoader: const CodegenLoader(),
      supportedLocales: AppConstant.supportedLanguagesLocales,
      path: 'assets/translations',
      saveLocale: true,
      fallbackLocale: AppConstant.defaultLanguage.locale,
      child: const MyApp()));
}
