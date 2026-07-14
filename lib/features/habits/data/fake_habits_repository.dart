import 'dart:async';

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../domain/habit.dart';
import '../domain/habit_completion.dart';
import '../domain/habits_repository.dart';

final _dateFormat = DateFormat('yyyy-MM-dd');

/// In-memory habits store for fake-auth mode, keyed by uid so each fake
/// session is isolated but persists for the app's lifetime.
class FakeHabitsRepository implements HabitsRepository {
  static final Map<String, List<Habit>> _habits = {};
  static final Map<String, Map<String, List<HabitCompletion>>> _completions = {};
  static final Map<String, StreamController<List<Habit>>> _habitControllers = {};
  static final Map<String, StreamController<List<HabitCompletion>>> _completionControllers = {};
  final _uuid = const Uuid();

  StreamController<List<Habit>> _controllerFor(String uid) =>
      _habitControllers.putIfAbsent(uid, () => StreamController<List<Habit>>.broadcast());

  void _emit(String uid) => _controllerFor(uid).add(List.unmodifiable(_habits[uid] ?? const []));

  StreamController<List<HabitCompletion>> _completionControllerFor(String uid, String habitId) =>
      _completionControllers.putIfAbsent(
        '$uid/$habitId',
        () => StreamController<List<HabitCompletion>>.broadcast(),
      );

  void _emitCompletions(String uid, String habitId) {
    final all = _completions[uid]?[habitId] ?? const <HabitCompletion>[];
    _completionControllerFor(uid, habitId).add(List.unmodifiable(all));
  }

  @override
  Stream<List<Habit>> watchHabits(String uid, {bool includeArchived = false}) {
    final controller = _controllerFor(uid);
    Future.microtask(() => _emit(uid));
    return controller.stream.map(
      (habits) => includeArchived ? habits : habits.where((h) => h.archivedAt == null).toList(),
    );
  }

  @override
  Stream<List<HabitCompletion>> watchCompletionsForRange(
    String uid,
    String habitId, {
    required DateTime start,
    required DateTime end,
  }) {
    final startKey = _dateFormat.format(start);
    final endKey = _dateFormat.format(end);
    final controller = _completionControllerFor(uid, habitId);
    Future.microtask(() => _emitCompletions(uid, habitId));
    return controller.stream.map(
      (all) => all.where((c) => c.date.compareTo(startKey) >= 0 && c.date.compareTo(endKey) <= 0).toList(),
    );
  }

  @override
  Future<Habit> createHabit(String uid, Habit habit) async {
    final withId = habit.copyWith(id: _uuid.v4(), createdAt: DateTime.now());
    _habits.putIfAbsent(uid, () => []).add(withId);
    _emit(uid);
    return withId;
  }

  @override
  Future<void> updateHabit(String uid, Habit habit) async {
    final list = _habits[uid];
    if (list == null) return;
    final index = list.indexWhere((h) => h.id == habit.id);
    if (index == -1) return;
    list[index] = habit;
    _emit(uid);
  }

  @override
  Future<void> archiveHabit(String uid, String habitId) async {
    final list = _habits[uid];
    if (list == null) return;
    final index = list.indexWhere((h) => h.id == habitId);
    if (index == -1) return;
    list[index] = list[index].copyWith(archivedAt: DateTime.now());
    _emit(uid);
  }

  @override
  Future<void> deleteHabit(String uid, String habitId) async {
    _habits[uid]?.removeWhere((h) => h.id == habitId);
    _completions[uid]?.remove(habitId);
    _emit(uid);
  }

  @override
  Future<void> toggleCompletion(String uid, String habitId, {DateTime? date}) async {
    final list = _habits[uid];
    if (list == null) return;
    final index = list.indexWhere((h) => h.id == habitId);
    if (index == -1) return;
    final habit = list[index];
    final targetDate = date ?? DateTime.now();
    final dateKey = _dateFormat.format(targetDate);

    final completionsForHabit = _completions.putIfAbsent(uid, () => {}).putIfAbsent(habitId, () => []);
    final existingIndex = completionsForHabit.indexWhere((c) => c.date == dateKey);
    final isCurrentlyComplete = existingIndex != -1 && completionsForHabit[existingIndex].completed;

    if (!isCurrentlyComplete) {
      final yesterday = _dateFormat.format(targetDate.subtract(const Duration(days: 1)));
      final lastCompletedKey = habit.lastCompletedDate == null ? null : _dateFormat.format(habit.lastCompletedDate!);
      final continuesStreak = lastCompletedKey == yesterday;
      final newStreak = continuesStreak ? habit.currentStreak + 1 : 1;

      final completion = HabitCompletion(date: dateKey, completed: true, completedAt: DateTime.now());
      if (existingIndex == -1) {
        completionsForHabit.add(completion);
      } else {
        completionsForHabit[existingIndex] = completion;
      }
      list[index] = habit.copyWith(
        currentStreak: newStreak,
        longestStreak: newStreak > habit.longestStreak ? newStreak : habit.longestStreak,
        lastCompletedDate: targetDate,
      );
    } else {
      completionsForHabit[existingIndex] = HabitCompletion(date: dateKey, completed: false);
      final decremented = habit.currentStreak - 1;
      list[index] = habit.copyWith(currentStreak: decremented < 0 ? 0 : decremented);
    }
    _emit(uid);
    _emitCompletions(uid, habitId);
  }
}
