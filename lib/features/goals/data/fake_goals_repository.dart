import 'dart:async';

import 'package:uuid/uuid.dart';

import '../domain/goal.dart';
import '../domain/goals_repository.dart';
import '../domain/milestone.dart';

/// In-memory goals store for fake-auth mode, keyed by uid so each fake
/// session is isolated but persists for the app's lifetime. Mirrors
/// `FakeHabitsRepository` — broadcast `StreamController`s that re-emit on
/// every mutation, never a one-shot `Stream.value(...)`.
class FakeGoalsRepository implements GoalsRepository {
  static final Map<String, List<Goal>> _goals = {};
  static final Map<String, Map<String, List<Milestone>>> _milestones = {};
  static final Map<String, StreamController<List<Goal>>> _goalControllers = {};
  static final Map<String, StreamController<List<Milestone>>> _milestoneControllers = {};
  final _uuid = const Uuid();

  StreamController<List<Goal>> _controllerFor(String uid) =>
      _goalControllers.putIfAbsent(uid, () => StreamController<List<Goal>>.broadcast());

  void _emit(String uid) => _controllerFor(uid).add(List.unmodifiable(_goals[uid] ?? const []));

  StreamController<List<Milestone>> _milestoneControllerFor(String uid, String goalId) =>
      _milestoneControllers.putIfAbsent(
        '$uid/$goalId',
        () => StreamController<List<Milestone>>.broadcast(),
      );

  void _emitMilestones(String uid, String goalId) {
    final all = _milestones[uid]?[goalId] ?? const <Milestone>[];
    _milestoneControllerFor(uid, goalId).add(List.unmodifiable(all));
  }

  @override
  Stream<List<Goal>> watchGoals(String uid) {
    final controller = _controllerFor(uid);
    Future.microtask(() => _emit(uid));
    return controller.stream;
  }

  @override
  Stream<List<Milestone>> watchMilestones(String uid, String goalId) {
    final controller = _milestoneControllerFor(uid, goalId);
    Future.microtask(() => _emitMilestones(uid, goalId));
    return controller.stream;
  }

  @override
  Future<Goal> createGoal(String uid, Goal goal) async {
    final now = DateTime.now();
    final withId = goal.copyWith(id: _uuid.v4(), createdAt: now, updatedAt: now);
    _goals.putIfAbsent(uid, () => []).add(withId);
    _emit(uid);
    return withId;
  }

  @override
  Future<void> updateGoal(String uid, Goal goal) async {
    final list = _goals[uid];
    if (list == null) return;
    final index = list.indexWhere((g) => g.id == goal.id);
    if (index == -1) return;
    list[index] = goal.copyWith(updatedAt: DateTime.now());
    _emit(uid);
  }

  @override
  Future<void> deleteGoal(String uid, String goalId) async {
    _goals[uid]?.removeWhere((g) => g.id == goalId);
    _milestones[uid]?.remove(goalId);
    _emit(uid);
  }

  @override
  Future<Milestone> addMilestone(String uid, String goalId, Milestone milestone) async {
    final list = _milestones.putIfAbsent(uid, () => {}).putIfAbsent(goalId, () => []);
    final withId = milestone.copyWith(id: _uuid.v4(), order: milestone.order == 0 ? list.length : milestone.order);
    list.add(withId);
    _emitMilestones(uid, goalId);
    return withId;
  }

  @override
  Future<void> deleteMilestone(String uid, String goalId, String milestoneId) async {
    _milestones[uid]?[goalId]?.removeWhere((m) => m.id == milestoneId);
    _emitMilestones(uid, goalId);
    _recomputeProgress(uid, goalId);
    _emit(uid);
  }

  @override
  Future<void> toggleMilestone(String uid, String goalId, String milestoneId) async {
    final list = _milestones[uid]?[goalId];
    if (list == null) return;
    final index = list.indexWhere((m) => m.id == milestoneId);
    if (index == -1) return;
    final current = list[index];
    list[index] = current.copyWith(isDone: !current.isDone, completedAt: !current.isDone ? DateTime.now() : null);
    _emitMilestones(uid, goalId);
    _recomputeProgress(uid, goalId);
    _emit(uid);
  }

  @override
  Future<void> updateManualProgress(String uid, String goalId, num percent) async {
    final list = _goals[uid];
    if (list == null) return;
    final index = list.indexWhere((g) => g.id == goalId);
    if (index == -1) return;
    list[index] = list[index].copyWith(manualProgressPercent: percent, progressPercent: percent, updatedAt: DateTime.now());
    _emit(uid);
  }

  void _recomputeProgress(String uid, String goalId) {
    final goals = _goals[uid];
    if (goals == null) return;
    final index = goals.indexWhere((g) => g.id == goalId);
    if (index == -1) return;
    final milestones = _milestones[uid]?[goalId] ?? const <Milestone>[];
    final total = milestones.length;
    final doneCount = milestones.where((m) => m.isDone).length;
    final progressPercent = total == 0 ? 0.0 : (doneCount / total * 100);
    goals[index] = goals[index].copyWith(progressPercent: progressPercent, updatedAt: DateTime.now());
  }
}
