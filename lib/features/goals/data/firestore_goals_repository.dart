import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constants/firestore_paths.dart';
import '../domain/goal.dart';
import '../domain/goals_repository.dart';
import '../domain/milestone.dart';

class FirestoreGoalsRepository implements GoalsRepository {
  FirestoreGoalsRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _goalsCol(String uid) =>
      _firestore.collection(FirestorePaths.users).doc(uid).collection(FirestorePaths.goals);

  CollectionReference<Map<String, dynamic>> _milestonesCol(String uid, String goalId) =>
      _goalsCol(uid).doc(goalId).collection(FirestorePaths.milestones);

  @override
  Stream<List<Goal>> watchGoals(String uid) {
    return _goalsCol(uid).orderBy('createdAt', descending: false).snapshots().map(
          (snap) => snap.docs.map((d) => Goal.fromJson({...d.data(), 'id': d.id})).toList(),
        );
  }

  @override
  Stream<List<Milestone>> watchMilestones(String uid, String goalId) {
    return _milestonesCol(uid, goalId).orderBy('order', descending: false).snapshots().map(
          (snap) => snap.docs.map((d) => Milestone.fromJson({...d.data(), 'id': d.id})).toList(),
        );
  }

  @override
  Future<Goal> createGoal(String uid, Goal goal) async {
    final doc = _goalsCol(uid).doc();
    final now = DateTime.now();
    final withId = goal.copyWith(id: doc.id, createdAt: now, updatedAt: now);
    await doc.set(withId.toJson()..remove('id'));
    return withId;
  }

  @override
  Future<void> updateGoal(String uid, Goal goal) async {
    final data = goal.toJson()..remove('id');
    data['updatedAt'] = Timestamp.now();
    await _goalsCol(uid).doc(goal.id).set(data, SetOptions(merge: true));
  }

  @override
  Future<void> deleteGoal(String uid, String goalId) => _goalsCol(uid).doc(goalId).delete();

  @override
  Future<Milestone> addMilestone(String uid, String goalId, Milestone milestone) async {
    final col = _milestonesCol(uid, goalId);
    final existingCount = (await col.get()).docs.length;
    final doc = col.doc();
    final withId = milestone.copyWith(id: doc.id, order: milestone.order == 0 ? existingCount : milestone.order);
    await doc.set(withId.toJson()..remove('id'));
    return withId;
  }

  @override
  Future<void> deleteMilestone(String uid, String goalId, String milestoneId) async {
    final milestonesCol = _milestonesCol(uid, goalId);
    await milestonesCol.doc(milestoneId).delete();
    await _recomputeProgress(uid, goalId);
  }

  @override
  Future<void> toggleMilestone(String uid, String goalId, String milestoneId) async {
    final milestonesCol = _milestonesCol(uid, goalId);
    final snap = await milestonesCol.get();
    final milestones = snap.docs.map((d) => Milestone.fromJson({...d.data(), 'id': d.id})).toList();
    final index = milestones.indexWhere((m) => m.id == milestoneId);
    if (index == -1) return;

    final toggled = milestones[index].copyWith(
      isDone: !milestones[index].isDone,
      completedAt: !milestones[index].isDone ? DateTime.now() : null,
    );
    milestones[index] = toggled;

    final total = milestones.length;
    final doneCount = milestones.where((m) => m.isDone).length;
    final progressPercent = total == 0 ? 0.0 : (doneCount / total * 100);

    final batch = _firestore.batch();
    batch.set(milestonesCol.doc(milestoneId), toggled.toJson()..remove('id'), SetOptions(merge: true));
    batch.update(_goalsCol(uid).doc(goalId), {'progressPercent': progressPercent, 'updatedAt': Timestamp.now()});
    await batch.commit();
  }

  @override
  Future<void> updateManualProgress(String uid, String goalId, num percent) => _goalsCol(uid).doc(goalId).update({
        'manualProgressPercent': percent,
        'progressPercent': percent,
        'updatedAt': Timestamp.now(),
      });

  Future<void> _recomputeProgress(String uid, String goalId) async {
    final snap = await _milestonesCol(uid, goalId).get();
    final total = snap.docs.length;
    final doneCount = snap.docs.where((d) => d.data()['isDone'] == true).length;
    final progressPercent = total == 0 ? 0.0 : (doneCount / total * 100);
    await _goalsCol(uid).doc(goalId).update({'progressPercent': progressPercent, 'updatedAt': Timestamp.now()});
  }
}
