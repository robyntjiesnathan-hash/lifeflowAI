import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/app_config.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../auth/application/auth_providers.dart';
import '../data/fake_user_profile_repository.dart';
import '../data/firestore_user_profile_repository.dart';
import '../domain/user_profile.dart';
import '../domain/user_profile_repository.dart';

part 'user_profile_providers.g.dart';

@Riverpod(keepAlive: true)
UserProfileRepository userProfileRepository(Ref ref) {
  if (AppConfig.useFakeAuth) return FakeUserProfileRepository();
  return FirestoreUserProfileRepository(ref.watch(firestoreProvider));
}

/// Live profile for the *currently signed-in* user, or `null` while
/// signed out / before the doc exists. This (together with
/// [authStateChangesProvider]) is what drives the router's redirect logic.
@Riverpod(keepAlive: true)
Stream<UserProfile?> currentUserProfile(Ref ref) {
  final authState = ref.watch(authStateChangesProvider);
  final user = authState.value;
  if (user == null) return Stream.value(null);
  final repo = ref.watch(userProfileRepositoryProvider);
  // Fire-and-forget: makes sure a bare profile doc exists right after
  // sign-in/sign-up so onboarding has something to update into.
  repo.ensureProfileExists(user.uid, email: user.email, authProvider: user.isAnonymous ? 'guest' : user.providerId);
  return repo.watchProfile(user.uid);
}

@Riverpod(keepAlive: true)
class UserProfileController extends _$UserProfileController {
  @override
  FutureOr<void> build() {}

  Future<void> save(UserProfile profile) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(userProfileRepositoryProvider).saveProfile(profile));
  }

  Future<void> updateFields(String uid, Map<String, dynamic> fields) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(userProfileRepositoryProvider).updateFields(uid, fields));
  }
}
