import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Raw Firebase SDK singletons. These are lazily evaluated by Riverpod and
/// are only ever read from the *Firebase* repository implementations — in
/// fake-auth mode (see `AppConfig.useFakeAuth`) nothing touches these, so it
/// is safe for `Firebase.initializeApp()` to have never run.
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final firestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);
final firebaseStorageProvider = Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);
