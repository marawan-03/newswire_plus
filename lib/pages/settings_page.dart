import 'package:flutter/material.dart';
import '../components/theme_preview_card.dart';
import '../controllers/font_controller.dart';
import '../controllers/language_controller.dart';
import '../controllers/theme_controller.dart';
import '../logic/app_strings.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.headlineMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(AppStrings.of(context, 'theme'), style: titleStyle),
          ),
          const SizedBox(height: 12),
          ListenableBuilder(
            listenable: themeController,
            builder: (context, _) => Row(
              children: [
                Expanded(
                  child: ThemePreviewCard(
                    mode: ThemeMode.system,
                    label: AppStrings.of(context, 'system'),
                    selected: themeController.mode == ThemeMode.system,
                    onTap: () => themeController.setMode(ThemeMode.system),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ThemePreviewCard(
                    mode: ThemeMode.light,
                    label: AppStrings.of(context, 'light'),
                    selected: themeController.mode == ThemeMode.light,
                    onTap: () => themeController.setMode(ThemeMode.light),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ThemePreviewCard(
                    mode: ThemeMode.dark,
                    label: AppStrings.of(context, 'dark'),
                    selected: themeController.mode == ThemeMode.dark,
                    onTap: () => themeController.setMode(ThemeMode.dark),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(AppStrings.of(context, 'fontSize'), style: titleStyle),
          ),
          const SizedBox(height: 12),
          ListenableBuilder(
            listenable: fontController,
            builder: (context, _) => SegmentedButton<FontSizeOption>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(
                  value: FontSizeOption.small,
                  label: Text('Aa', style: TextStyle(fontSize: 12)),
                ),
                ButtonSegment(
                  value: FontSizeOption.medium,
                  label: Text('Aa', style: TextStyle(fontSize: 16)),
                ),
                ButtonSegment(
                  value: FontSizeOption.large,
                  label: Text('Aa', style: TextStyle(fontSize: 22)),
                ),
              ],
              selected: {fontController.size},
              onSelectionChanged: (s) => fontController.setSize(s.first),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(AppStrings.of(context, 'language'), style: titleStyle),
          ),
          const SizedBox(height: 12),
          Material(
            color: Theme.of(context).colorScheme.primaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Theme.of(context).colorScheme.outline),
            ),
            clipBehavior: Clip.antiAlias,
            child: RadioGroup<String>(
              groupValue: Localizations.localeOf(context).languageCode,
              onChanged: (v) => languageController.setLanguage(v!),
              child: Column(
                children: [
                  Material(
                    shape: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    color: Colors.transparent,
                    child: const RadioListTile<String>(
                      value: 'en',
                      title: Text('English'),
                    ),
                  ),
                  Material(
                    shape: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    color: Colors.transparent,
                    child: const RadioListTile<String>(
                      value: 'ar',
                      title: Text('العربية'),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}