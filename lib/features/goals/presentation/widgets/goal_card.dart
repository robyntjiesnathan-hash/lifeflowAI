import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../core/theme/app_semantic_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/badge_chip.dart';
import '../../domain/goal.dart';

/// Goal summary row for the Goals list — matches the reference design's
/// category icon + title/percent header + progress bar layout.
class GoalCard extends StatelessWidget {
  const GoalCard({super.key, required this.goal, this.onTap});

  final Goal goal;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percent = goal.progressFraction;

    return AppCard(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryIconChip(icon: goal.category.icon, color: goal.category.color, tint: goal.category.tint),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(goal.title, style: theme.textTheme.titleMedium)),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      '${(percent * 100).round()}%',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: goal.category.color,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                if (goal.description.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    goal.description,
                    style: theme.textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: AppSpacing.sm),
                LinearPercentIndicator(
                  percent: percent,
                  lineHeight: 8,
                  barRadius: const Radius.circular(AppRadii.pill),
                  backgroundColor: goal.category.tint,
                  progressColor: goal.category.color,
                  padding: EdgeInsets.zero,
                  animation: true,
                  animationDuration: 600,
                ),
                if (goal.status == GoalStatus.completed) ...[
                  const SizedBox(height: AppSpacing.sm),
                  BadgeChip(
                    label: 'Completed',
                    icon: Icons.check_circle_rounded,
                    color: context.semanticColors.success,
                    tint: context.semanticColors.successTint,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
