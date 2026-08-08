import 'dart:async';

import '../domain/badges_repository.dart';
import '../domain/earned_badge.dart';

/// In-memory badges store for fake-auth mode, keyed by uid, mirroring
/// [FakeHabitsRepository]'s reactive-broadcast-stream pattern.
class FakeBadgesRepository implements BadgesRepository {
  static final Map<String, List<EarnedBadge>> _badges = {};
  static final Map<String, StreamController<List<EarnedBadge>>> _controllers = {};

  StreamController<List<EarnedBadge>> _controllerFor(String uid) =>
      _controllers.putIfAbsent(uid, () => StreamController<List<EarnedBadge>>.broadcast());

  void _emit(String uid) => _controllerFor(uid).add(List.unmodifiable(_badges[uid] ?? const []));

  @override
  Stream<List<EarnedBadge>> watchEarnedBadges(String uid) {
    final controller = _controllerFor(uid);
    Future.microtask(() => _emit(uid));
    return controller.stream;
  }

  @override
  Future<void> awardBadge(String uid, String badgeDefinitionId) async {
    final list = _badges.putIfAbsent(uid, () => []);
    if (list.any((b) => b.badgeDefinitionId == badgeDefinitionId)) return;
    list.add(EarnedBadge(badgeDefinitionId: badgeDefinitionId, earnedAt: DateTime.now()));
    _emit(uid);
  }
}
