import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymate_tech_task/app/app.dart';
import 'package:hymate_tech_task/l10n/l10n.dart';
import 'package:hymate_tech_task/shared/shared.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  Future<void>? _splashLoader;

  @override
  void initState() {
    super.initState();

    RendererBinding.instance.deferFirstFrame();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _splashLoader ??= _loadSplash(context).whenComplete(() {
      // show Flutter Splash Screen After loading assets
      // no need for `FlutterNativeSplash.remove()` method
      RendererBinding.instance.allowFirstFrame();
    });
  }

  Future<void> _loadSplash(BuildContext context) async {
    await AssetPrecacheHelper.precacheImageAssets(context);
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      routerConfig: router.config(),
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: AppTheme.defaultMode,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,
    );
  }
}
