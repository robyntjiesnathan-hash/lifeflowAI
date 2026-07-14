import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/app_config.dart';
import '../../../core/constants/firestore_paths.dart';
import '../../../core/constants/xp_rules.dart';
import '../../../core/providers/firebase_providers.dart';
import '../domain/gamification_summary.dart';

part 'gamification_service.g.dart';

final _dateFormat = DateFormat('yyyy-MM-dd');

/// Awards XP and maintains the daily-active streak. Fully client-derived —
/// no Cloud Functions this pass, which is an acceptable trust tradeoff for
/// a single-user-per-account personal app (documented as a known v2
/// hardening item in the build plan). Badge evaluation is layered on top of
/// this by the `gamification` feature's UI/controller.
abstract class GamificationService {
  Stream<GamificationSummary> watchSummary(String uid);

  Future<void> awardXp(String uid, int amount);
}

class FirestoreGamificationService implements GamificationService {
  FirestoreGamificationService(this._firestore);

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> _doc(String uid) => _firestore
      .collection(FirestorePaths.users)
      .doc(uid)
      .collection(FirestorePaths.gamification)
      .doc('summary');

  @override
  Stream<GamificationSummary> watchSummary(String uid) => _doc(uid).snapshots().map(
        (snap) => snap.exists ? GamificationSummary.fromJson(snap.data()!) : const GamificationSummary(),
      );

  @override
  Future<void> awardXp(String uid, int amount) async {
    final ref = _doc(uid);
    await _firestore.runTransaction((transaction) async {
      final snap = await transaction.get(ref);
      final current = snap.exists ? GamificationSummary.fromJson(snap.data()!) : const GamificationSummary();
      final updated = _applyXp(current, amount);
      transaction.set(ref, updated.toJson());
    });
  }
}

class FakeGamificationService implements GamificationService {
  static final Map<String, GamificationSummary> _store = {};

  @override
  Stream<GamificationSummary> watchSummary(String uid) =>
      Stream.value(_store[uid] ?? const GamificationSummary());

  @override
  Future<void> awardXp(String uid, int amount) async {
    final current = _store[uid] ?? const GamificationSummary();
    _store[uid] = _applyXp(current, amount);
  }
}

GamificationSummary _applyXp(GamificationSummary current, int amount) {
  final today = _dateFormat.format(DateTime.now());
  final yesterday = _dateFormat.format(DateTime.now().subtract(const Duration(days: 1)));
  final lastActiveKey = current.lastActiveDate == null ? null : _dateFormat.format(current.lastActiveDate!);

  int newStreak = current.currentStreakDays;
  if (lastActiveKey != today) {
    newStreak = lastActiveKey == yesterday ? current.currentStreakDays + 1 : 1;
  }

  final newXp = current.xp + amount;
  return current.copyWith(
    xp: newXp,
    level: XpRules.levelForXp(newXp),
    xpToNextLevel: XpRules.xpToNextLevel(newXp),
    currentStreakDays: newStreak,
    longestStreakDays: newStreak > current.longestStreakDays ? newStreak : current.longestStreakDays,
    lastActiveDate: DateTime.now(),
  );
}

@Riverpod(keepAlive: true)
GamificationService gamificationService(Ref ref) {
  if (AppConfig.useFakeAuth) return FakeGamificationService();
  return FirestoreGamificationService(ref.watch(firestoreProvider));
}

@Riverpod(keepAlive: true)
Stream<GamificationSummary> gamificationSummary(Ref ref, String uid) =>
    ref.watch(gamificationServiceProvider).watchSummary(uid);
