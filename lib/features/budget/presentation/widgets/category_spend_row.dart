import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/badge_chip.dart';
import '../../domain/budget_category.dart';

/// One row in the Budget screen's Categories list: icon chip, category name,
/// amount spent, and percent of total spend — matching the reference
/// design's "Housing · $650.00 · 52%" rows.
class CategorySpendRow extends StatelessWidget {
  const CategorySpendRow({
    super.key,
    required this.category,
    required this.amountSpent,
    required this.percentOfTotal,
    this.onTap,
  });

  final BudgetCategory category;
  final num amountSpent;

  /// 0.0 - 1.0
  final double percentOfTotal;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.md),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            CategoryIconChip(
              icon: category.iconKey.icon,
              color: category.color,
              tint: category.color.withValues(alpha: 0.14),
              size: 40,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(category.name, style: theme.textTheme.titleMedium),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('\$${amountSpent.toStringAsFixed(2)}', style: theme.textTheme.titleMedium),
                Text(
                  '${(percentOfTotal * 100).round()}%',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
