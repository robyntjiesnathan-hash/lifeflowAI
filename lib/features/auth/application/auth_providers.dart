import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/app_config.dart';
import '../../../core/providers/firebase_providers.dart';
import '../data/fake_auth_repository.dart';
import '../data/firebase_auth_repository.dart';
import '../domain/app_user.dart';
import '../domain/auth_repository.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  if (AppConfig.useFakeAuth) return FakeAuthRepository();
  return FirebaseAuthRepository(ref.watch(firebaseAuthProvider));
}

@Riverpod(keepAlive: true)
Stream<AppUser?> authStateChanges(Ref ref) => ref.watch(authRepositoryProvider).authStateChanges();

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  AuthRepository get _repo => ref.read(authRepositoryProvider);

  Future<void> signInWithEmail({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.signInWithEmail(email: email, password: password));
  }

  Future<void> signUpWithEmail({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.signUpWithEmail(email: email, password: password));
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.signInWithGoogle());
  }

  Future<void> signInWithApple() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.signInWithApple());
  }

  Future<void> signInAnonymously() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.signInAnonymously());
  }

  Future<void> linkAnonymousWithEmail({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.linkAnonymousWithEmail(email: email, password: password));
  }

  Future<void> sendPasswordReset({required String email}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.sendPasswordReset(email: email));
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.signOut());
  }
}
