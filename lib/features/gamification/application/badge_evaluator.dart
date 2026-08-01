import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/badges_repository.dart';
import 'badges_providers.dart';

part 'badge_evaluator.g.dart';

/// Checks a just-updated count against each badge's threshold and awards
/// any newly-crossed badge. `BadgesRepository.awardBadge` is idempotent (a
/// no-op if the badge is already earned), so this can be called on every
/// relevant mutation without tracking "was this already checked" state.
class BadgeEvaluator {
  const BadgeEvaluator(this._badgesRepository);

  final BadgesRepository _badgesRepository;

  static const Map<String, int> _streakThresholds = {'streak_3': 3, 'streak_7': 7, 'streak_30': 30};
  static const Map<String, int> _habitsThresholds = {'habits_10': 10, 'habits_50': 50, 'habits_100': 100};
  static const Map<String, int> _goalsThresholds = {'goals_first': 1, 'goals_5': 5};
  static const Map<String, int> _tasksThresholds = {'tasks_25': 25, 'tasks_100': 100};

  /// [currentStreak] is a single habit's own `currentStreak` — call this
  /// after any habit-completion toggle that increases it.
  Future<void> evaluateStreak(String uid, int currentStreak) => _award(uid, _streakThresholds, currentStreak);

  /// [totalCompletions] is the user-wide cumulative habit-completion count
  /// (`GamificationSummary.habitsCompletedCount`).
  Future<void> evaluateHabits(String uid, int totalCompletions) => _award(uid, _habitsThresholds, totalCompletions);

  /// [totalCompleted] is the user-wide cumulative completed-goal count
  /// (`GamificationSummary.goalsCompletedCount`).
  Future<void> evaluateGoals(String uid, int totalCompleted) => _award(uid, _goalsThresholds, totalCompleted);

  /// [totalCompleted] is the user-wide cumulative completed-task count
  /// (`GamificationSummary.tasksCompletedCount`).
  Future<void> evaluateTasks(String uid, int totalCompleted) => _award(uid, _tasksThresholds, totalCompleted);

  Future<void> _award(String uid, Map<String, int> thresholds, int count) async {
    for (final entry in thresholds.entries) {
      if (count >= entry.value) {
        await _badgesRepository.awardBadge(uid, entry.key);
      }
    }
  }
}

@Riverpod(keepAlive: true)
BadgeEvaluator badgeEvaluator(Ref ref) => BadgeEvaluator(ref.watch(badgesRepositoryProvider));
