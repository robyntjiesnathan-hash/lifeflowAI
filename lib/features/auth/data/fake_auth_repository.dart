import 'dart:async';

import 'package:uuid/uuid.dart';

import '../domain/app_user.dart';
import '../domain/auth_repository.dart';

/// In-memory auth implementation used when `AppConfig.useFakeAuth` is true
/// (no live Firebase project configured yet). Lets every screen — sign-in,
/// onboarding, the full navigation shell — be exercised end-to-end without
/// any backend.
class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository() {
    _controller = StreamController<AppUser?>.broadcast(onListen: () => _controller.add(_current));
  }

  late final StreamController<AppUser?> _controller;
  AppUser? _current;
  final _uuid = const Uuid();

  Future<AppUser> _simulateSignIn({String? email, required String providerId, bool isAnonymous = false}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final user = AppUser(
      uid: 'fake-${_uuid.v4()}',
      email: email,
      displayName: email?.split('@').first,
      photoUrl: null,
      isAnonymous: isAnonymous,
      providerId: providerId,
    );
    _current = user;
    _controller.add(user);
    return user;
  }

  @override
  Stream<AppUser?> authStateChanges() => _controller.stream;

  @override
  AppUser? get currentUser => _current;

  @override
  Future<AppUser> signInWithEmail({required String email, required String password}) =>
      _simulateSignIn(email: email, providerId: 'password');

  @override
  Future<AppUser> signUpWithEmail({required String email, required String password}) =>
      _simulateSignIn(email: email, providerId: 'password');

  @override
  Future<AppUser> signInWithGoogle() => _simulateSignIn(email: 'demo@lifeflow.ai', providerId: 'google.com');

  @override
  Future<AppUser> signInWithApple() => _simulateSignIn(email: 'demo@lifeflow.ai', providerId: 'apple.com');

  @override
  Future<AppUser> signInAnonymously() => _simulateSignIn(providerId: 'guest', isAnonymous: true);

  @override
  Future<AppUser> linkAnonymousWithEmail({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final upgraded = (_current ?? await signInAnonymously()).copyWith(
      email: email,
      displayName: email.split('@').first,
      isAnonymous: false,
      providerId: 'password',
    );
    _current = upgraded;
    _controller.add(upgraded);
    return upgraded;
  }

  @override
  Future<void> sendPasswordReset({required String email}) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> signOut() async {
    _current = null;
    _controller.add(null);
  }
}
