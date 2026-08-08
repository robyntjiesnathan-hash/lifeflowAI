import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/providers/shared_preferences_provider.dart';
import 'core/services/local_notification_service.dart';
import 'firebase_options.dart';

/// App entrypoint logic, split out of `main.dart` so tests can call it too.
///
/// Firebase initialization is wrapped in a try/catch: with the placeholder
/// `firebase_options.dart` values (before `flutterfire configure` has been
/// run), this call fails, and we fall back to [AppConfig.forceFakeAuth] so
/// the app is still fully navigable end-to-end with an in-memory auth/data
/// layer instead of crashing on launch.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!AppConfig.useFakeAuth) {
    try {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    } catch (error, stackTrace) {
      debugPrint('Firebase.initializeApp failed, falling back to fake-auth mode: $error\n$stackTrace');
      AppConfig.forceFakeAuth();
    }
  }

  try {
    await LocalNotificationService.instance.init();
  } catch (error, stackTrace) {
    // Non-critical: reminders simply won't fire locally on platforms/targets
    // where this plugin isn't configured (e.g. this project's desktop
    // targets aren't part of the App Store / Play Store release scope).
    debugPrint('LocalNotificationService.init failed, continuing without local notifications: $error\n$stackTrace');
  }

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(sharedPreferences)],
      child: const LifeFlowApp(),
    ),
  );
}
