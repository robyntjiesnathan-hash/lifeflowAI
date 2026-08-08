import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../profile/application/user_profile_providers.dart';
import '../data/mock_purchase_service.dart';
import '../domain/purchase_service.dart';

part 'premium_providers.g.dart';

@Riverpod(keepAlive: true)
PurchaseService purchaseService(Ref ref) => MockPurchaseService(ref);

/// Whether the signed-in user currently has an active premium entitlement —
/// derived from [currentUserProfileProvider] rather than tracked
/// separately, so it always reflects the same profile doc the rest of the
/// app reads.
@riverpod
bool isPremium(Ref ref) => ref.watch(currentUserProfileProvider).value?.isPremium ?? false;
