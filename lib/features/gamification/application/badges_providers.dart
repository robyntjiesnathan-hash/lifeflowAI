import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/app_config.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../auth/application/auth_providers.dart';
import '../data/fake_badges_repository.dart';
import '../data/firestore_badges_repository.dart';
import '../domain/badges_repository.dart';
import '../domain/earned_badge.dart';

part 'badges_providers.g.dart';

@Riverpod(keepAlive: true)
BadgesRepository badgesRepository(Ref ref) {
  if (AppConfig.useFakeAuth) return FakeBadgesRepository();
  return FirestoreBadgesRepository(ref.watch(firestoreProvider));
}

@riverpod
Stream<List<EarnedBadge>> earnedBadges(Ref ref) {
  final uid = ref.watch(authStateChangesProvider).value?.uid;
  if (uid == null) return Stream.value(const []);
  return ref.watch(badgesRepositoryProvider).watchEarnedBadges(uid);
}
