import 'dart:async';

import 'package:uuid/uuid.dart';

import '../domain/task.dart';
import '../domain/tasks_repository.dart';

/// In-memory tasks store for fake-auth mode, keyed by uid. Uses a broadcast
/// [StreamController] that re-emits on every mutation — a plain
/// `Stream.value(...)` would only emit once and go stale after the first
/// create/update, which was a real bug fixed in the habits feature.
class FakeTasksRepository implements TasksRepository {
  static final Map<String, List<Task>> _tasks = {};
  static final Map<String, StreamController<List<Task>>> _controllers = {};
  final _uuid = const Uuid();

  StreamController<List<Task>> _controllerFor(String uid) =>
      _controllers.putIfAbsent(uid, () => StreamController<List<Task>>.broadcast());

  void _emit(String uid) => _controllerFor(uid).add(List.unmodifiable(_tasks[uid] ?? const []));

  @override
  Stream<List<Task>> watchTasks(String uid) {
    final controller = _controllerFor(uid);
    Future.microtask(() => _emit(uid));
    return controller.stream;
  }

  @override
  Future<Task> createTask(String uid, Task task) async {
    final now = DateTime.now();
    final withId = task.copyWith(id: _uuid.v4(), createdAt: now, updatedAt: now);
    _tasks.putIfAbsent(uid, () => []).add(withId);
    _emit(uid);
    return withId;
  }

  @override
  Future<void> updateTask(String uid, Task task) async {
    final list = _tasks[uid];
    if (list == null) return;
    final index = list.indexWhere((t) => t.id == task.id);
    if (index == -1) return;
    list[index] = task.copyWith(updatedAt: DateTime.now());
    _emit(uid);
  }

  @override
  Future<bool> toggleStatus(String uid, String taskId) async {
    final list = _tasks[uid];
    if (list == null) return false;
    final index = list.indexWhere((t) => t.id == taskId);
    if (index == -1) return false;
    final task = list[index];
    final nowDone = !task.isDone;
    list[index] = task.copyWith(
      status: nowDone ? TaskStatus.done : TaskStatus.todo,
      completedAt: nowDone ? DateTime.now() : null,
      updatedAt: DateTime.now(),
    );
    _emit(uid);
    return nowDone;
  }

  @override
  Future<void> deleteTask(String uid, String taskId) async {
    _tasks[uid]?.removeWhere((t) => t.id == taskId);
    _emit(uid);
  }
}
