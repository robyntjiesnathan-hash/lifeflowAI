/// Abstract in-app-purchase surface, shaped like RevenueCat's `Purchases`
/// API without depending on the `purchases_flutter` package. This lets the
/// premium paywall be built and exercised against a mock today and swapped
/// for a real store-backed implementation later without touching calling
/// code.
abstract class PurchaseService {
  /// Attempts to purchase [productId]. Returns `true` on success.
  Future<bool> purchase(String productId);

  /// Restores previously-purchased entitlements for the current store
  /// account.
  Future<void> restorePurchases();

  /// Live premium entitlement state for [uid].
  Stream<bool> isPremiumStream(String uid);
}
