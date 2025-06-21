import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'core/app.dart';
import 'core/config/desktop/window_config.dart';
import 'core/get_it/get_it.dart';
import 'core/helper/shared_methods.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Important!

  await EasyLocalization.ensureInitialized(); // ✅ Needed for EasyLocalization

  if (isDesktop) await WindowInitializer.init(); // ✅ إعداد حجم ومكان النافذة في الويندوز

  setupGetIt();

  runApp(const MyApp());
}
