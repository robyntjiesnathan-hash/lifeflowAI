import 'package:flutter/material.dart';

/// Static color palette for LifeFlow AI, matched to the reference mockup:
/// a calm purple-to-indigo brand gradient over a soft lavender-gray
/// background in light mode, and a near-black surface in dark mode.
class AppColors {
  const AppColors._();

  // Brand
  static const Color seed = Color(0xFF6D5AE6);
  static const Color gradientStart = Color(0xFF8B5CF6);
  static const Color gradientEnd = Color(0xFF4C6EF5);

  // Light theme surfaces
  static const Color lightBackground = Color(0xFFF5F5FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF0EEFC);

  // Dark theme surfaces
  static const Color darkBackground = Color(0xFF121218);
  static const Color darkSurface = Color(0xFF1C1C26);
  static const Color darkSurfaceVariant = Color(0xFF262632);

  // Semantic / category accents (pastel tint + saturated icon color pairs)
  static const Color success = Color(0xFF22C55E);
  static const Color successTint = Color(0xFFE3F9EA);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningTint = Color(0xFFFEF3E0);
  static const Color income = Color(0xFF22C55E);
  static const Color expense = Color(0xFFEF4444);
  static const Color expenseTint = Color(0xFFFDE8E8);
  static const Color streakFlame = Color(0xFFF97316);
  static const Color streakFlameTint = Color(0xFFFFEEE0);
  static const Color xpGold = Color(0xFFF5B711);
  static const Color xpGoldTint = Color(0xFFFEF6DE);

  static const Color categoryPurple = Color(0xFF8B5CF6);
  static const Color categoryPurpleTint = Color(0xFFEFE8FE);
  static const Color categoryBlue = Color(0xFF3B82F6);
  static const Color categoryBlueTint = Color(0xFFE3EDFE);
  static const Color categoryPink = Color(0xFFEC4899);
  static const Color categoryPinkTint = Color(0xFFFCE5F1);
  static const Color categoryTeal = Color(0xFF14B8A6);
  static const Color categoryTealTint = Color(0xFFDFF7F3);
}
