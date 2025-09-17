import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hymate_tech_task/app/app.dart';
import 'package:hymate_tech_task/shared/shared.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    required this.title,
    super.key,
    this.height = kToolbarHeight,
    this.centerTitle = true,
    this.showBackButton = true,
    this.showSettingsButton = true,
    this.additionalActions,
  });

  final double height;
  final String title;
  final bool centerTitle;
  final bool showBackButton;
  final bool showSettingsButton;
  final List<Widget>? additionalActions;

  @override
  Widget build(BuildContext context) {
    final componentColor =
        context.theme.colorScheme.brightness == Brightness.light
            ? context.theme.colorScheme.onPrimary
            : context.theme.colorScheme.onSurface;
    return AppBar(
      centerTitle: centerTitle,
      leading: Visibility(
        visible: showBackButton,
        child: Center(
          child: ClipOval(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => context.router.pop(),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: componentColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      title: Text(
        title,
        style: context.theme.primaryTextTheme.headlineLarge?.copyWith(
          color: componentColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        if (additionalActions != null) ...?additionalActions,
        Visibility(
          visible: showSettingsButton,
          child: IconButton(
            icon: Icon(
              Icons.settings,
              color: componentColor,
            ),
            onPressed: () => context.router.pushPath(
              AppRoutes.settingsRoute,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
