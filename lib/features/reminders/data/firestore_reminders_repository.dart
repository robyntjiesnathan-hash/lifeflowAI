import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constants/firestore_paths.dart';
import '../domain/reminder.dart';
import '../domain/reminders_repository.dart';

class FirestoreRemindersRepository implements RemindersRepository {
  FirestoreRemindersRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _remindersCol(String uid) =>
      _firestore.collection(FirestorePaths.users).doc(uid).collection(FirestorePaths.reminders);

  @override
  Stream<List<Reminder>> watchReminders(String uid) {
    return _remindersCol(uid).orderBy('scheduledAt', descending: false).snapshots().map(
          (snap) => snap.docs.map((d) => Reminder.fromJson({...d.data(), 'id': d.id})).toList(),
        );
  }

  @override
  Future<Reminder> createReminder(String uid, Reminder reminder) async {
    final doc = _remindersCol(uid).doc();
    final withId = reminder.copyWith(id: doc.id, createdAt: DateTime.now());
    await doc.set(withId.toJson()..remove('id'));
    return withId;
  }

  @override
  Future<void> updateReminder(String uid, Reminder reminder) =>
      _remindersCol(uid).doc(reminder.id).set(reminder.toJson()..remove('id'), SetOptions(merge: true));

  @override
  Future<void> deleteReminder(String uid, String reminderId) => _remindersCol(uid).doc(reminderId).delete();
}
