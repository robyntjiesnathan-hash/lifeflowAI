import 'package:flutter/material.dart';

/// Builds the app [TextTheme] on top of the bundled Manrope font, tuned for
/// the large, friendly, confident type seen in the reference design
/// (big greeting headline, bold numeric stats, medium-weight body copy).
class AppTypography {
  const AppTypography._();

  static const String fontFamily = 'Manrope';

  static TextTheme textTheme(Brightness brightness) {
    final Color color = brightness == Brightness.dark ? Colors.white : const Color(0xFF1A1A24);
    final Color subtleColor =
        brightness == Brightness.dark ? const Color(0xFFA6A6B8) : const Color(0xFF6B6B7B);

    TextStyle style(double size, FontWeight weight, {Color? c, double? height, double? letterSpacing}) =>
        TextStyle(
          fontFamily: fontFamily,
          fontSize: size,
          fontWeight: weight,
          color: c ?? color,
          height: height,
          letterSpacing: letterSpacing,
        );

    return TextTheme(
      displayLarge: style(36, FontWeight.w800, height: 1.15),
      displayMedium: style(30, FontWeight.w800, height: 1.15),
      displaySmall: style(26, FontWeight.w700, height: 1.2),
      headlineLarge: style(24, FontWeight.w700),
      headlineMedium: style(22, FontWeight.w700),
      headlineSmall: style(20, FontWeight.w700),
      titleLarge: style(18, FontWeight.w700),
      titleMedium: style(16, FontWeight.w600),
      titleSmall: style(14, FontWeight.w600),
      bodyLarge: style(16, FontWeight.w500, height: 1.4),
      bodyMedium: style(14, FontWeight.w500, height: 1.4, c: subtleColor),
      bodySmall: style(12, FontWeight.w500, height: 1.3, c: subtleColor),
      labelLarge: style(14, FontWeight.w700, letterSpacing: 0.1),
      labelMedium: style(12, FontWeight.w700, letterSpacing: 0.2),
      labelSmall: style(11, FontWeight.w600, c: subtleColor, letterSpacing: 0.2),
    );
  }
}
