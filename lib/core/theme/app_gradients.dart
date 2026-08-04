import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Named gradients. Deliberately scoped: `primary` resolves to a flat
/// same-color "gradient" (both stops are Dusk Violet) so every existing
/// `Gradient`-typed call site — buttons, chat bubbles, hero cards — renders
/// as a solid brand fill rather than the two-stop violet-to-blue gradient
/// this app used to ship, without each of those call sites needing to
/// change its type from `Gradient` to `Color`. The only *visible* gradient
/// left in the app is [homeSky], reserved for the Home hero scene and
/// celebration overlays — a gradient used once, as a considered atmosphere,
/// not smeared across every interactive surface.
class AppGradients {
  const AppGradients._();

  static const LinearGradient primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.gradientStart, AppColors.gradientEnd],
  );

  static const LinearGradient homeHero = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFEDE7FE), Color(0xFFF5F5FA)],
  );

  /// The one atmospheric, multi-stop gradient in the app — a soft dawn sky
  /// behind the Home hero's companion scene and celebration overlays.
  static const LinearGradient homeSky = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF3E4F7), Color(0xFFF6EFE0), Color(0xFFE3F3EC)],
    stops: [0.0, 0.55, 1.0],
  );

  /// [homeSky]'s dark-mode counterpart — a night sky, not the pastel dawn
  /// dimmed, so the hero scene stays atmospheric rather than jarring against
  /// a dark theme.
  static const LinearGradient homeSkyDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF2B2247), Color(0xFF201A38), Color(0xFF151220)],
    stops: [0.0, 0.55, 1.0],
  );

  static LinearGradient homeSkyFor(Brightness brightness) =>
      brightness == Brightness.dark ? homeSkyDark : homeSky;

  static LinearGradient shimmer(bool isDark) => LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: isDark
            ? [const Color(0xFF262632), const Color(0xFF33333F), const Color(0xFF262632)]
            : [const Color(0xFFEDEDF4), const Color(0xFFF8F8FC), const Color(0xFFEDEDF4)],
      );
}
