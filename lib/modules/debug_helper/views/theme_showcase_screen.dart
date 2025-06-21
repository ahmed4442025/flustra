import 'package:flutter/material.dart';
import 'package:pripo/core/constants/app_defults.dart';
import 'package:pripo/core/theme/theme_controller.dart';

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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.background,
        title: const Text('Theme Showcase'),
        actions: [
          Switch(
            value: isDark,
            onChanged: (value) {
              themeController.changeTheme(mode: isDark ? ThemeModeType.dark : ThemeModeType.light);
              setState(() => isDark = value);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Typography Preview
          Text(
            "123456",
            style: TextStyle(),
          ),
          Text("Text Theme", style: AppTextStyle.displayLarge),
          const SizedBox(height: 8),
          _buildTextSample("displayLarge", AppTextStyle.displayLarge),
          _buildTextSample("displayMedium", AppTextStyle.displayMedium),
          _buildTextSample("displaySmall", AppTextStyle.displaySmall),
          _buildTextSample("bodyLarge", AppTextStyle.bodyLarge),
          _buildTextSample("bodyMedium", AppTextStyle.bodyMedium),
          _buildTextSample("bodySmall", AppTextStyle.bodySmall),

          const Divider(height: 32),

          // Inputs
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Text Field",
              hintText: "Enter text...",
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            enabled: false,
            decoration: const InputDecoration(
              labelText: "Text Field",
              hintText: "Enter text...",
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: dropdownValue,
            items: ['User 1', 'User 2']
                .map((e) => DropdownMenuItem(
                    value: e,
                    child: Row(
                      children: [
                        Text(e, style: AppTextStyle.bodyLarge),
                      ],
                    )))
                .toList(),
            onChanged: (val) => setState(() => dropdownValue = val!),
            decoration: const InputDecoration(labelText: "Dropdown"),
          ),

          const Divider(height: 32),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text("Elevated")),
              OutlinedButton(onPressed: () {}, child: const Text("Outlined")),
              TextButton(onPressed: () {}, child: const Text("Text")),
            ],
          ), // Buttons
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                  Text(
                    "This is a card using cardBackground color.",
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),

          const Divider(height: 32),

          // Toggles
          Row(
            children: [
              Switch(
                value: isSwitched,
                onChanged: (val) => setState(() => isSwitched = val),
              ),
            ],
          ),

          const Divider(height: 32),

          // Colors
          Text("Color Palette", style: theme.textTheme.displayMedium),
          const Divider(height: 32),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildColorTile("primary", theme.colorScheme.primary),
              _buildColorTile("secondary", theme.colorScheme.secondary),
              _buildColorTile("secondary 3", AppColors.accentOrange),
              _buildColorTile("background", theme.colorScheme.surface),
              _buildColorTile("error", theme.colorScheme.error),
              _buildColorTile("textPrimary", theme.textTheme.bodyLarge?.color ?? Colors.black),
              _buildColorTile("textSecondary", theme.textTheme.bodyMedium?.color ?? Colors.grey),
              _buildColorTile("divider", theme.dividerColor),
              _buildColorTile("card", theme.cardColor),
              _buildColorTile(
                  "border (input)",
                  theme.inputDecorationTheme.enabledBorder is OutlineInputBorder
                      ? (theme.inputDecorationTheme.enabledBorder as OutlineInputBorder).borderSide.color
                      : Colors.transparent),
              _buildColorTile("disabledBorder", theme.disabledColor),
              _buildColorTile("checkbox", theme.checkboxTheme.fillColor?.resolve({WidgetState.selected}) ?? Colors.grey),
              _buildColorTile("switch", theme.switchTheme.thumbColor?.resolve({WidgetState.selected}) ?? Colors.grey),
            ],
          ),
        ],
      ),
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
          Text(
            "FontSize: ${style.fontSize?.toInt()} | Weight: ${style.fontWeight}",
            style: const TextStyle(fontSize: 12),
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
