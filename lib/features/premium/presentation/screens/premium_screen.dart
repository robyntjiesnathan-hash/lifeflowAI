import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_semantic_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/badge_chip.dart';
import '../../application/premium_providers.dart';

// Trimmed from 6 to 4 claims — "Export your data as PDF" and "Custom app
// themes" had zero backing code anywhere (no pdf/printing dependency, no
// theme-variant system beyond light/dark/system), and "Advanced analytics
// & trends" was renamed to match what actually exists today (Budget's
// category pie chart) rather than implying trend charts that don't exist.
// "Unlimited AI coaching conversations" is now a real, enforced cap — see
// kFreeMessageLimit in ai_coach_providers.dart.
const List<(String, IconData)> _premiumFeatures = [
  ('Unlimited AI coaching conversations', Icons.chat_bubble_rounded),
  ('Spending breakdown & insights', Icons.insights_rounded),
  ('Unlimited goals & habits', Icons.track_changes_rounded),
  ('Automatic cloud backup', Icons.cloud_done_rounded),
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
        _buildFeatureList(theme),
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

  Widget _buildFeatureList(ThemeData theme) {
    final semantic = context.semanticColors;
    // Each perk gets its own color instead of one repeated primary circle —
    // six identical icon-in-a-circle rows was the exact "generic feature
    // callout" pattern the design brief warns against, and gave the list
    // zero visual differentiation.
    final colors = [
      semantic.categoryPurple,
      semantic.categoryBlue,
      semantic.success,
      semantic.info,
    ];
    final tints = [
      semantic.categoryPurpleTint,
      semantic.categoryBlueTint,
      semantic.successTint,
      semantic.infoTint,
    ];
    return AppCard(
      elevation: AppElevation.raised,
      child: Column(
        children: [
          for (int i = 0; i < _premiumFeatures.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
              child: Row(
                children: [
                  CategoryIconChip(icon: _premiumFeatures[i].$2, color: colors[i], tint: tints[i], size: 36),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: Text(_premiumFeatures[i].$1, style: theme.textTheme.bodyMedium)),
                ],
              ),
            ),
        ],
      ),
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
