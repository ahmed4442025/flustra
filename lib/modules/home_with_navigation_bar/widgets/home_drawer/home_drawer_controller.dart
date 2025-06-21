// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// class DrawerViewModel {
//   final Function() _refresh;
//
//   DrawerViewModel(this._refresh);
//
//   late List<SettingInfo> listSettings = [
//     SettingInfo(LocaleKeys.shops.tr(), Icons.shopping_basket_outlined, onTapShopHome),
//     SettingInfo(LocaleKeys.savedSearch.tr(), Icons.bookmark_rounded, onTapSavedSearch),
//     SettingInfo(LocaleKeys.favorite.tr(), Icons.favorite, onTapFav),
//     SettingInfo(LocaleKeys.chat.tr(), CupertinoIcons.chat_bubble_2_fill, onTapChat),
//     SettingInfo(LocaleKeys.addAds.tr(), Icons.add_comment_sharp, onTapAddAds),
//     SettingInfo(LocaleKeys.language.tr(), Icons.language, onTapLanguage),
//     if(CloneSettings.showCurrencyScreenInDrawer)SettingInfo(LocaleKeys.currency.tr(), Icons.money, onTapCurrency),
//     SettingInfo(LocaleKeys.contactUs.tr(), Icons.contact_phone, onTapContactUs),
//     if (loginResponse.isHaveToken) SettingInfo(LocaleKeys.logout.tr(), Icons.logout, onTapLogout),
//     if (loginResponse.isHaveToken) SettingInfo(LocaleKeys.deleteAccount.tr(), Icons.delete_forever, onTapDelete),
//     if (!loginResponse.isHaveToken) SettingInfo(LocaleKeys.login.tr(), Icons.login, onTapLogin),
//   ];
//
//   // ===================== privet =====================
//   // void _openProfile() => navigateTo(context: _context, widget: PersonalDataScreen());
//   // void _openProfile() => navigateTo(context: _context, widget: const UpdateProfileV2());
//   void _openProfile() => Navigator.of(_context).push(MaterialPageRoute(builder: (context) => const UpdateProfileV2())).then((value) => _refresh());
//
//   void _checkIfLoginOr(Function() orVoid){
//     if (loginResponse.isNotHaveToken) {
//       showDialogUMustLoginIfNotLogin();
//       return;
//     }
//     orVoid();
//   }
//
//   void _checkIfLoginOrAndPackage(Function() orVoid){
//     if (loginResponse.isNotHaveToken) {
//       showDialogUMustLoginIfNotLogin();
//       return;
//     }
//     if(AppStrings.isHavePackage == false){
//       showDialog<void>(context: navigatorKey.currentState!.context,
//         builder: (context) {
//           return AlertPackageUser(
//             namePaymentType: LocaleKeys.newPackageForAdvertisement.tr(),);
//         },);
//     }else {
//       print('userInfoResponse userInfoResponse ${AppStrings.isHavePackage}');
//       print('userInfoResponse userInfoResponse ${AppStrings.packageName}');
//       print('userInfoResponse userInfoResponse ${AppStrings.packageId}');
//       orVoid();
//     }
//
//   }
//
// }
//
// class SettingInfo {
//   String name;
//   IconData icon;
//   Function()? onTap;
//
//   SettingInfo(this.name, this.icon, [this.onTap]);
// }
