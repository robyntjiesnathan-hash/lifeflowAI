import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constants/firestore_paths.dart';
import '../domain/task.dart';
import '../domain/tasks_repository.dart';

class FirestoreTasksRepository implements TasksRepository {
  FirestoreTasksRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _tasksCol(String uid) =>
      _firestore.collection(FirestorePaths.users).doc(uid).collection(FirestorePaths.tasks);

  @override
  Stream<List<Task>> watchTasks(String uid) {
    return _tasksCol(uid).orderBy('createdAt', descending: false).snapshots().map(
          (snap) => snap.docs.map((d) => Task.fromJson({...d.data(), 'id': d.id})).toList(),
        );
  }

  @override
  Future<Task> createTask(String uid, Task task) async {
    final doc = _tasksCol(uid).doc();
    final now = DateTime.now();
    final withId = task.copyWith(id: doc.id, createdAt: now, updatedAt: now);
    await doc.set(withId.toJson()..remove('id'));
    return withId;
  }

  @override
  Future<void> updateTask(String uid, Task task) {
    final updated = task.copyWith(updatedAt: DateTime.now());
    return _tasksCol(uid).doc(task.id).set(updated.toJson()..remove('id'), SetOptions(merge: true));
  }

  @override
  Future<bool> toggleStatus(String uid, String taskId) async {
    final taskRef = _tasksCol(uid).doc(taskId);
    return _firestore.runTransaction<bool>((transaction) async {
      final snap = await transaction.get(taskRef);
      if (!snap.exists) return false;
      final task = Task.fromJson({...snap.data()!, 'id': taskId});
      final nowDone = !task.isDone;
      transaction.update(taskRef, {
        'status': (nowDone ? TaskStatus.done : TaskStatus.todo).name,
        'completedAt': nowDone ? Timestamp.now() : null,
        'updatedAt': Timestamp.now(),
      });
      return nowDone;
    });
  }

  @override
  Future<void> deleteTask(String uid, String taskId) => _tasksCol(uid).doc(taskId).delete();
}
