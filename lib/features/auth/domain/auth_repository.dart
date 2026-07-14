import 'app_user.dart';

/// Auth provider identifiers, stored on the `users/{uid}` profile doc as
/// `authProvider` and used to decide which sign-in buttons make sense to
/// show (e.g. hide "link account" once already upgraded).
enum AuthProviderKind { email, google, apple, guest }

abstract class AuthRepository {
  Stream<AppUser?> authStateChanges();

  AppUser? get currentUser;

  Future<AppUser> signInWithEmail({required String email, required String password});

  Future<AppUser> signUpWithEmail({required String email, required String password});

  Future<AppUser> signInWithGoogle();

  Future<AppUser> signInWithApple();

  Future<AppUser> signInAnonymously();

  /// Upgrades an anonymous/guest session to a permanent email account
  /// without losing the uid (and therefore without losing any Firestore
  /// data already written under that uid).
  Future<AppUser> linkAnonymousWithEmail({required String email, required String password});

  Future<void> sendPasswordReset({required String email});

  Future<void> signOut();
}
