import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../domain/app_user.dart';
import '../domain/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._auth);

  final fb.FirebaseAuth _auth;

  AppUser _toAppUser(fb.User user) {
    final String providerId =
        user.isAnonymous ? 'guest' : (user.providerData.isNotEmpty ? user.providerData.first.providerId : 'password');
    return AppUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
      isAnonymous: user.isAnonymous,
      providerId: providerId,
    );
  }

  @override
  Stream<AppUser?> authStateChanges() =>
      _auth.authStateChanges().map((user) => user == null ? null : _toAppUser(user));

  @override
  AppUser? get currentUser {
    final user = _auth.currentUser;
    return user == null ? null : _toAppUser(user);
  }

  @override
  Future<AppUser> signInWithEmail({required String email, required String password}) async {
    final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return _toAppUser(credential.user!);
  }

  @override
  Future<AppUser> signUpWithEmail({required String email, required String password}) async {
    final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return _toAppUser(credential.user!);
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn.instance;
    await googleSignIn.initialize();
    final account = await googleSignIn.authenticate();
    final auth = account.authentication;
    final credential = fb.GoogleAuthProvider.credential(idToken: auth.idToken);
    final userCredential = await _auth.signInWithCredential(credential);
    return _toAppUser(userCredential.user!);
  }

  @override
  Future<AppUser> signInWithApple() async {
    final rawNonce = _generateNonce();
    final nonce = sha256.convert(utf8.encode(rawNonce)).toString();
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
      nonce: nonce,
    );
    final credential = fb.OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );
    final userCredential = await _auth.signInWithCredential(credential);
    return _toAppUser(userCredential.user!);
  }

  @override
  Future<AppUser> signInAnonymously() async {
    final credential = await _auth.signInAnonymously();
    return _toAppUser(credential.user!);
  }

  @override
  Future<AppUser> linkAnonymousWithEmail({required String email, required String password}) async {
    final current = _auth.currentUser;
    if (current == null || !current.isAnonymous) {
      throw StateError('linkAnonymousWithEmail called without an anonymous session');
    }
    final credential = fb.EmailAuthProvider.credential(email: email, password: password);
    final userCredential = await current.linkWithCredential(credential);
    return _toAppUser(userCredential.user!);
  }

  @override
  Future<void> sendPasswordReset({required String email}) => _auth.sendPasswordResetEmail(email: email);

  @override
  Future<void> signOut() async {
    await GoogleSignIn.instance.signOut();
    await _auth.signOut();
  }

  String _generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }
}
