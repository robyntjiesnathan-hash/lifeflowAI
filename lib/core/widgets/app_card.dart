import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import 'pressable_scale.dart';

/// Three-level elevation system, replacing a single flat shadow reused on
/// every card. Each level carries its own radius and shadow treatment so
/// depth actually communicates hierarchy — a quiet list row doesn't read
/// the same as an interactive summary card.
enum AppElevation {
  /// List rows, secondary/quiet cards.
  resting,

  /// Interactive, tappable summary cards — the ones meant to draw the eye
  /// (Daily Progress, Budget Today, Meal Plan, Habits preview).
  raised,
}

extension AppElevationX on AppElevation {
  double get radius => switch (this) {
        AppElevation.resting => AppRadii.resting,
        AppElevation.raised => AppRadii.raised,
      };

  List<BoxShadow> shadows(bool isDark) {
    final Color tint = isDark ? Colors.black : const Color(0xFF6952D6);
    return switch (this) {
      AppElevation.resting => [
          BoxShadow(color: tint.withValues(alpha: isDark ? 0.22 : 0.05), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      AppElevation.raised => [
          BoxShadow(color: tint.withValues(alpha: isDark ? 0.14 : 0.04), blurRadius: 28, offset: const Offset(0, 12)),
          BoxShadow(color: tint.withValues(alpha: isDark ? 0.28 : 0.07), blurRadius: 8, offset: const Offset(0, 2)),
        ],
    };
  }
}

/// Standard surface card. Depth is driven by [elevation] (resting by
/// default) rather than every card sharing one identical shadow.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.onTap,
    this.color,
    this.elevation = AppElevation.resting,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? color;
  final AppElevation elevation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final Widget content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? theme.cardTheme.color,
        borderRadius: BorderRadius.circular(elevation.radius),
        boxShadow: elevation.shadows(isDark),
      ),
      child: child,
    );
    if (onTap == null) return content;
    return PressableScale(
      borderRadius: BorderRadius.circular(elevation.radius),
      onTap: onTap,
      child: content,
    );
  }
}

/// A card filled with [gradient] instead of a flat surface color. Reserved
/// for the Home hero scene and celebration moments — see `AppGradients`.
class GradientHeroCard extends StatelessWidget {
  const GradientHeroCard({
    super.key,
    required this.child,
    required this.gradient,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.onTap,
    this.radius = AppRadii.raised,
  });

  final Widget child;
  final Gradient gradient;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final Widget content = Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: DefaultTextStyle.merge(
        style: const TextStyle(color: Colors.white),
        child: IconTheme.merge(data: const IconThemeData(color: Colors.white), child: child),
      ),
    );
    if (onTap == null) return content;
    return PressableScale(
      borderRadius: BorderRadius.circular(radius),
      onTap: onTap,
      child: content,
    );
  }
}

/// The "floating" elevation level — a translucent, blurred glass surface.
/// Deliberately the *only* place true glassmorphism appears in the app (the
/// Home hero scene, modals/bottom sheets, the celebration overlay); used
/// nowhere else so it stays a signature rather than wallpaper.
class FloatingGlassCard extends StatelessWidget {
  const FloatingGlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.radius = AppRadii.floating,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color glassTint = isDark ? Colors.white.withValues(alpha: 0.08) : Colors.white.withValues(alpha: 0.55);
    final Color borderTint = isDark ? Colors.white.withValues(alpha: 0.12) : Colors.white.withValues(alpha: 0.6);

    final Widget content = ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: glassTint,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: borderTint, width: 1),
            boxShadow: [
              BoxShadow(
                color: (isDark ? Colors.black : const Color(0xFF6952D6)).withValues(alpha: isDark ? 0.3 : 0.08),
                blurRadius: 32,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
    if (onTap == null) return content;
    return PressableScale(
      borderRadius: BorderRadius.circular(radius),
      onTap: onTap,
      child: content,
    );
  }
}
