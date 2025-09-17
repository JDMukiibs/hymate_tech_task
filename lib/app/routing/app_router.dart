import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymate_tech_task/app/app.dart';
import 'package:hymate_tech_task/home/home.dart';
import 'package:hymate_tech_task/settings/settings.dart';
import 'package:hymate_tech_task/splash/splash_page.dart';
import 'package:hymate_tech_task/tasks/tasks.dart';

part 'app_router.gr.dart';

final appRouterProvider = Provider(
  (ref) => AppRouter(),
);

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: AppRoutes.splashRoute,
          page: SplashRoute.page,
          initial: true,
        ),
        AutoRoute(path: AppRoutes.homeRoute, page: HomeRoute.page),
        AutoRoute(
          path: AppRoutes.taskOneRoute,
          page: TaskOneRoute.page,
        ),
        AutoRoute(
          path: AppRoutes.taskTwoRoute,
          page: TaskTwoRoute.page,
        ),
        AutoRoute(
          path: AppRoutes.settingsRoute,
          page: SettingsRoute.page,
        ),
        AutoRoute(
          path: AppRoutes.settingsLanguageRoute,
          page: SelectLanguageRoute.page,
        ),
      ];
}
