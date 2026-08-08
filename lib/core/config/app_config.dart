/// Runtime configuration flags.
///
/// [useFakeAuth] lets the app boot and be fully navigable without a live
/// Firebase project: pass `--dart-define=USE_FAKE_AUTH=true` to force it, or
/// leave it unset — [useFakeAuth] also auto-enables itself if Firebase
/// initialization fails in `bootstrap.dart` (e.g. because
/// `firebase_options.dart` still holds placeholder values).
class AppConfig {
  const AppConfig._();

  static const bool _fakeAuthDefine = bool.fromEnvironment('USE_FAKE_AUTH');

  /// Flipped on by `bootstrap.dart` after a failed `Firebase.initializeApp()`
  /// call, in addition to the compile-time define.
  static bool _forcedByFailedInit = false;

  static bool get useFakeAuth => _fakeAuthDefine || _forcedByFailedInit;

  static void forceFakeAuth() => _forcedByFailedInit = true;
}
