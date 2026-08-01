import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/badge_chip.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../application/budget_providers.dart';
import '../../domain/bill.dart';
import '../../domain/currency_format.dart';
import '../widgets/add_edit_bill_sheet.dart';

class BillsScreen extends ConsumerWidget {
  const BillsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billsAsync = ref.watch(billsProvider);
    final currency = ref.watch(budgetProfileProvider).value?.currency ?? 'USD';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bills'),
        leading: Navigator.canPop(context) ? const BackButton() : null,
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(billsProvider),
        child: billsAsync.when(
          loading: () => ListView(children: const [LoadingCardSkeleton(), LoadingCardSkeleton()]),
          error: (error, stack) => ListView(children: [Padding(padding: const EdgeInsets.all(32), child: Text('$error'))]),
          data: (bills) {
            return ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                if (bills.isEmpty)
                  EmptyState(
                    icon: Icons.receipt_long_rounded,
                    title: 'No bills yet',
                    message: 'Track your recurring bills so nothing slips through the cracks.',
                    actionLabel: 'Add Bill',
                    onAction: () => showAddEditBillSheet(context),
                  )
                else
                  for (final bill in bills)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: _BillCard(bill: bill, currency: currency),
                    ),
                const SizedBox(height: AppSpacing.md),
                if (bills.isNotEmpty)
                  GradientPillButton(
                    label: 'Add Bill',
                    icon: Icons.add_rounded,
                    onPressed: () => showAddEditBillSheet(context),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BillCard extends ConsumerWidget {
  const _BillCard({required this.bill, required this.currency});

  final Bill bill;
  final String currency;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return AppCard(
      onTap: () => showAddEditBillSheet(context, existing: bill),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      child: Row(
        children: [
          CategoryIconChip(
            icon: Icons.receipt_long_rounded,
            color: theme.colorScheme.primary,
            tint: theme.colorScheme.primary.withValues(alpha: 0.14),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(bill.name, style: theme.textTheme.titleMedium),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text('Due day ${bill.dueDay} · ${formatCurrency(bill.amount, currency)}', style: theme.textTheme.bodySmall),
                    if (bill.isAutoPay) ...[
                      const SizedBox(width: AppSpacing.sm),
                      const BadgeChip(label: 'Auto-pay', icon: Icons.bolt_rounded),
                    ],
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, size: 20),
            onPressed: () async {
              final confirmed = await showConfirmDialog(
                context,
                title: 'Delete bill?',
                message: 'This will remove "${bill.name}" from your bills.',
              );
              if (confirmed) {
                await ref.read(budgetControllerProvider.notifier).deleteBill(bill.id);
              }
            },
          ),
          GestureDetector(
            onTap: () => ref.read(budgetControllerProvider.notifier).updateBill(bill.copyWith(isPaidThisCycle: !bill.isPaidThisCycle)),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bill.isPaidThisCycle ? theme.colorScheme.primary : Colors.transparent,
                border: Border.all(
                  color: bill.isPaidThisCycle ? theme.colorScheme.primary : theme.dividerColor,
                  width: 2,
                ),
              ),
              child: bill.isPaidThisCycle ? const Icon(Icons.check_rounded, color: Colors.white, size: 18) : null,
            ),
          ),
        ],
      ),
    );
  }
}
