import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymate_tech_task/l10n/l10n.dart';
import 'package:hymate_tech_task/shared/shared.dart';
import 'package:settings_ui/settings_ui.dart';

@RoutePage()
class SelectLanguagePage extends ConsumerWidget {
  const SelectLanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColor = context.theme.colorScheme.primary;

    final currentLocale = ref.watch(localeProvider);

    final languageStateNotifier = ref.watch(localeProvider.notifier);
    const appLocales = AppLocalizations.supportedLocales;
    final languageTiles = appLocales.map((locale) {
      final isLocaleCurrentlySelected = locale == currentLocale;
      final languageName = locale.getLanguageName();

      return SettingsTile(
        title: Text(languageName),
        trailing: isLocaleCurrentlySelected
            ? Icon(Icons.done, color: primaryColor)
            : null,
        onPressed: (context) async {
          await languageStateNotifier.updateCurrentLanguage(
            locale.languageCode,
          );
        },
      );
    }).toList();

    return Scaffold(
      appBar: DefaultAppBar(
        title: context.l10n.languageAppBarTitle,
        showSettingsButton: false,
      ),
      body: Padding(
        padding: allPadding16,
        child: Column(
          children: [
            Expanded(
              child: SettingsList(
                sections: [
                  SettingsSection(
                    title: Text(context.l10n.selectLanguage),
                    tiles: languageTiles,
                  ),
                ],
              ),
            ),
            verticalMargin32,
          ],
        ),
      ),
    );
  }
}
