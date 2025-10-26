import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart' show CustomFooter, LoadStyle;

import '../shared_methods.dart';
import 'clear_text.dart';
import 'show_hide_password.dart';

abstract class UTI {
  /// [IMPORTANT] >>> don't use [GestureDetector] because it is not work on [IOS]
  static Widget unFocus({Widget? child}) => InkWell(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
    onTap: unFocusKeyboard,
    child: child,
  );

  // static Widget defaultUserIcon() => const CircleAvatar(radius: 25, backgroundColor: AppColors.colorPrimary, child: Icon(Icons.person, color: Colors.white));
  static Widget defaultUserIcon({double avatarRadios = 15}) => CircleAvatar(
    backgroundColor: const Color(0xffDFDFDF),
    radius: avatarRadios,
    child: const Icon(Icons.person, color: Colors.white, size: 30),
  );

  static Widget clearTextField(TextEditingController controller) => ClearTextFieldWidget(controller: controller);

  static Widget showHidePassword({required Function(bool isPasswordShow) onChange}) => ShowHidePasswordWidget(onChange: onChange);

  static Widget footerForLoading() => CustomFooter(
    loadStyle: LoadStyle.ShowWhenLoading,
    builder: (_, _) => const SizedBox(height: 55.0, child: Center(child: CircularProgressIndicator())),
  );

  static Widget loadingForButton({Color color = Colors.white}) =>
      SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: color, strokeWidth: 2));
}
