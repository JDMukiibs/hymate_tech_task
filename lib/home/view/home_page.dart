import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hymate_tech_task/app/app.dart';
import 'package:hymate_tech_task/l10n/l10n.dart';
import 'package:hymate_tech_task/shared/app_bar/default_app_bar.dart';
import 'package:hymate_tech_task/shared/layout/layout.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: context.l10n.homeAppBarTitle,
        showBackButton: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                AppAssets.appLogo,
                width: 256,
                height: 256,
              ),
            ),
            verticalMargin24,
            Text(context.l10n.homeAppBarMessage),
            const Gap(20),
            ElevatedButton(
              onPressed: () {
                context.router.pushPath(AppRoutes.taskOneRoute);
              },
              child: Text(context.l10n.homePageNavigateToTaskOneButtonText),
            ),
            const Gap(10),
            ElevatedButton(
              onPressed: () {
                context.router.pushPath(AppRoutes.taskTwoRoute);
              },
              child: Text(context.l10n.homePageNavigateToTaskTwoButtonText),
            ),
          ],
        ),
      ),
    );
  }
}
