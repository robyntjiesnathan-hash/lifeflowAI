import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/xp_rules.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/badge_chip.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../../../core/widgets/progress_ring.dart';
import '../../application/gamification_service.dart';

/// Reusable card showing the current level, an XP progress bar toward the
/// next level, and the current streak — built on top of
/// [gamificationSummaryProvider], used on the Profile screen (and reusable
/// anywhere else a compact gamification summary is useful).
class XpLevelCard extends ConsumerWidget {
  const XpLevelCard({super.key, required this.uid});

  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final summaryAsync = ref.watch(gamificationSummaryProvider(uid));

    return summaryAsync.when(
      loading: () => const LoadingCardSkeleton(lines: 3, height: 110),
      error: (error, stack) => AppCard(child: Text('$error')),
      data: (summary) {
        final int level = summary.level.clamp(1, XpRules.levelThresholds.length);
        final bool maxLevel = summary.xpToNextLevel == 0 && level >= XpRules.levelThresholds.length;
        double progress = 1.0;
        if (!maxLevel) {
          final int currentFloor = XpRules.levelThresholds[level - 1];
          final int nextCeiling = summary.xp + summary.xpToNextLevel;
          final int span = nextCeiling - currentFloor;
          progress = span <= 0 ? 1.0 : (summary.xp - currentFloor) / span;
        }

        return AppCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppProgressRing(
                percent: progress,
                size: 68,
                strokeWidth: 8,
                center: Text(
                  '${summary.level}',
                  style: AppTypography.tabular(size: 20, weight: FontWeight.w800, color: theme.colorScheme.primary),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Level ${summary.level}', style: theme.textTheme.titleMedium),
                        if (summary.currentStreakDays > 0) BadgeChip.streak(summary.currentStreakDays),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text('${summary.xp} XP total', style: theme.textTheme.bodySmall),
                    const SizedBox(height: 4),
                    Text(
                      maxLevel ? 'Max level reached' : '${summary.xpToNextLevel} XP to level ${summary.level + 1}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
