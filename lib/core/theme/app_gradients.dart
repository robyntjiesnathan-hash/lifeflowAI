import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Named gradients for hero surfaces (FAB, primary buttons, AI Coach card,
/// budget hero card), matching the purple-to-blue brand gradient used
/// throughout the reference design.
class AppGradients {
  const AppGradients._();

  static const LinearGradient primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.gradientStart, AppColors.gradientEnd],
  );

  static const LinearGradient aiCoach = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7C5CFC), Color(0xFF5B7CFA)],
  );

  static const LinearGradient homeHero = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFEDE7FE), Color(0xFFF5F5FA)],
  );

  static LinearGradient shimmer(bool isDark) => LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: isDark
            ? [const Color(0xFF262632), const Color(0xFF33333F), const Color(0xFF262632)]
            : [const Color(0xFFEDEDF4), const Color(0xFFF8F8FC), const Color(0xFFEDEDF4)],
      );
}
