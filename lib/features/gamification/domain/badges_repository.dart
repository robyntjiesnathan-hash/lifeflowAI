import 'earned_badge.dart';

abstract class BadgesRepository {
  Stream<List<EarnedBadge>> watchEarnedBadges(String uid);

  /// Records [badgeDefinitionId] as earned for [uid]. No-ops if the badge
  /// has already been earned (idempotent, safe to call speculatively from
  /// criteria-checking code elsewhere in the app).
  Future<void> awardBadge(String uid, String badgeDefinitionId);
}
