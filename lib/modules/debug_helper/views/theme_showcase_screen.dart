import 'package:flustra_template/core/config/app_settings/app_settings_cubit.dart';
import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/localization/localization_supported_data.dart';
import 'package:flustra_template/core/theme/app_theme.dart';
import 'package:flustra_template/modules/home_with_navigation_bar/views/home_navigation_bar/home_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_constant.dart';

class ThemeShowcaseScreen extends StatefulWidget {
  const ThemeShowcaseScreen({super.key});

  @override
  State<ThemeShowcaseScreen> createState() => _ThemeShowcaseScreenState();
}

class _ThemeShowcaseScreenState extends State<ThemeShowcaseScreen> {
  bool isDark = false;
  bool isChecked = false;
  bool isOn = false;
  bool isSwitched = false;

  String dropdownValue = 'User 1';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.surface, title: const Text('Theme Showcase')),
      floatingActionButton: FloatingActionButton(
        heroTag: "add theme",
        child: const Icon(Icons.add),
        onPressed: () {
          // navigateTo(AppRoutes.homeScreenWithNavigationBar,arguments: "123");
          HomeScreenWithNavigationBar.navigateToMe(HomeScreenWithNavigationBarData(initialPage: MainScreenPageType.settings));
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDropdownThemeMode(),
          const SizedBox(height: 8),
          _buildDropdownLanguage(),
          const SizedBox(height: 8),

          // Typography Preview
          Text("Text Theme", style: AppTextStyle.displayLarge),
          const SizedBox(height: 8),
          _buildTextSample("displayLarge", AppTextStyle.displayLarge),
          _buildTextSample("displayMedium", AppTextStyle.displayMedium),
          _buildTextSample("displaySmall", AppTextStyle.displaySmall),

          _buildTextSample("titleLarge", AppTextStyle.titleLarge),
          _buildTextSample("titleMedium", AppTextStyle.titleMedium),
          _buildTextSample("titleSmall", AppTextStyle.titleSmall),

          _buildTextSample("bodyLarge", AppTextStyle.bodyLarge),
          _buildTextSample("bodyMedium", AppTextStyle.bodyMedium),
          _buildTextSample("bodySmall", AppTextStyle.bodySmall),

          const Divider(height: 32),

          // Inputs
          TextFormField(
            decoration: const InputDecoration(labelText: "Text Field", hintText: "Enter text..."),
          ),
          const SizedBox(height: 16),
          TextFormField(
            enabled: false,
            decoration: const InputDecoration(labelText: "Text Field", hintText: "Enter text..."),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: dropdownValue,
            items: ['User 1', 'User 2']
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Row(children: [Text(e, style: AppTextStyle.bodyLarge)]),
                  ),
                )
                .toList(),
            onChanged: (val) => setState(() => dropdownValue = val!),
            decoration: const InputDecoration(labelText: "Dropdown"),
          ),

          const Divider(height: 32),

          // -------------------------- Buttons --------------------------
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton(onPressed: () {}, child: const Text("FilledButton")),
              ElevatedButton(onPressed: () {}, child: const Text("Elevated")),
              OutlinedButton(onPressed: () {}, child: const Text("Outlined")),
              TextButton(onPressed: () {}, child: const Text("Text")),
              Divider(height: 32),
              FilledButton(onPressed: null, child: const Text("FilledButton")),
              ElevatedButton(onPressed: null, child: const Text("Elevated")),
              OutlinedButton(onPressed: null, child: const Text("Outlined")),
              TextButton(onPressed: null, child: const Text("Text")),
            ],
          ),

          const Divider(height: 32),

          // Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text("Card Title", style: theme.textTheme.displaySmall),
                  const SizedBox(height: 8),
                  Text("This is a card using cardBackground color.", style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ),

          const Divider(height: 32),

          // Toggles
          Row(
            children: [Switch(value: isSwitched, onChanged: (val) => setState(() => isSwitched = val))],
          ),

          const Divider(height: 32),

          Text("Brand / Primary & Secondary", style: AppTextStyle.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildColorTile("primary", AppColors.primary),
              _buildColorTile("primaryHover", AppColors.primaryHover),
              _buildColorTile("primaryTint", AppColors.primaryTint),
              _buildColorTile("primaryTint2", AppColors.primaryTint2),
              _buildColorTile("secondary", AppColors.secondary),
              _buildColorTile("secondaryTint", AppColors.secondaryTint),
              _buildColorTile("onPrimary", AppColors.onPrimary),
            ],
          ),
          const SizedBox(height: 24),

          Text("Surfaces & Containers", style: AppTextStyle.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildColorTile("surface", AppColors.surface),
              _buildColorTile("surfaceContainer", AppColors.surfaceContainer),
              _buildColorTile("surfaceContainerHigh", AppColors.surfaceContainerHigh),
            ],
          ),
          const SizedBox(height: 24),

          Text("Content / On-Surfaces", style: AppTextStyle.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [_buildColorTile("onSurface", AppColors.onSurface), _buildColorTile("onSurfaceVariant", AppColors.onSurfaceVariant)],
          ),
          const SizedBox(height: 24),

          Text("Outline & Borders", style: AppTextStyle.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [_buildColorTile("outline", AppColors.outline), _buildColorTile("outlineVariant", AppColors.outlineVariant)],
          ),
          const SizedBox(height: 24),

          Text("States & Semantic Statuses", style: AppTextStyle.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildColorTile("disabledElement", AppColors.disabledElement),
              _buildColorTile("accent", AppColors.accent),
              _buildColorTile("accentDeep", AppColors.accentDeep),
              _buildColorTile("accentTint", AppColors.accentTint),
              _buildColorTile("error", AppColors.error),
              _buildColorTile("errorTint", AppColors.errorTint),
              _buildColorTile("success", AppColors.success),
              _buildColorTile("warning", AppColors.warning),
              _buildColorTile("warningTint", AppColors.warningTint),
              _buildColorTile("info", AppColors.info),
              _buildColorTile("infoTint", AppColors.infoTint),
              _buildColorTile("cold", AppColors.cold),
              _buildColorTile("coldTint", AppColors.coldTint),
              _buildColorTile("hint", AppColors.hint),
              _buildColorTile("overlay", AppColors.overlay),
            ],
          ),
        ],
      ),
    );
  }

  // -------------------------- dropdown theme mode --------------------------
  Widget _buildDropdownThemeMode() {
    return DropdownButtonFormField<ThemeModeType>(
      value: AppSettingsCubit.i.themeController.mode,
      items: ThemeModeType.values
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Row(
                children: [
                  CircleAvatar(backgroundColor: e.getColors().primary, radius: 12),
                  SizedBox(width: 5),
                  Text(e.name, style: AppTextStyle.bodyLarge),
                ],
              ),
            ),
          )
          .toList(),
      onChanged: (val) => AppSettingsCubit.i.changeTheme(val!),
      decoration: const InputDecoration(labelText: "Theme Mode"),
    );
  }

  // -------------------------- dropdown language --------------------------
  Widget _buildDropdownLanguage() {
    return DropdownButtonFormField<LanguageOption>(
      padding: EdgeInsets.all(0),
      value: AppLocalizationController.currentLanguage,
      items: AppConstant.supportedLanguagesModels
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Row(
                children: [
                  SvgPicture.asset(e.flagAsset, width: 20, height: 20),
                  SizedBox(width: 5),
                  Text("${e.nameWithTr()} - ", style: AppTextStyle.titleMedium),
                  SizedBox(width: 5),
                  Text(e.nameRaw, style: AppTextStyle.bodySmall),
                ],
              ),
            ),
          )
          .toList(),
      onChanged: (val) => AppLocalizationController.changeLanguage(val!),
      decoration: const InputDecoration(labelText: "Theme Mode"),
    );
  }

  Widget _buildTextSample(String name, TextStyle? style) {
    if (style == null) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: style),
          Row(
            children: [
              CircleAvatar(backgroundColor: style.color, radius: 5),
              SizedBox(width: 8),
              Text(
                "FontSize: ${style.fontSize?.toInt()} | Weight: ${style.fontWeight} | FontColor: ${style.color?.toARGB32().toRadixString(16).toUpperCase()}",
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorTile(String name, Color color) {
    return SizedBox(
      width: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black12),
            ),
          ),
          const SizedBox(height: 4),
          Text(name, style: AppTextStyle.bodySmall.copyWith(fontWeight: FontWeight.bold)),
          Text("#${color.toARGB32().toRadixString(16)}", style: AppTextStyle.bodySmall),
        ],
      ),
    );
  }
}
