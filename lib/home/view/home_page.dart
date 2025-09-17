import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hymate_tech_task/app/app.dart';
import 'package:hymate_tech_task/l10n/l10n.dart';
import 'package:hymate_tech_task/shared/app_bar/default_app_bar.dart';

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
          children: <Widget>[
            Text(context.l10n.homeAppBarMessage),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.router.pushPath(AppRoutes.taskOneRoute);
              },
              child: Text(context.l10n.homePageNavigateToTaskOneButtonText),
            ),
            const SizedBox(height: 10),
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
