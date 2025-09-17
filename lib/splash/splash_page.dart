import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymate_tech_task/app/app.dart';
import 'package:hymate_tech_task/app_preferences/app_preferences.dart';
import 'package:hymate_tech_task/l10n/l10n.dart';
import 'package:hymate_tech_task/logging/logging.dart';

@RoutePage()
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkInitialRoute();
  }

  Future<void> _checkInitialRoute() async {
    await Future.delayed(const Duration(milliseconds: 1200), () => null);

    try {
      final prefsAsync =
          await ref.read(appPreferencesControllerProvider.future);

      if (prefsAsync.preferredLanguageCode != null) {
        await ref.read(localeProvider.notifier).getLastSavedLocale();
      }

      if (mounted) {
        await context.router.replacePath(AppRoutes.homeRoute);
      }
    } catch (e, st) {
      await ref.read(loggingServiceProvider).e(
            'Error during initial route checks',
            error: e,
            stackTrace: st,
          );
      if (mounted) {
        await context.router.replacePath(AppRoutes.homeRoute);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                AppAssets.appLogo,
                width: 150,
                height: 150,
              ),
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
