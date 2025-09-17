import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder<T> optionsBuilder,
  Widget? contentWidgetOverride,
}) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final options = optionsBuilder();

  return showDialog<T?>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
        content: contentWidgetOverride ??
            Text(
              content,
              style: theme.textTheme.bodyMedium,
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: theme.cardColor,
        elevation: 3,
        actions: options.keys.map(
          (optionTitle) {
            final value = options[optionTitle];

            return TextButton(
              onPressed: () {
                if (value != null) {
                  if (value is Function) {
                    value.call();
                  } else {
                    context.router.pop(value);
                  }
                } else {
                  context.router.pop();
                }
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                optionTitle,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: colorScheme.onSurface,
                ),
              ),
            );
          },
        ).toList(),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      );
    },
  );
}

Future<T?> showPersistentGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder<T> optionsBuilder,
  Widget? contentWidgetOverride,
}) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final options = optionsBuilder();

  return showDialog<T?>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
        content: contentWidgetOverride ??
            Text(
              content,
              style: theme.textTheme.bodyMedium,
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: theme.cardColor,
        elevation: 3,
        actions: options.keys.map(
          (optionTitle) {
            final value = options[optionTitle];

            return TextButton(
              onPressed: () {
                if (value != null) {
                  if (value is Function) {
                    value.call();
                  } else {
                    context.router.pop(value);
                  }
                } else {
                  context.router.pop();
                }
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                optionTitle,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: colorScheme.onSurface,
                ),
              ),
            );
          },
        ).toList(),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      );
    },
  );
}
