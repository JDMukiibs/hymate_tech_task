import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hymate_tech_task/l10n/l10n.dart';
import 'package:hymate_tech_task/shared/app_bar/default_app_bar.dart';
import 'package:hymate_tech_task/tasks/tasks.dart';

@RoutePage()
class TaskTwoPage extends StatelessWidget {
  const TaskTwoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: context.l10n.taskTwoPageAppBarTitle,
      ),
      body: const Center(
        child: TaskTwoView(),
      ),
    );
  }
}
