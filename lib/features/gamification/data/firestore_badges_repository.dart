import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constants/firestore_paths.dart';
import '../domain/badges_repository.dart';
import '../domain/earned_badge.dart';

class FirestoreBadgesRepository implements BadgesRepository {
  FirestoreBadgesRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _badgesCol(String uid) =>
      _firestore.collection(FirestorePaths.users).doc(uid).collection(FirestorePaths.badges);

  @override
  Stream<List<EarnedBadge>> watchEarnedBadges(String uid) => _badgesCol(uid).snapshots().map(
        (snap) => snap.docs.map((d) => EarnedBadge.fromJson({...d.data(), 'badgeDefinitionId': d.id})).toList(),
      );

  @override
  Future<void> awardBadge(String uid, String badgeDefinitionId) async {
    final ref = _badgesCol(uid).doc(badgeDefinitionId);
    final snap = await ref.get();
    if (snap.exists) return;
    await ref.set(EarnedBadge(badgeDefinitionId: badgeDefinitionId, earnedAt: DateTime.now()).toJson());
  }
}
