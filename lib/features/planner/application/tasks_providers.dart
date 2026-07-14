import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/app_config.dart';
import '../../../core/constants/xp_rules.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../auth/application/auth_providers.dart';
import '../../gamification/application/gamification_service.dart';
import '../data/fake_tasks_repository.dart';
import '../data/firestore_tasks_repository.dart';
import '../domain/task.dart';
import '../domain/tasks_repository.dart';

part 'tasks_providers.g.dart';

@Riverpod(keepAlive: true)
TasksRepository tasksRepository(Ref ref) {
  if (AppConfig.useFakeAuth) return FakeTasksRepository();
  return FirestoreTasksRepository(ref.watch(firestoreProvider));
}

String? _currentUid(Ref ref) => ref.watch(authStateChangesProvider).value?.uid;

@riverpod
Stream<List<Task>> tasks(Ref ref) {
  final uid = _currentUid(ref);
  if (uid == null) return Stream.value(const []);
  return ref.watch(tasksRepositoryProvider).watchTasks(uid);
}

@riverpod
class TasksController extends _$TasksController {
  @override
  FutureOr<void> build() {}

  String get _uid {
    final uid = ref.read(authStateChangesProvider).value?.uid;
    if (uid == null) throw StateError('No signed-in user');
    return uid;
  }

  Future<void> createTask(Task task) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(tasksRepositoryProvider).createTask(_uid, task));
  }

  Future<void> updateTask(Task task) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(tasksRepositoryProvider).updateTask(_uid, task));
  }

  Future<void> deleteTask(String taskId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(tasksRepositoryProvider).deleteTask(_uid, taskId));
  }

  /// Toggles todo <-> done and, only on the todo -> done transition, awards
  /// task-complete XP via the shared gamification service.
  Future<void> toggleStatus(String taskId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final uid = _uid;
      final nowDone = await ref.read(tasksRepositoryProvider).toggleStatus(uid, taskId);
      if (nowDone) {
        await ref.read(gamificationServiceProvider).awardXp(uid, XpRules.taskComplete);
      }
    });
  }
}
