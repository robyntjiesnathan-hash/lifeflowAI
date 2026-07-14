import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/firestore_paths.dart';
import '../domain/habit.dart';
import '../domain/habit_completion.dart';
import '../domain/habits_repository.dart';

final _dateFormat = DateFormat('yyyy-MM-dd');

class FirestoreHabitsRepository implements HabitsRepository {
  FirestoreHabitsRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _habitsCol(String uid) =>
      _firestore.collection(FirestorePaths.users).doc(uid).collection(FirestorePaths.habits);

  @override
  Stream<List<Habit>> watchHabits(String uid, {bool includeArchived = false}) {
    return _habitsCol(uid).orderBy('createdAt', descending: false).snapshots().map(
          (snap) => snap.docs
              .map((d) => Habit.fromJson({...d.data(), 'id': d.id}))
              .where((h) => includeArchived || h.archivedAt == null)
              .toList(),
        );
  }

  @override
  Stream<List<HabitCompletion>> watchCompletionsForRange(
    String uid,
    String habitId, {
    required DateTime start,
    required DateTime end,
  }) {
    return _habitsCol(uid)
        .doc(habitId)
        .collection(FirestorePaths.completions)
        .where(FieldPath.documentId, isGreaterThanOrEqualTo: _dateFormat.format(start))
        .where(FieldPath.documentId, isLessThanOrEqualTo: _dateFormat.format(end))
        .snapshots()
        .map((snap) => snap.docs.map((d) => HabitCompletion.fromJson(d.data())).toList());
  }

  @override
  Future<Habit> createHabit(String uid, Habit habit) async {
    final doc = _habitsCol(uid).doc();
    final withId = habit.copyWith(id: doc.id, createdAt: DateTime.now());
    await doc.set(withId.toJson()..remove('id'));
    return withId;
  }

  @override
  Future<void> updateHabit(String uid, Habit habit) =>
      _habitsCol(uid).doc(habit.id).set(habit.toJson()..remove('id'), SetOptions(merge: true));

  @override
  Future<void> archiveHabit(String uid, String habitId) =>
      _habitsCol(uid).doc(habitId).update({'archivedAt': Timestamp.now()});

  @override
  Future<void> deleteHabit(String uid, String habitId) => _habitsCol(uid).doc(habitId).delete();

  @override
  Future<void> toggleCompletion(String uid, String habitId, {DateTime? date}) async {
    final targetDate = date ?? DateTime.now();
    final dateKey = _dateFormat.format(targetDate);
    final habitRef = _habitsCol(uid).doc(habitId);
    final completionRef = habitRef.collection(FirestorePaths.completions).doc(dateKey);

    await _firestore.runTransaction((transaction) async {
      final habitSnap = await transaction.get(habitRef);
      final completionSnap = await transaction.get(completionRef);
      if (!habitSnap.exists) return;

      final habit = Habit.fromJson({...habitSnap.data()!, 'id': habitId});
      final isCurrentlyComplete = completionSnap.exists && (completionSnap.data()?['completed'] as bool? ?? false);

      if (!isCurrentlyComplete) {
        final yesterday = _dateFormat.format(targetDate.subtract(const Duration(days: 1)));
        final lastCompletedKey = habit.lastCompletedDate == null ? null : _dateFormat.format(habit.lastCompletedDate!);
        final continuesStreak = lastCompletedKey == yesterday;
        final newStreak = continuesStreak ? habit.currentStreak + 1 : 1;

        transaction.set(completionRef, HabitCompletion(date: dateKey, completed: true, completedAt: DateTime.now()).toJson());
        transaction.update(habitRef, {
          'currentStreak': newStreak,
          'longestStreak': newStreak > habit.longestStreak ? newStreak : habit.longestStreak,
          'lastCompletedDate': Timestamp.fromDate(targetDate),
        });
      } else {
        transaction.set(completionRef, HabitCompletion(date: dateKey, completed: false).toJson());
        final decremented = habit.currentStreak - 1;
        transaction.update(habitRef, {'currentStreak': decremented < 0 ? 0 : decremented});
      }
    });
  }
}
