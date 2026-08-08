/// Thrown by [AiCoachController.sendMessage] when a free-tier user has hit
/// the free message limit — backs the premium paywall's "Unlimited AI
/// coaching conversations" claim with an actual enforced cap instead of it
/// being aspirational copy.
class AiCoachMessageLimitReached implements Exception {
  const AiCoachMessageLimitReached();
}
