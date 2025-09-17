import 'package:flutter/widgets.dart';

import 'package:hymate_tech_task/shared/layout/layout.dart';

/// Signature for the individual builders (`extraSmall`, `small`, `medium`,
/// `large`).
typedef ResponsiveLayoutWidgetBuilder = Widget Function(BuildContext, Widget?);

/// {@template responsive_layout_builder}
/// A wrapper around [LayoutBuilder] which exposes builders for
/// various responsive breakpoints.
/// {@endtemplate}
class ResponsiveLayoutBuilder extends StatelessWidget {
  /// {@macro responsive_layout_builder}
  const ResponsiveLayoutBuilder({
    required this.extraSmall,
    required this.small,
    required this.medium,
    required this.large,
    super.key,
    this.child,
  });

  /// [ResponsiveLayoutWidgetBuilder] for extraSmall layout.
  final ResponsiveLayoutWidgetBuilder extraSmall;

  /// [ResponsiveLayoutWidgetBuilder] for small layout.
  final ResponsiveLayoutWidgetBuilder small;

  /// [ResponsiveLayoutWidgetBuilder] for medium layout.
  final ResponsiveLayoutWidgetBuilder medium;

  /// [ResponsiveLayoutWidgetBuilder] for large layout.
  final ResponsiveLayoutWidgetBuilder large;

  /// Optional child widget builder based on the current layout size
  /// which will be passed to the `small`, `medium` and `large` builders
  /// as a way to share/optimize shared layout.
  final Widget Function(ScreenSizeBreakpoint currentSize)? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;

        if (screenWidth <= ScreenSizeBreakpoint.xs.breakpoint) {
          return extraSmall(context, child?.call(ScreenSizeBreakpoint.xs));
        }
        if (screenWidth <= ScreenSizeBreakpoint.s.breakpoint) {
          return small(context, child?.call(ScreenSizeBreakpoint.s));
        }
        if (screenWidth <= ScreenSizeBreakpoint.m.breakpoint) {
          return medium(context, child?.call(ScreenSizeBreakpoint.m));
        }
        if (screenWidth <= ScreenSizeBreakpoint.l.breakpoint) {
          return large(context, child?.call(ScreenSizeBreakpoint.l));
        }

        return large(context, child?.call(ScreenSizeBreakpoint.l));
      },
    );
  }
}
