import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/application/auth_providers.dart';
import '../../profile/application/user_profile_providers.dart';
import '../domain/purchase_service.dart';

/// Mock [PurchaseService] used until a real store integration (e.g.
/// RevenueCat) is wired in. Simulates purchase-flow latency, then persists
/// the entitlement directly onto the user's profile doc via
/// [UserProfileController]/`UserProfileRepository.updateFields` — so the
/// rest of the app (premium gating, `isPremiumProvider`) reads through the
/// same profile stream as everything else instead of a second source of
/// truth.
class MockPurchaseService implements PurchaseService {
  MockPurchaseService(this._ref);

  final Ref _ref;

  @override
  Future<bool> purchase(String productId) async {
    await Future<void>.delayed(const Duration(milliseconds: 1500));
    final uid = _ref.read(authStateChangesProvider).value?.uid;
    if (uid == null) return false;
    await _ref.read(userProfileRepositoryProvider).updateFields(uid, {
      'isPremium': true,
      'premiumSince': DateTime.now(),
    });
    return true;
  }

  @override
  Future<void> restorePurchases() async {
    // Mock store: there is nothing to restore from a real platform store —
    // a RevenueCat/StoreKit-backed implementation would re-fetch
    // entitlements here.
  }

  @override
  Stream<bool> isPremiumStream(String uid) {
    return _ref.read(userProfileRepositoryProvider).watchProfile(uid).map((profile) => profile?.isPremium ?? false);
  }
}
