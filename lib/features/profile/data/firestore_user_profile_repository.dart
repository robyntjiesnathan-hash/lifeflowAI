import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constants/firestore_paths.dart';
import '../domain/user_profile.dart';
import '../domain/user_profile_repository.dart';

class FirestoreUserProfileRepository implements UserProfileRepository {
  FirestoreUserProfileRepository(this._firestore);

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> _doc(String uid) =>
      _firestore.collection(FirestorePaths.users).doc(uid);

  @override
  Stream<UserProfile?> watchProfile(String uid) => _doc(uid).snapshots().map(
        (snap) => snap.exists ? UserProfile.fromJson(snap.data()!) : null,
      );

  @override
  Future<UserProfile?> getProfile(String uid) async {
    final snap = await _doc(uid).get();
    return snap.exists ? UserProfile.fromJson(snap.data()!) : null;
  }

  @override
  Future<void> ensureProfileExists(String uid, {String? email, required String authProvider}) async {
    final ref = _doc(uid);
    final snap = await ref.get();
    if (snap.exists) return;
    final profile = UserProfile(
      uid: uid,
      email: email,
      authProvider: AuthProviderName.values.firstWhere(
        (p) => p.name == authProvider,
        orElse: () => AuthProviderName.guest,
      ),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await ref.set(profile.toJson());
  }

  @override
  Future<void> saveProfile(UserProfile profile) =>
      _doc(profile.uid).set(profile.copyWith(updatedAt: DateTime.now()).toJson(), SetOptions(merge: true));

  @override
  Future<void> updateFields(String uid, Map<String, dynamic> fields) =>
      _doc(uid).update({...fields, 'updatedAt': Timestamp.now()});
}
