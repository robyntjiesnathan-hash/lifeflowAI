import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../application/meals_providers.dart';
import '../../domain/shopping_list_item.dart';

class ShoppingListScreen extends ConsumerWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(shoppingListProvider);
    final weekId = ref.watch(currentWeekIdProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Shopping List')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(shoppingListProvider),
        child: itemsAsync.when(
          loading: () => ListView(children: const [LoadingCardSkeleton(), LoadingCardSkeleton()]),
          error: (error, stack) =>
              ListView(children: [Padding(padding: const EdgeInsets.all(32), child: Text('$error'))]),
          data: (items) {
            return ListView(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 100),
              children: [
                GradientPillButton(
                  label: "Generate from this week's plan",
                  icon: Icons.auto_awesome_rounded,
                  onPressed: () => ref.read(mealsControllerProvider.notifier).generateShoppingList(weekId),
                ),
                const SizedBox(height: AppSpacing.lg),
                if (items.isEmpty)
                  EmptyState(
                    icon: Icons.shopping_cart_outlined,
                    title: 'Shopping list is empty',
                    message: "Generate a list from this week's meal plan, or add items manually.",
                    actionLabel: 'Add Item',
                    onAction: () => _showAddItemSheet(context),
                  )
                else ...[
                  for (final item in items)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: AppCard(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                        onTap: () =>
                            ref.read(mealsControllerProvider.notifier).toggleShoppingListItem(item.id, !item.isChecked),
                        child: Row(
                          children: [
                            Icon(
                              item.isChecked ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                              color: item.isChecked ? theme.colorScheme.primary : theme.dividerColor,
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Text(
                                item.name,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  decoration: item.isChecked ? TextDecoration.lineThrough : null,
                                  color: item.isChecked ? theme.disabledColor : null,
                                ),
                              ),
                            ),
                            Text(
                              _formatQuantity(item),
                              style: AppTypography.tabular(
                                size: theme.textTheme.bodySmall?.fontSize ?? 12,
                                weight: FontWeight.w500,
                                color: theme.textTheme.bodySmall?.color,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close_rounded, size: 18),
                              onPressed: () => ref.read(mealsControllerProvider.notifier).deleteShoppingListItem(item.id),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: AppSpacing.md),
                  GradientPillButton(label: 'Add Item', icon: Icons.add_rounded, onPressed: () => _showAddItemSheet(context)),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

String _formatQuantity(ShoppingListItem item) {
  final quantity = item.quantity;
  final quantityLabel = quantity == quantity.roundToDouble() ? quantity.toInt().toString() : quantity.toString();
  return item.unit.isEmpty ? quantityLabel : '$quantityLabel ${item.unit}';
}

Future<void> _showAddItemSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: const _AddShoppingItemSheet(),
    ),
  );
}

class _AddShoppingItemSheet extends ConsumerStatefulWidget {
  const _AddShoppingItemSheet();

  @override
  ConsumerState<_AddShoppingItemSheet> createState() => _AddShoppingItemSheetState();
}

class _AddShoppingItemSheetState extends ConsumerState<_AddShoppingItemSheet> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _quantity = TextEditingController(text: '1');
  final _unit = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _quantity.dispose();
    _unit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(mealsControllerProvider).isLoading;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Add item', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _name,
                label: 'Item name',
                hint: 'e.g. Bananas',
                autofocus: true,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Give it a name' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: _quantity,
                      label: 'Quantity',
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: AppTextField(controller: _unit, label: 'Unit', hint: 'e.g. pcs')),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              GradientPillButton(
                label: isLoading ? 'Adding…' : 'Add',
                onPressed: isLoading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) return;
                        final quantity = double.tryParse(_quantity.text.trim()) ?? 1;
                        await ref.read(mealsControllerProvider.notifier).addShoppingListItem(
                              ShoppingListItem(
                                id: '',
                                name: _name.text.trim(),
                                quantity: quantity,
                                unit: _unit.text.trim(),
                                addedAt: DateTime.now(),
                              ),
                            );
                        if (context.mounted) Navigator.of(context).pop();
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
