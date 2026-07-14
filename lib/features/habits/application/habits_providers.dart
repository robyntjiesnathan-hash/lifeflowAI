import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/app_config.dart';
import '../../../core/constants/xp_rules.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../auth/application/auth_providers.dart';
import '../../gamification/application/gamification_service.dart';
import '../data/fake_habits_repository.dart';
import '../data/firestore_habits_repository.dart';
import '../domain/habit.dart';
import '../domain/habit_completion.dart';
import '../domain/habits_repository.dart';

part 'habits_providers.g.dart';

@Riverpod(keepAlive: true)
HabitsRepository habitsRepository(Ref ref) {
  if (AppConfig.useFakeAuth) return FakeHabitsRepository();
  return FirestoreHabitsRepository(ref.watch(firestoreProvider));
}

String? _currentUid(Ref ref) => ref.watch(authStateChangesProvider).value?.uid;

@riverpod
Stream<List<Habit>> habits(Ref ref) {
  final uid = _currentUid(ref);
  if (uid == null) return Stream.value(const []);
  return ref.watch(habitsRepositoryProvider).watchHabits(uid);
}

@riverpod
Stream<List<HabitCompletion>> habitCompletionsForRange(
  Ref ref,
  String habitId, {
  required DateTime start,
  required DateTime end,
}) {
  final uid = _currentUid(ref);
  if (uid == null) return Stream.value(const []);
  return ref.watch(habitsRepositoryProvider).watchCompletionsForRange(uid, habitId, start: start, end: end);
}

@riverpod
Stream<bool> habitCompletedToday(Ref ref, String habitId) {
  final uid = _currentUid(ref);
  if (uid == null) return Stream.value(false);
  final today = DateTime.now();
  final dayOnly = DateTime(today.year, today.month, today.day);
  return ref
      .watch(habitsRepositoryProvider)
      .watchCompletionsForRange(uid, habitId, start: dayOnly, end: dayOnly)
      .map((completions) => completions.any((c) => c.completed));
}

/// Percent of habits completed on each of the last 7 days (Mon-Sun of the
/// current week), used for the Habits screen's "Overall Progress" sparkline.
@riverpod
Future<List<double>> habitsWeeklyProgress(Ref ref) async {
  final habitsList = await ref.watch(habitsProvider.future);
  final uid = _currentUid(ref);
  if (uid == null || habitsList.isEmpty) return List.filled(7, 0);

  final repo = ref.watch(habitsRepositoryProvider);
  final now = DateTime.now();
  final monday = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1));

  final results = <double>[];
  for (int i = 0; i < 7; i++) {
    final day = monday.add(Duration(days: i));
    int completedCount = 0;
    for (final habit in habitsList) {
      final completions = await repo.watchCompletionsForRange(uid, habit.id, start: day, end: day).first;
      if (completions.any((c) => c.completed)) completedCount++;
    }
    results.add(completedCount / habitsList.length * 100);
  }
  return results;
}

@riverpod
class HabitsController extends _$HabitsController {
  @override
  FutureOr<void> build() {}

  String get _uid {
    final uid = ref.read(authStateChangesProvider).value?.uid;
    if (uid == null) throw StateError('No signed-in user');
    return uid;
  }

  Future<void> createHabit(Habit habit) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(habitsRepositoryProvider).createHabit(_uid, habit));
  }

  Future<void> updateHabit(Habit habit) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(habitsRepositoryProvider).updateHabit(_uid, habit));
  }

  Future<void> archiveHabit(String habitId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(habitsRepositoryProvider).archiveHabit(_uid, habitId));
  }

  Future<void> deleteHabit(String habitId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(habitsRepositoryProvider).deleteHabit(_uid, habitId));
  }

  Future<void> toggleCompletion(String habitId, {bool wasComplete = false}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final uid = _uid;
      await ref.read(habitsRepositoryProvider).toggleCompletion(uid, habitId);
      if (!wasComplete) {
        await ref.read(gamificationServiceProvider).awardXp(uid, XpRules.habitComplete);
      }
      ref.invalidate(habitsWeeklyProgressProvider);
    });
  }
}
