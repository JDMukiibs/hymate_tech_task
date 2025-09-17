import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hymate_tech_task/l10n/l10n.dart';
import 'package:hymate_tech_task/shared/app_bar/default_app_bar.dart';

@RoutePage()
class TaskTwoPage extends StatelessWidget {
  const TaskTwoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: context.l10n.taskTwoPageAppBarTitle,
      ),
      body: Center(
        child: Text(context.l10n.taskTwoPagePlaceholderMessage),
      ),
    );
  }
}
