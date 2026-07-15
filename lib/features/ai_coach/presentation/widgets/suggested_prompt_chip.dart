import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';

/// Tappable pill chip offering a canned prompt (e.g. "Plan my day.") that
/// sends that text to Flow when tapped — matching the reference design's
/// blue "Plan my day" suggestion pill below Flow's welcome bubble.
class SuggestedPromptChip extends StatelessWidget {
  const SuggestedPromptChip({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.primary.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(AppRadii.pill),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.pill),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 10),
          child: Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary),
          ),
        ),
      ),
    );
  }
}
