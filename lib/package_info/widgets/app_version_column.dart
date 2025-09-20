import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymate_tech_task/l10n/l10n.dart';
import 'package:hymate_tech_task/package_info/package_info.dart';
import 'package:hymate_tech_task/shared/layout/layout.dart';

class AppVersionColumn extends ConsumerWidget {
  const AppVersionColumn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfo = ref.watch(packageInfoProvider);
    final appName = packageInfo.appName;
    final appVersion = packageInfo.appVersion;
    final deviceWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: deviceWidth,
      child: Padding(
        padding: allPadding8,
        child: Column(
          children: [
            Text(appName),
            Text(context.l10n.appVersionLabel(appVersion)),
          ],
        ),
      ),
    );
  }
}
