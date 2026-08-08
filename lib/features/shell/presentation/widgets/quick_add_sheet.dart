import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_paths.dart';
import '../../../../core/theme/app_semantic_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/badge_chip.dart';

Future<void> showQuickAddSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => const QuickAddSheet(),
  );
}

/// Segmented "what do you want to add?" chooser opened from the shell FAB,
/// handing off to each feature's own add flow rather than duplicating forms
/// here.
class QuickAddSheet extends StatelessWidget {
  const QuickAddSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final semantic = context.semanticColors;
    final theme = Theme.of(context);
    final items = <(IconData, String, Color, Color, VoidCallback)>[
      (Icons.check_circle_outline_rounded, 'Task', semantic.categoryBlue, semantic.categoryBlueTint,
          () => context.push(RoutePaths.planner)),
      (Icons.repeat_rounded, 'Habit', semantic.success, semantic.successTint, () => context.push(RoutePaths.habits)),
      (Icons.trending_down_rounded, 'Expense', semantic.expense, semantic.expenseTint,
          () => context.push(RoutePaths.budget)),
      (Icons.trending_up_rounded, 'Income', semantic.income, semantic.successTint, () => context.push(RoutePaths.budget)),
      (Icons.notifications_active_outlined, 'Reminder', semantic.categoryPink, semantic.categoryPinkTint,
          () => context.push(RoutePaths.reminders)),
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quick Add', style: theme.textTheme.titleLarge),
            const SizedBox(height: AppSpacing.md),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 0.95,
              children: [
                for (final item in items)
                  _QuickAddTile(icon: item.$1, label: item.$2, color: item.$3, tint: item.$4, onTap: () {
                    Navigator.of(context).pop();
                    item.$5();
                  }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAddTile extends StatelessWidget {
  const _QuickAddTile({required this.icon, required this.label, required this.color, required this.tint, required this.onTap});

  final IconData icon;
  final String label;
  final Color color;
  final Color tint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadii.lg),
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CategoryIconChip(icon: icon, color: color, tint: tint, size: 52),
          const SizedBox(height: AppSpacing.xs),
          Text(label, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
