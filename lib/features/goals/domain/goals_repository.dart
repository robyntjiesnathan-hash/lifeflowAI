import 'goal.dart';
import 'milestone.dart';

abstract class GoalsRepository {
  Stream<List<Goal>> watchGoals(String uid);

  Stream<List<Milestone>> watchMilestones(String uid, String goalId);

  Future<Goal> createGoal(String uid, Goal goal);

  Future<void> updateGoal(String uid, Goal goal);

  Future<void> deleteGoal(String uid, String goalId);

  Future<Milestone> addMilestone(String uid, String goalId, Milestone milestone);

  Future<void> deleteMilestone(String uid, String goalId, String milestoneId);

  /// Flips a milestone's `isDone`, then recomputes and writes the parent
  /// goal's denormalized `progressPercent` as `doneCount/total*100` in the
  /// same operation (transaction/batch for Firestore, in-memory for the
  /// fake repo) so the goal list never shows stale progress.
  Future<void> toggleMilestone(String uid, String goalId, String milestoneId);

  /// For goals with `progressMode == manual`, directly sets both
  /// `manualProgressPercent` and the denormalized `progressPercent`.
  Future<void> updateManualProgress(String uid, String goalId, num percent);
}
