/// Spacing scale used throughout the app instead of ad-hoc magic numbers.
class AppSpacing {
  const AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  /// Extra breathing room for the Home hero scene, echoing the reference
  /// design's generous top spacing.
  static const double xxxl = 64;
}

/// Corner radius scale, split by role rather than one value reused
/// everywhere: small utility elements, then the three [AppElevation]
/// levels (`resting`/`raised`/`floating`, see `app_card.dart`), then pill
/// buttons. `card` is kept as an alias of `resting` for Flutter's built-in
/// `Card` widget theme, which the bespoke `AppCard`/`FloatingGlassCard`
/// widgets don't use directly.
class AppRadii {
  const AppRadii._();

  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double pill = 999;

  static const double resting = 20;
  static const double raised = 24;
  static const double floating = 28;

  static const double card = resting;
}
