import 'package:flutter/material.dart';

/// Builds the app [TextTheme] on a deliberate 1.25 (major-third) type scale,
/// rounded to sensible pixel values at the smallest sizes for legibility.
///
/// Manrope's 800 (ExtraBold) weight is reserved for display sizes only —
/// hero numbers, greetings, celebration text — and is never used in body
/// copy, labels, or form fields, so the "loud" weight stays a considered
/// accent rather than diluted everywhere. A separate bundled mono face
/// ([monoFontFamily]) carries tabular figures — streak counts, XP, currency
/// — kept out of the TextTheme itself since it's a data-display treatment,
/// not a prose size step; use [AppTypography.tabular] to build one.
class AppTypography {
  const AppTypography._();

  static const String fontFamily = 'Manrope';
  static const String monoFontFamily = 'JetBrainsMono';

  static TextTheme textTheme(Brightness brightness) {
    final Color color = brightness == Brightness.dark ? Colors.white : const Color(0xFF211C2E);
    final Color subtleColor =
        brightness == Brightness.dark ? const Color(0xFFAFA6C4) : const Color(0xFF6E6480);

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
      // Display — Manrope 800, tight tracking. Hero numbers/greetings/
      // celebration moments only.
      displayLarge: style(44, FontWeight.w800, height: 1.1, letterSpacing: -0.5),
      displayMedium: style(36, FontWeight.w800, height: 1.12, letterSpacing: -0.4),
      displaySmall: style(30, FontWeight.w800, height: 1.15, letterSpacing: -0.3),
      // Headline — Manrope 700.
      headlineLarge: style(28, FontWeight.w700, height: 1.2),
      headlineMedium: style(26, FontWeight.w700, height: 1.2),
      headlineSmall: style(22, FontWeight.w700, height: 1.25),
      // Title — Manrope 600/700.
      titleLarge: style(20, FontWeight.w700),
      titleMedium: style(18, FontWeight.w600),
      titleSmall: style(16, FontWeight.w600),
      // Body — Manrope 500, the quiet workhorse.
      bodyLarge: style(16, FontWeight.w500, height: 1.4),
      bodyMedium: style(15, FontWeight.w500, height: 1.4, c: subtleColor),
      bodySmall: style(13, FontWeight.w500, height: 1.35, c: subtleColor),
      // Label — Manrope 700, tracked slightly wider at the smallest sizes.
      labelLarge: style(14, FontWeight.w700, letterSpacing: 0.1),
      labelMedium: style(12, FontWeight.w700, letterSpacing: 0.2),
      labelSmall: style(11, FontWeight.w600, c: subtleColor, letterSpacing: 0.3),
    );
  }

  /// A tabular-figure numeric style in [monoFontFamily], for streak counts,
  /// XP totals, and currency amounts — anywhere digits need to align
  /// column-like rather than read as prose.
  static TextStyle tabular({required double size, FontWeight weight = FontWeight.w500, Color? color}) {
    return TextStyle(
      fontFamily: monoFontFamily,
      fontFeatures: const [FontFeature.tabularFigures()],
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }
}
