import 'reminder.dart';

abstract class RemindersRepository {
  Stream<List<Reminder>> watchReminders(String uid);

  Future<Reminder> createReminder(String uid, Reminder reminder);

  Future<void> updateReminder(String uid, Reminder reminder);

  Future<void> deleteReminder(String uid, String reminderId);
}
