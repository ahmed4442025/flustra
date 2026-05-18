import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_defults.dart';
import '../../../../core/helper/widgets/image_asset_widget.dart';
import '../../../../core/localization/app_strings_localizations.dart';
import '../../../../core/localization/localization_supported_data.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/router/route_help_methods.dart';
import 'language_selection_view_model.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  static const String name = AppRoutes.languageSelectionScreen;

  static void navigateToMe() => navigateTo(name);

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  late final LanguageSelectionViewModel _viewModel = LanguageSelectionViewModel();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton(), title: Text(AppStrings.chooseLanguage.tx())),
      body: _buildBody(),
    );
  }

  // --------------------------[ Body ]-------------------------- //
  Widget _buildBody() {
    final languages = AppLocalizationController.supportedLanguagesMap.values.toList();
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: languages.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final lang = languages[index];
        final isSelected = lang == _viewModel.selectedLanguage;
        return _buildLanguageItem(lang, isSelected);
      },
    );
  }

  // --------------------------[ LanguageItem ]-------------------------- //
  Widget _buildLanguageItem(LanguageOption lang, bool isSelected) {
    return InkWell(
      onTap: () => _viewModel.onLanguageSelected(lang),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? AppColors.primary : AppColors.outline, width: isSelected ? 2 : 1),
        ),
        child: Row(
          children: [
            ImageAssetWidget(assetPath: lang.flagAsset, width: 32, height: 32, fit: BoxFit.cover),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(lang.nameWithTr(), style: AppTextStyle.titleMedium),
                  Text(lang.nameRaw, style: AppTextStyle.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)),
                ],
              ),
            ),
            Radio<LanguageOption>(
              value: lang,
              groupValue: _viewModel.selectedLanguage,
              onChanged: (val) {
                if (val != null) _viewModel.onLanguageSelected(val);
              },
              activeColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
