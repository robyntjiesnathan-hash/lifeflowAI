/// Tunable XP point values and level thresholds, kept as a lookup table
/// (not a formula) so pacing can be designer-adjusted without touching
/// [GamificationService] logic.
class XpRules {
  const XpRules._();

  static const int taskComplete = 10;
  static const int habitComplete = 15;
  static const int goalMilestone = 25;
  static const int goalComplete = 100;

  /// XP required to *reach* each level; index 0 = level 1 threshold (0 XP).
  static const List<int> levelThresholds = [
    0, 100, 250, 450, 700, 1000, 1400, 1900, 2500, 3200, 4000,
  ];

  static int levelForXp(int xp) {
    int level = 1;
    for (int i = 0; i < levelThresholds.length; i++) {
      if (xp >= levelThresholds[i]) level = i + 1;
    }
    return level;
  }

  static int xpToNextLevel(int xp) {
    final level = levelForXp(xp);
    if (level >= levelThresholds.length) return 0;
    return levelThresholds[level] - xp;
  }
}
