import 'package:flutter/material.dart';

/// Static color palette for LifeFlow AI.
///
/// Named like paint swatches, not just hex dumps, and independently tuned
/// per brightness — dark mode is its own considered palette (Moon Violet /
/// Meadow Glow / Ember Glow, brightened and re-saturated for a near-black
/// surface), not the light palette inverted or alpha-blended over black.
/// Deliberately avoids the two most common "generic AI app" palette tells:
/// a violet-to-blue two-stop brand gradient, and unmodified framework-stock
/// semantic colors (Tailwind `green-500`/`red-500`/`amber-500`).
class AppColors {
  const AppColors._();

  // Brand — Dusk Violet. Solid fill only; never rendered as a two-stop
  // gradient (see AppGradients.primary, which now resolves to this same
  // color at both stops so existing gradient-typed call sites render flat).
  static const Color seed = Color(0xFF6952D6);
  static const Color gradientStart = Color(0xFF6952D6);
  static const Color gradientEnd = Color(0xFF6952D6);

  // Light theme surfaces — warm-tinted neutrals (Dawn Mist / Cloud / Ink),
  // not pure white/gray/black.
  static const Color lightBackground = Color(0xFFF6F2FB);
  static const Color lightSurface = Color(0xFFFFFDFC);
  static const Color lightSurfaceVariant = Color(0xFFEFEAF7);

  // Dark theme surfaces — Midnight / Charcoal, warm-violet-tinted near-black
  // rather than a neutral gray/black inversion of the light surfaces.
  static const Color darkBackground = Color(0xFF151220);
  static const Color darkSurface = Color(0xFF1F1A2E);
  static const Color darkSurfaceVariant = Color(0xFF2A2438);

  // Semantic / category accents (pastel tint + saturated icon color pairs),
  // tuned into the app's own palette family rather than left at framework
  // defaults.
  static const Color success = Color(0xFF1E9E82); // Meadow
  static const Color successTint = Color(0xFFDFF3EE);
  static const Color warning = Color(0xFFD89A2B); // Honey
  static const Color warningTint = Color(0xFFFBF0DC);
  static const Color error = Color(0xFFD6495F); // Brick Rose
  static const Color errorTint = Color(0xFFF8E3E7);
  static const Color info = Color(0xFF5B7FE0); // Periwinkle
  static const Color infoTint = Color(0xFFE7ECFA);
  static const Color income = Color(0xFF1E9E82); // Meadow
  static const Color expense = Color(0xFFD6495F); // Brick Rose
  static const Color expenseTint = Color(0xFFF8E3E7);
  static const Color streakFlame = Color(0xFFF2734A); // Coral Ember
  static const Color streakFlameTint = Color(0xFFFDE9E0);
  static const Color xpGold = Color(0xFFE3A83A);
  static const Color xpGoldTint = Color(0xFFFBF1DC);

  static const Color categoryPurple = Color(0xFF6952D6); // Dusk Violet
  static const Color categoryPurpleTint = Color(0xFFECE7FA);
  static const Color categoryBlue = Color(0xFF5B7FE0); // Periwinkle
  static const Color categoryBlueTint = Color(0xFFE7ECFA);
  static const Color categoryPink = Color(0xFFE0568A);
  static const Color categoryPinkTint = Color(0xFFFAE5EE);
  static const Color categoryTeal = Color(0xFF1FA6A6);
  static const Color categoryTealTint = Color(0xFFDFF4F4);

  // Dark-mode-specific accent brightenings — used only by AppSemanticColors
  // .dark, so accents stay legible/vivid on a near-black surface instead of
  // reusing the light-mode value at reduced alpha (the "inverted, not
  // redesigned" dark-mode tell). Material's own ColorScheme.fromSeed already
  // derives an appropriately brightened `colorScheme.primary` per brightness,
  // so only the custom semantic accents need a hand-picked dark variant here.
  static const Color darkSuccess = Color(0xFF4FD9B4); // Meadow Glow
  static const Color darkWarning = Color(0xFFE8B85B);
  static const Color darkError = Color(0xFFE87B8C);
  static const Color darkInfo = Color(0xFF8FA8EE);
  static const Color darkStreakFlame = Color(0xFFFF9466); // Ember Glow
  static const Color darkXpGold = Color(0xFFF0C169);
  static const Color darkCategoryPurple = Color(0xFFA794FF); // Moon Violet
  static const Color darkCategoryBlue = Color(0xFF8FA8EE);
  static const Color darkCategoryPink = Color(0xFFEE85AE);
  static const Color darkCategoryTeal = Color(0xFF5CC9C9);
}
