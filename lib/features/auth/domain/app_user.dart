import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';

/// Domain-level user, decoupled from `firebase_auth`'s `User` so the rest of
/// the app (and `FakeAuthRepository`) never depends on the Firebase SDK
/// directly.
@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String uid,
    String? email,
    String? displayName,
    String? photoUrl,
    required bool isAnonymous,
    required String providerId,
  }) = _AppUser;
}
