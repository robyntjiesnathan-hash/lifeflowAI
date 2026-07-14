import 'dart:async';

import 'package:uuid/uuid.dart';

import '../domain/reminder.dart';
import '../domain/reminders_repository.dart';

/// In-memory reminders store for fake-auth mode, keyed by uid. Uses a
/// broadcast [StreamController] that re-emits on every mutation so the list
/// stays live (a plain `Stream.value(...)` would go stale after the first
/// emission).
class FakeRemindersRepository implements RemindersRepository {
  static final Map<String, List<Reminder>> _reminders = {};
  static final Map<String, StreamController<List<Reminder>>> _controllers = {};
  final _uuid = const Uuid();

  StreamController<List<Reminder>> _controllerFor(String uid) =>
      _controllers.putIfAbsent(uid, () => StreamController<List<Reminder>>.broadcast());

  void _emit(String uid) => _controllerFor(uid).add(List.unmodifiable(_reminders[uid] ?? const []));

  @override
  Stream<List<Reminder>> watchReminders(String uid) {
    final controller = _controllerFor(uid);
    Future.microtask(() => _emit(uid));
    return controller.stream;
  }

  @override
  Future<Reminder> createReminder(String uid, Reminder reminder) async {
    final withId = reminder.copyWith(id: _uuid.v4(), createdAt: DateTime.now());
    _reminders.putIfAbsent(uid, () => []).add(withId);
    _emit(uid);
    return withId;
  }

  @override
  Future<void> updateReminder(String uid, Reminder reminder) async {
    final list = _reminders[uid];
    if (list == null) return;
    final index = list.indexWhere((r) => r.id == reminder.id);
    if (index == -1) return;
    list[index] = reminder;
    _emit(uid);
  }

  @override
  Future<void> deleteReminder(String uid, String reminderId) async {
    _reminders[uid]?.removeWhere((r) => r.id == reminderId);
    _emit(uid);
  }
}
