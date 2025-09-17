import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymate_tech_task/app/app.dart';
import 'package:hymate_tech_task/l10n/l10n.dart';
import 'package:hymate_tech_task/package_info/package_info.dart';
import 'package:hymate_tech_task/shared/shared.dart';
import 'package:settings_ui/settings_ui.dart';

@RoutePage()
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: context.l10n.settingsAppBarTitle,
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
                    tiles: [
                      SettingsTile.navigation(
                        leading: const Icon(Icons.language),
                        title: Text(context.l10n.languageAppBarTitle),
                        value: Text(
                          context.locale.getLanguageName().toUpperCase(),
                        ),
                        onPressed: (context) {
                          context.router.pushPath(
                            AppRoutes.settingsLanguageRoute,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const AppVersionColumn(),
          ],
        ),
      ),
    );
  }
}
