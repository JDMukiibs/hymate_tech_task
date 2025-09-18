import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hymate_tech_task/l10n/l10n.dart';
import 'package:hymate_tech_task/shared/app_bar/default_app_bar.dart';
import 'package:hymate_tech_task/tasks/view/task_one_view.dart';

@RoutePage()
class TaskOnePage extends StatelessWidget {
  const TaskOnePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: context.l10n.taskOnePageAppBarTitle,
      ),
      body: const Center(
        child: TaskOneView(),
      ),
    );
  }
}
