import 'user_profile.dart';

abstract class UserProfileRepository {
  /// Live updates for [uid]'s profile doc. Emits `null` if the doc doesn't
  /// exist yet (e.g. immediately after sign-up, before onboarding commits).
  Stream<UserProfile?> watchProfile(String uid);

  Future<UserProfile?> getProfile(String uid);

  /// Creates the doc on first sign-in if it doesn't exist yet (bare
  /// `onboardingComplete: false` record) — read by the router's redirect
  /// logic to know whether to send the user to onboarding.
  Future<void> ensureProfileExists(String uid, {String? email, required String authProvider});

  Future<void> saveProfile(UserProfile profile);

  Future<void> updateFields(String uid, Map<String, dynamic> fields);
}
