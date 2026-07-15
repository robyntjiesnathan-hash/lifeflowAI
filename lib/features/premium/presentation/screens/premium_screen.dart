import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../application/premium_providers.dart';

const List<(String, IconData)> _premiumFeatures = [
  ('Unlimited AI coaching conversations', Icons.chat_bubble_rounded),
  ('Advanced analytics & trends', Icons.insights_rounded),
  ('Unlimited goals & habits', Icons.track_changes_rounded),
  ('Automatic cloud backup', Icons.cloud_done_rounded),
  ('Export your data as PDF', Icons.picture_as_pdf_rounded),
  ('Custom app themes', Icons.palette_rounded),
];

/// Paywall screen — shows the premium feature list and an "Upgrade Now" CTA
/// that runs [MockPurchaseService.purchase], or a "You're Premium" state if
/// [isPremiumProvider] is already true.
class PremiumScreen extends ConsumerStatefulWidget {
  const PremiumScreen({super.key});

  @override
  ConsumerState<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends ConsumerState<PremiumScreen> {
  bool _purchasing = false;

  Future<void> _upgrade() async {
    setState(() => _purchasing = true);
    final success = await ref.read(purchaseServiceProvider).purchase('lifeflow_premium_monthly');
    if (!mounted) return;
    setState(() => _purchasing = false);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You're Premium now! Welcome to LifeFlow AI Premium.")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong — please try again.')),
      );
    }
  }

  Future<void> _restore() async {
    await ref.read(purchaseServiceProvider).restorePurchases();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Purchases restored.')));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPremium = ref.watch(isPremiumProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Premium')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: isPremium ? _PremiumActiveState(theme: theme) : _buildPaywall(theme),
      ),
    );
  }

  Widget _buildPaywall(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GradientHeroCard(
          gradient: AppGradients.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.workspace_premium_rounded, size: 40, color: Colors.white),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Unlock LifeFlow AI Premium',
                style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: AppSpacing.xs),
              const Text(
                'Get unlimited AI coaching, deeper insights, and every tool LifeFlow AI has to offer.',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Everything included', style: theme.textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        AppCard(
          child: Column(
            children: [
              for (final feature in _premiumFeatures)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(feature.$2, size: 16, color: theme.colorScheme.primary),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(child: Text(feature.$1, style: theme.textTheme.bodyMedium)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        GradientPillButton(
          label: _purchasing ? 'Processing…' : 'Upgrade Now',
          icon: _purchasing ? null : Icons.bolt_rounded,
          onPressed: _purchasing ? null : _upgrade,
        ),
        const SizedBox(height: AppSpacing.sm),
        Center(
          child: TextButton(
            onPressed: _purchasing ? null : _restore,
            child: const Text('Restore purchases'),
          ),
        ),
      ],
    );
  }
}

class _PremiumActiveState extends StatelessWidget {
  const _PremiumActiveState({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSpacing.xxl),
        Icon(Icons.check_circle_rounded, size: 72, color: theme.colorScheme.primary)
            .animate()
            .scale(duration: 400.ms, curve: Curves.easeOutBack),
        const SizedBox(height: AppSpacing.lg),
        Text("You're Premium ✨", style: theme.textTheme.headlineSmall, textAlign: TextAlign.center),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Thank you for supporting LifeFlow AI. All premium features are unlocked.',
          style: theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
