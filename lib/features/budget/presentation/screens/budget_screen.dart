import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../../../core/widgets/section_header.dart';
import '../../application/budget_providers.dart';
import '../../domain/budget_category.dart';
import '../../domain/budget_profile.dart';
import '../../domain/transaction.dart';
import '../widgets/add_edit_transaction_sheet.dart';
import '../widgets/category_spend_row.dart';

class BudgetScreen extends ConsumerWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(budgetProfileProvider);
    final transactionsAsync = ref.watch(transactionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget'),
        leading: Navigator.canPop(context) ? const BackButton() : null,
        actions: [
          TextButton.icon(
            onPressed: () => context.push('/budget/bills'),
            icon: const Icon(Icons.receipt_long_rounded, size: 18),
            label: const Text('Bills'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddEditTransactionSheet(context),
        child: const Icon(Icons.add_rounded),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(budgetProfileProvider);
          ref.invalidate(transactionsProvider);
        },
        child: profileAsync.when(
          loading: () => ListView(children: const [LoadingCardSkeleton(), LoadingCardSkeleton()]),
          error: (error, stack) => ListView(children: [Padding(padding: const EdgeInsets.all(32), child: Text('$error'))]),
          data: (profile) => transactionsAsync.when(
            loading: () => ListView(children: const [LoadingCardSkeleton(), LoadingCardSkeleton()]),
            error: (error, stack) => ListView(children: [Padding(padding: const EdgeInsets.all(32), child: Text('$error'))]),
            data: (transactions) => _BudgetContent(profile: profile, transactions: transactions),
          ),
        ),
      ),
    );
  }
}

class _BudgetContent extends StatelessWidget {
  const _BudgetContent({required this.profile, required this.transactions});

  final BudgetProfile profile;
  final List<BudgetTransaction> transactions;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final monthExpenses = transactions
        .where((t) =>
            t.type == TransactionType.expense &&
            t.date != null &&
            t.date!.year == now.year &&
            t.date!.month == now.month)
        .toList();

    final totalSpent = monthExpenses.fold<num>(0, (sum, t) => sum + t.amount);
    final budgetTarget = profile.monthlyBudgetTarget;
    final spentPercent = budgetTarget > 0 ? (totalSpent / budgetTarget).clamp(0.0, 1.0) : 0.0;

    final spendByCategory = <String, num>{};
    for (final t in monthExpenses) {
      final key = t.categoryId;
      if (key == null) continue;
      spendByCategory[key] = (spendByCategory[key] ?? 0) + t.amount;
    }

    final categoriesWithSpend = [...profile.categories]
      ..sort((a, b) => (spendByCategory[b.id] ?? 0).compareTo(spendByCategory[a.id] ?? 0));

    if (transactions.isEmpty) {
      return ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          _TotalSpentHeroCard(totalSpent: totalSpent, budgetTarget: budgetTarget, percent: spentPercent.toDouble()),
          EmptyState(
            icon: Icons.account_balance_wallet_rounded,
            title: 'No transactions yet',
            message: 'Log an expense or some income to start tracking your budget.',
            actionLabel: 'Add Transaction',
            onAction: () => showAddEditTransactionSheet(context),
          ),
        ],
      );
    }

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        _TotalSpentHeroCard(totalSpent: totalSpent, budgetTarget: budgetTarget, percent: spentPercent.toDouble()),
        const SizedBox(height: AppSpacing.lg),
        const SectionHeader(title: 'Categories'),
        AppCard(
          child: Column(
            children: [
              for (final category in categoriesWithSpend)
                CategorySpendRow(
                  category: category,
                  amountSpent: spendByCategory[category.id] ?? 0,
                  percentOfTotal: totalSpent > 0 ? ((spendByCategory[category.id] ?? 0) / totalSpent).toDouble() : 0.0,
                ),
            ],
          ),
        ),
        if (spendByCategory.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          const SectionHeader(title: 'Spend Breakdown'),
          AppCard(
            child: SizedBox(
              height: 200,
              child: _CategoryPieChart(categories: categoriesWithSpend, spendByCategory: spendByCategory),
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }
}

class _TotalSpentHeroCard extends StatelessWidget {
  const _TotalSpentHeroCard({required this.totalSpent, required this.budgetTarget, required this.percent});

  final num totalSpent;
  final num budgetTarget;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return GradientHeroCard(
      gradient: AppGradients.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Total Spent', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '\$${totalSpent.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${(percent * 100).round()}% of \$${budgetTarget.toStringAsFixed(2)} budget',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.pill),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.25),
              valueColor: const AlwaysStoppedAnimation(Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryPieChart extends StatelessWidget {
  const _CategoryPieChart({required this.categories, required this.spendByCategory});

  final List<BudgetCategory> categories;
  final Map<String, num> spendByCategory;

  @override
  Widget build(BuildContext context) {
    final sections = <PieChartSectionData>[
      for (final category in categories)
        if ((spendByCategory[category.id] ?? 0) > 0)
          PieChartSectionData(
            value: (spendByCategory[category.id] ?? 0).toDouble(),
            color: category.color,
            title: category.name,
            radius: 56,
            titleStyle: const TextStyle(fontSize: 0),
          ),
    ];

    if (sections.isEmpty) {
      return const Center(child: Text('No spend yet this month'));
    }

    return Row(
      children: [
        Expanded(
          child: PieChart(
            PieChartData(sections: sections, sectionsSpace: 2, centerSpaceRadius: 36),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final category in categories)
                if ((spendByCategory[category.id] ?? 0) > 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Container(width: 10, height: 10, decoration: BoxDecoration(color: category.color, shape: BoxShape.circle)),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            category.name,
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
            ],
          ),
        ),
      ],
    );
  }
}
