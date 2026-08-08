import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/app_config.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../core/services/local_notification_service.dart';
import '../../auth/application/auth_providers.dart';
import '../data/fake_reminders_repository.dart';
import '../data/firestore_reminders_repository.dart';
import '../domain/reminder.dart';
import '../domain/reminders_repository.dart';

part 'reminders_providers.g.dart';

@Riverpod(keepAlive: true)
RemindersRepository remindersRepository(Ref ref) {
  if (AppConfig.useFakeAuth) return FakeRemindersRepository();
  return FirestoreRemindersRepository(ref.watch(firestoreProvider));
}

String? _currentUid(Ref ref) => ref.watch(authStateChangesProvider).value?.uid;

@riverpod
Stream<List<Reminder>> reminders(Ref ref) {
  final uid = _currentUid(ref);
  if (uid == null) return Stream.value(const []);
  return ref.watch(remindersRepositoryProvider).watchReminders(uid);
}

@Riverpod(keepAlive: true)
class RemindersController extends _$RemindersController {
  @override
  FutureOr<void> build() {}

  String get _uid {
    final uid = ref.read(authStateChangesProvider).value?.uid;
    if (uid == null) throw StateError('No signed-in user');
    return uid;
  }

  LocalNotificationService get _notifications => ref.read(localNotificationServiceProvider);

  /// Schedules the on-device notification for [reminder] and returns the
  /// platform notification id to persist on `localNotificationId`.
  ///
  /// Weekly/monthly repeats are simplified to a one-time schedule for the
  /// next occurrence: `flutter_local_notifications`' recurring support only
  /// covers exact daily time-of-day matching out of the box, and true
  /// weekly/monthly recurrence would need a custom rescheduling job (e.g. a
  /// re-arm-on-fire callback), which is out of scope for this pass.
  Future<int> _schedule(Reminder reminder) {
    switch (reminder.repeat) {
      case ReminderRepeat.daily:
        return _notifications.scheduleDaily(
          title: reminder.title,
          body: 'Reminder',
          hour: reminder.scheduledAt.hour,
          minute: reminder.scheduledAt.minute,
        );
      case ReminderRepeat.none:
      case ReminderRepeat.weekly:
      case ReminderRepeat.monthly:
        return _notifications.scheduleOneTime(
          title: reminder.title,
          body: 'Reminder',
          dateTime: reminder.scheduledAt,
        );
    }
  }

  Future<void> createReminder(Reminder reminder) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final uid = _uid;
      final notificationId = reminder.isEnabled ? await _schedule(reminder) : null;
      await ref
          .read(remindersRepositoryProvider)
          .createReminder(uid, reminder.copyWith(localNotificationId: notificationId));
    });
  }

  Future<void> updateReminder(Reminder reminder) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final uid = _uid;
      if (reminder.localNotificationId != null) {
        await _notifications.cancel(reminder.localNotificationId!);
      }
      final notificationId = reminder.isEnabled ? await _schedule(reminder) : null;
      await ref
          .read(remindersRepositoryProvider)
          .updateReminder(uid, reminder.copyWith(localNotificationId: notificationId));
    });
  }

  Future<void> setEnabled(Reminder reminder, bool isEnabled) => updateReminder(reminder.copyWith(isEnabled: isEnabled));

  Future<void> deleteReminder(Reminder reminder) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      if (reminder.localNotificationId != null) {
        await _notifications.cancel(reminder.localNotificationId!);
      }
      await ref.read(remindersRepositoryProvider).deleteReminder(_uid, reminder.id);
    });
  }
}
