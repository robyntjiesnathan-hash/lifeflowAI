import 'habit.dart';
import 'habit_completion.dart';

abstract class HabitsRepository {
  Stream<List<Habit>> watchHabits(String uid, {bool includeArchived = false});

  Stream<List<HabitCompletion>> watchCompletionsForRange(
    String uid,
    String habitId, {
    required DateTime start,
    required DateTime end,
  });

  Future<Habit> createHabit(String uid, Habit habit);

  Future<void> updateHabit(String uid, Habit habit);

  Future<void> archiveHabit(String uid, String habitId);

  Future<void> deleteHabit(String uid, String habitId);

  /// Toggles today's (or [date]'s) completion, recomputing
  /// `currentStreak`/`longestStreak` transactionally off the last
  /// completion rather than aggregating full history on every toggle.
  /// Returns the habit's resulting `currentStreak` so callers can evaluate
  /// streak-based badges without a second read.
  Future<int> toggleCompletion(String uid, String habitId, {DateTime? date});
}
