import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_semantic_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/badge_chip.dart';
import '../../domain/budget_category.dart';
import '../../domain/transaction.dart';

final _dateFormat = DateFormat('MMM d');

/// One row in a transaction list: category (or income) icon, note/category
/// name, date, and a signed, color-coded amount.
class TransactionRow extends StatelessWidget {
  const TransactionRow({
    super.key,
    required this.transaction,
    this.category,
    this.onTap,
    this.onDelete,
  });

  final BudgetTransaction transaction;
  final BudgetCategory? category;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final semantic = context.semanticColors;
    final isIncome = transaction.type == TransactionType.income;
    final title = transaction.note?.trim().isNotEmpty == true
        ? transaction.note!.trim()
        : (category?.name ?? (isIncome ? 'Income' : 'Expense'));
    final amountColor = isIncome ? semantic.income : semantic.expense;
    final sign = isIncome ? '+' : '-';

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.md),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            CategoryIconChip(
              icon: isIncome ? Icons.savings_rounded : (category?.iconKey.icon ?? Icons.category_rounded),
              color: isIncome ? semantic.income : (category?.color ?? theme.colorScheme.primary),
              tint: isIncome ? semantic.income.withValues(alpha: 0.14) : (category?.color.withValues(alpha: 0.14) ?? theme.colorScheme.primary.withValues(alpha: 0.14)),
              size: 40,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.titleMedium),
                  Text(
                    transaction.date != null ? _dateFormat.format(transaction.date!) : '',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Text(
              '$sign\$${transaction.amount.toStringAsFixed(2)}',
              style: theme.textTheme.titleMedium?.copyWith(color: amountColor, fontWeight: FontWeight.w700),
            ),
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded, size: 20),
                onPressed: onDelete,
              ),
          ],
        ),
      ),
    );
  }
}
