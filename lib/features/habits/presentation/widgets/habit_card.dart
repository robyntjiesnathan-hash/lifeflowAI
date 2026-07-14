import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/badge_chip.dart';
import '../../domain/habit.dart';

class HabitCard extends StatelessWidget {
  const HabitCard({super.key, required this.habit, required this.completedToday, required this.onToggle, this.onTap});

  final Habit habit;
  final bool completedToday;
  final VoidCallback onToggle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      child: Row(
        children: [
          CategoryIconChip(icon: habit.iconKey.icon, color: habit.color, tint: habit.color.withValues(alpha: 0.14)),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(habit.name, style: theme.textTheme.titleMedium),
                const SizedBox(height: 2),
                Row(
                  children: [
                    if (habit.subtitle != null) ...[
                      Text(habit.subtitle!, style: theme.textTheme.bodySmall),
                      const SizedBox(width: AppSpacing.sm),
                    ],
                    if (habit.currentStreak > 0) BadgeChip.streak(habit.currentStreak),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: completedToday ? theme.colorScheme.primary : Colors.transparent,
                border: Border.all(
                  color: completedToday ? theme.colorScheme.primary : theme.dividerColor,
                  width: 2,
                ),
              ),
              child: completedToday ? const Icon(Icons.check_rounded, color: Colors.white, size: 18) : null,
            ),
          ),
        ],
      ),
    );
  }
}
