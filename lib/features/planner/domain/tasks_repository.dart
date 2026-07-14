import 'task.dart';

abstract class TasksRepository {
  /// All (non-deleted) tasks for the user, live. The Day/Week/Month view
  /// filtering happens client-side against this one stream, mirroring how
  /// `HabitsRepository.watchHabits` is the single source the UI slices.
  Stream<List<Task>> watchTasks(String uid);

  Future<Task> createTask(String uid, Task task);

  Future<void> updateTask(String uid, Task task);

  /// Flips between [TaskStatus.todo] and [TaskStatus.done], stamping/clearing
  /// `completedAt` accordingly. Returns the task's new completion state so
  /// callers can decide whether to award XP.
  Future<bool> toggleStatus(String uid, String taskId);

  Future<void> deleteTask(String uid, String taskId);
}
