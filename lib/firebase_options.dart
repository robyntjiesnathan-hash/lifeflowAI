// PLACEHOLDER FILE — NOT REAL FIREBASE CONFIGURATION.
//
// This file exists so the app compiles and boots without a live Firebase
// project. Every value below is a fake placeholder; `Firebase.initializeApp`
// will fail at runtime with these values, and `bootstrap.dart` catches that
// failure and falls back to the fake-auth/local-only mode so the app is
// still fully navigable.
//
// To go live: install the FlutterFire CLI and run it from the project root:
//   dart pub global activate flutterfire_cli
//   flutterfire configure
// That command overwrites this file with real values for your Firebase
// project (Android/iOS/web) and wires up google-services.json /
// GoogleService-Info.plist automatically.

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  const DefaultFirebaseOptions._();

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not configured for platform '
          '$defaultTargetPlatform — run `flutterfire configure`.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'placeholder-api-key',
    appId: '1:000000000000:web:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'lifeflow-ai-placeholder',
    storageBucket: 'lifeflow-ai-placeholder.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'placeholder-api-key',
    appId: '1:000000000000:android:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'lifeflow-ai-placeholder',
    storageBucket: 'lifeflow-ai-placeholder.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'placeholder-api-key',
    appId: '1:000000000000:ios:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'lifeflow-ai-placeholder',
    storageBucket: 'lifeflow-ai-placeholder.appspot.com',
    iosBundleId: 'com.lifeflowai.lifeflowAi',
  );
}
