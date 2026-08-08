import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Overridden in `bootstrap.dart` with the awaited [SharedPreferences]
/// instance before `runApp` — every reader can safely `ref.watch` this
/// synchronously.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('sharedPreferencesProvider must be overridden in bootstrap.dart'),
);
