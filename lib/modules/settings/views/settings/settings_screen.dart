import 'package:easy_localization/easy_localization.dart';
import 'package:flustra_template/core/config/app_settings/app_settings_cubit.dart';
import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/color.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/base_cubit/block_builder_widget.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flutter/material.dart';

import '../../widgets/language_selector_widget.dart';
import '../../widgets/profile_card_widget.dart';
import '../../widgets/settings_group_widget.dart';
import '../../widgets/settings_tile_widget.dart';
import '../../widgets/theme_selector_widget.dart';
import 'settings_view_model.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const String name = AppRoutes.settingsScreen;

  static void navigateToMe() => navigateTo(name);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // -------------------------- Controller & State -------------------------- //
  late final SettingsViewModel _viewModel = SettingsViewModel();

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(_refresh);
    _viewModel.init();
  }

  @override
  void dispose() {
    _viewModel.removeListener(_refresh);
    _viewModel.dispose();
    super.dispose();
  }

  // -------------------------- Build -------------------------- //
  @override
  Widget build(BuildContext context) {
    context.locale; // Register dependency on EasyLocalization to rebuild when language changes
    return BlockBuilderWidget<AppSettingsCubit, AppSettingsCubitTypes>(
      types: const [AppSettingsCubitTypes.theme],
      showOnlyBodyInAllCases: true,
      body: (_) => Scaffold(
        backgroundColor: AppColors.surface,
        body: SafeArea(child: _buildBody()),
      ),
    );
  }

  // --------------------------[ Body ]-------------------------- //
  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: Dimensions.paddingScreen, vertical: Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------------------------- Title Header -------------------------- //
          _buildTitleHeader(),
          const SizedBox(height: Dimensions.paddingSizeLarge),

          // -------------------------- Profile Card -------------------------- //
          const ProfileCardWidget(),
          const SizedBox(height: Dimensions.paddingSizeExtraLarge),

          // -------------------------- Preferences Section -------------------------- //
          _buildPreferencesSection(),
          const SizedBox(height: Dimensions.paddingSizeOverLarge),

          // -------------------------- Developer Section -------------------------- //
          _buildDeveloperSection(),
          const SizedBox(height: Dimensions.paddingSizeOverLarge),

          // -------------------------- Account Destruct Button -------------------------- //
          if (_viewModel.amILogin) ...[_buildDeleteAccountButton(), const SizedBox(height: Dimensions.paddingScreen)],

          // -------------------------- Auth Button (Log In / Log Out) -------------------------- //
          _buildAuthButton(),
          const SizedBox(height: Dimensions.paddingSizeOverLarge),

          // -------------------------- Footer Version -------------------------- //
          _buildFooter(),
        ],
      ),
    );
  }

  // --------------------------[ Title Header ]-------------------------- //
  Widget _buildTitleHeader() {
    return Text(
      AppStrings.settings.tx(),
      style: AppTextStyle.displaySmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.onSurface),
    );
  }

  // --------------------------[ Preferences Section ]-------------------------- //
  Widget _buildPreferencesSection() {
    return SettingsGroupWidget(
      title: AppStrings.preferences.tx().toUpperCase(),
      items: [
        SettingsTileWidget(
          icon: Icons.language_outlined,
          iconColor: AppColors.primary,
          iconBgColor: AppColors.primaryTint,
          title: AppStrings.language.tx(),
          subtitle: context.locale.languageCode.toUpperCase(),
          trailing: const LanguageSelectorWidget(),
        ),
        SettingsTileWidget(
          icon: Icons.dark_mode_outlined,
          iconColor: AppColors.info,
          iconBgColor: AppColors.infoTint,
          title: AppStrings.theme.tx(),
          subtitle: AppColors.isDark ? AppStrings.darkMode.tx() : AppStrings.lightMode.tx(),
          trailing: const ThemeSelectorWidget(),
        ),
        SettingsTileWidget(
          icon: Icons.notifications_outlined,
          iconColor: AppColors.warning,
          iconBgColor: AppColors.warningTint,
          title: AppStrings.notifications.tx(),
          subtitle: AppStrings.notificationsDesc.tx(),
          onTap: _viewModel.onNotificationsTap,
        ),
        SettingsTileWidget(
          icon: Icons.wallet_outlined,
          iconColor: AppColors.success,
          iconBgColor: AppColors.accentTint,
          title: AppStrings.billing.tx(),
          subtitle: AppStrings.billingDesc.tx(),
          onTap: _viewModel.onBillingTap,
        ),
      ],
    );
  }

  // --------------------------[ Delete Account Button ]-------------------------- //
  Widget _buildDeleteAccountButton() {
    return Center(
      child: InkWell(
        onTap: _viewModel.onDeleteAccount,
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingScreen, vertical: Dimensions.paddingSizeSmall),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete_forever, color: AppColors.error.withOpacityEX(0.7)),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Text(
                AppStrings.deleteAccount.tx(),
                style: AppTextStyle.bodyMedium.copyWith(color: AppColors.error.withOpacityEX(0.7), fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --------------------------[ Auth Button ]-------------------------- //
  Widget _buildAuthButton() {
    final isLoggedIn = _viewModel.amILogin;
    final color = isLoggedIn ? AppColors.error : AppColors.primary;
    final icon = isLoggedIn ? Icons.logout : Icons.login;
    final bgTint = isLoggedIn ? AppColors.errorTint : AppColors.primaryTint;

    return InkWell(
      onTap: isLoggedIn ? _viewModel.onLogout : _viewModel.onLogin,
      borderRadius: BorderRadius.circular(Dimensions.radiusMedium),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsetsDirectional.symmetric(vertical: Dimensions.paddingScreen),
        decoration: BoxDecoration(
          color: bgTint,
          borderRadius: BorderRadius.circular(Dimensions.radiusMedium),
          border: Border.all(color: color.withOpacityEX(0.2), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            Text(
              isLoggedIn ? AppStrings.logout.tx() : AppStrings.login.tx(),
              style: AppTextStyle.titleSmall.copyWith(color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------[ Developer Section ]-------------------------- //
  Widget _buildDeveloperSection() {
    return SettingsGroupWidget(
      title: AppStrings.developerOptions.tx().toUpperCase(),
      items: [
        SettingsTileWidget(
          icon: Icons.vpn_lock_outlined,
          iconColor: AppColors.primary,
          iconBgColor: AppColors.primaryTint,
          title: AppStrings.proxy.tx(),
          subtitle: AppStrings.proxyDesc.tx(),
          onTap: _viewModel.onProxyTap,
        ),
        SettingsTileWidget(
          icon: Icons.color_lens_outlined,
          iconColor: AppColors.success,
          iconBgColor: AppColors.accentTint,
          title: AppStrings.themeShowcase.tx(),
          subtitle: AppStrings.themeShowcaseDesc.tx(),
          onTap: _viewModel.onThemeShowcaseTap,
        ),
      ],
    );
  }

  // --------------------------[ Footer Version ]-------------------------- //
  Widget _buildFooter() {
    return Center(
      child: Text(AppStrings.footerBuild.tx(), style: AppTextStyle.bodySmall.copyWith(color: AppColors.onSurfaceVariant.withOpacityEX(0.7))),
    );
  }
}
