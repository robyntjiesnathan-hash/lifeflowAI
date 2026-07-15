import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/app_config.dart';
import '../../../core/constants/xp_rules.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../auth/application/auth_providers.dart';
import '../../gamification/application/gamification_service.dart';
import '../data/fake_goals_repository.dart';
import '../data/firestore_goals_repository.dart';
import '../domain/goal.dart';
import '../domain/goals_repository.dart';
import '../domain/milestone.dart';

part 'goals_providers.g.dart';

@Riverpod(keepAlive: true)
GoalsRepository goalsRepository(Ref ref) {
  if (AppConfig.useFakeAuth) return FakeGoalsRepository();
  return FirestoreGoalsRepository(ref.watch(firestoreProvider));
}

String? _currentUid(Ref ref) => ref.watch(authStateChangesProvider).value?.uid;

@riverpod
Stream<List<Goal>> goals(Ref ref) {
  final uid = _currentUid(ref);
  if (uid == null) return Stream.value(const []);
  return ref.watch(goalsRepositoryProvider).watchGoals(uid);
}

@riverpod
Stream<List<Milestone>> goalMilestones(Ref ref, String goalId) {
  final uid = _currentUid(ref);
  if (uid == null) return Stream.value(const []);
  return ref.watch(goalsRepositoryProvider).watchMilestones(uid, goalId);
}

@Riverpod(keepAlive: true)
class GoalsController extends _$GoalsController {
  @override
  FutureOr<void> build() {}

  String get _uid {
    final uid = ref.read(authStateChangesProvider).value?.uid;
    if (uid == null) throw StateError('No signed-in user');
    return uid;
  }

  Goal? _findGoal(String goalId) {
    final goals = ref.read(goalsProvider).value;
    if (goals == null) return null;
    for (final goal in goals) {
      if (goal.id == goalId) return goal;
    }
    return null;
  }

  Future<void> createGoal(Goal goal) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(goalsRepositoryProvider).createGoal(_uid, goal));
  }

  /// Generic goal update. Detects a transition into [GoalStatus.completed]
  /// (e.g. a manual "mark complete" action) and awards `goalComplete` XP for
  /// it, mirroring the milestone-driven completion path in [toggleMilestone].
  Future<void> updateGoal(Goal goal) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final uid = _uid;
      final previous = _findGoal(goal.id);
      final becameCompleted = goal.status == GoalStatus.completed && previous?.status != GoalStatus.completed;
      final toSave = becameCompleted
          ? goal.copyWith(completedAt: goal.completedAt ?? DateTime.now(), progressPercent: 100)
          : goal;
      await ref.read(goalsRepositoryProvider).updateGoal(uid, toSave);
      if (becameCompleted) {
        await ref.read(gamificationServiceProvider).awardXp(uid, XpRules.goalComplete);
      }
    });
  }

  Future<void> deleteGoal(String goalId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(goalsRepositoryProvider).deleteGoal(_uid, goalId));
  }

  Future<void> addMilestone(String goalId, Milestone milestone) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(goalsRepositoryProvider).addMilestone(_uid, goalId, milestone));
  }

  Future<void> deleteMilestone(String goalId, String milestoneId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(goalsRepositoryProvider).deleteMilestone(_uid, goalId, milestoneId));
  }

  /// Toggles a milestone, awards `goalMilestone` XP the moment it flips to
  /// done, then (if that was the last remaining milestone) marks the parent
  /// goal completed and awards `goalComplete` XP on top.
  Future<void> toggleMilestone(String goalId, String milestoneId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final uid = _uid;
      final repo = ref.read(goalsRepositoryProvider);

      final before = await repo.watchMilestones(uid, goalId).first;
      final beforeMatches = before.where((m) => m.id == milestoneId);
      final wasDone = beforeMatches.isNotEmpty && beforeMatches.first.isDone;

      await repo.toggleMilestone(uid, goalId, milestoneId);

      if (!wasDone) {
        await ref.read(gamificationServiceProvider).awardXp(uid, XpRules.goalMilestone);
      }

      final after = await repo.watchMilestones(uid, goalId).first;
      final allDone = after.isNotEmpty && after.every((m) => m.isDone);
      final goal = _findGoal(goalId);
      if (allDone && goal != null && goal.status != GoalStatus.completed) {
        await repo.updateGoal(
          uid,
          goal.copyWith(status: GoalStatus.completed, completedAt: DateTime.now(), progressPercent: 100),
        );
        await ref.read(gamificationServiceProvider).awardXp(uid, XpRules.goalComplete);
      }
    });
  }

  /// For `progressMode == manual` goals — sets the percent directly and,
  /// once it reaches 100, marks the goal completed and awards XP just like
  /// the milestone-completion path.
  Future<void> updateManualProgress(String goalId, num percent) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final uid = _uid;
      final repo = ref.read(goalsRepositoryProvider);
      await repo.updateManualProgress(uid, goalId, percent);

      if (percent >= 100) {
        final goal = _findGoal(goalId);
        if (goal != null && goal.status != GoalStatus.completed) {
          await repo.updateGoal(uid, goal.copyWith(status: GoalStatus.completed, completedAt: DateTime.now()));
          await ref.read(gamificationServiceProvider).awardXp(uid, XpRules.goalComplete);
        }
      }
    });
  }
}
