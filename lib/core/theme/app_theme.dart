import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'base_theme_data.dart';

final ThemeData lightTheme = generateBaseThemeData(dark: false, myColors: colorsManagerNormal);

final ThemeData darkTheme = generateBaseThemeData(dark: true, myColors: colorsManagerDark);
