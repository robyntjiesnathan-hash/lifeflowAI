import 'dart:async';

import '../domain/user_profile.dart';
import '../domain/user_profile_repository.dart';

/// In-memory profile store used in fake-auth mode. Kept as a process-wide
/// singleton map (not per-instance) so it survives provider rebuilds the
/// same way a real Firestore doc would survive widget rebuilds.
class FakeUserProfileRepository implements UserProfileRepository {
  static final Map<String, UserProfile> _store = {};
  static final Map<String, StreamController<UserProfile?>> _controllers = {};

  StreamController<UserProfile?> _controllerFor(String uid) =>
      _controllers.putIfAbsent(uid, () => StreamController<UserProfile?>.broadcast(onListen: () {}));

  @override
  Stream<UserProfile?> watchProfile(String uid) {
    final controller = _controllerFor(uid);
    Future.microtask(() => controller.add(_store[uid]));
    return controller.stream;
  }

  @override
  Future<UserProfile?> getProfile(String uid) async => _store[uid];

  @override
  Future<void> ensureProfileExists(String uid, {String? email, required String authProvider}) async {
    if (_store.containsKey(uid)) return;
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
    _store[uid] = profile;
    _controllerFor(uid).add(profile);
  }

  @override
  Future<void> saveProfile(UserProfile profile) async {
    final updated = profile.copyWith(updatedAt: DateTime.now());
    _store[profile.uid] = updated;
    _controllerFor(profile.uid).add(updated);
  }

  @override
  Future<void> updateFields(String uid, Map<String, dynamic> fields) async {
    final current = _store[uid];
    if (current == null) return;
    // Merge onto the JSON representation (rather than special-casing each
    // field) so every top-level field callers write via updateFields — e.g.
    // isPremium, premiumSince, notificationPrefs — behaves the same way it
    // would against a real Firestore doc's `update()`.
    final merged = {...current.toJson(), ...fields, 'updatedAt': DateTime.now().toIso8601String()};
    final updated = UserProfile.fromJson(merged);
    _store[uid] = updated;
    _controllerFor(uid).add(updated);
  }
}
