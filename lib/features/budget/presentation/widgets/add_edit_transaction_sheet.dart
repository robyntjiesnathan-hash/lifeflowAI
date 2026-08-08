import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_segmented_control.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../application/budget_providers.dart';
import '../../domain/budget_category.dart';
import '../../domain/transaction.dart';

final _dateFormat = DateFormat('MMM d, yyyy');

Future<void> showAddEditTransactionSheet(BuildContext context, {BudgetTransaction? existing}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: AddEditTransactionSheet(existing: existing),
    ),
  );
}

class AddEditTransactionSheet extends ConsumerStatefulWidget {
  const AddEditTransactionSheet({super.key, this.existing});

  final BudgetTransaction? existing;

  @override
  ConsumerState<AddEditTransactionSheet> createState() => _AddEditTransactionSheetState();
}

class _AddEditTransactionSheetState extends ConsumerState<AddEditTransactionSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _amount;
  late final TextEditingController _note;
  TransactionType _type = TransactionType.expense;
  String? _categoryId;
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    _amount = TextEditingController(text: widget.existing?.amount.toString() ?? '');
    _note = TextEditingController(text: widget.existing?.note ?? '');
    _type = widget.existing?.type ?? TransactionType.expense;
    _categoryId = widget.existing?.categoryId;
    _date = widget.existing?.date ?? DateTime.now();
  }

  @override
  void dispose() {
    _amount.dispose();
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existing != null;
    final isLoading = ref.watch(budgetControllerProvider).isLoading;
    final profile = ref.watch(budgetProfileProvider).value;
    final categories = profile?.categories ?? const <BudgetCategory>[];
    final currency = profile?.currency ?? 'USD';

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(isEditing ? 'Edit Transaction' : 'New Transaction', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.md),
              Center(
                child: AppSegmentedControl<TransactionType>(
                  options: const [
                    (TransactionType.expense, 'Expense'),
                    (TransactionType.income, 'Income'),
                  ],
                  value: _type,
                  onChanged: (value) => setState(() => _type = value),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _amount,
                label: 'Amount ($currency)',
                hint: '0.00',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  final parsed = num.tryParse(v ?? '');
                  if (parsed == null || parsed <= 0) return 'Enter a valid amount';
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(controller: _note, label: 'Note (optional)', hint: 'e.g. Groceries'),
              if (categories.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.md),
                Text('Category', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final category in categories)
                      ChoiceChip(
                        avatar: Icon(category.iconKey.icon, size: 16),
                        label: Text(category.name),
                        selected: _categoryId == category.id,
                        onSelected: (_) => setState(() => _categoryId = _categoryId == category.id ? null : category.id),
                      ),
                  ],
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              Text('Date', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) setState(() => _date = picked);
                },
                child: Text(_dateFormat.format(_date)),
              ),
              const SizedBox(height: AppSpacing.lg),
              GradientPillButton(
                label: isLoading ? 'Saving…' : (isEditing ? 'Save changes' : 'Add Transaction'),
                onPressed: isLoading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) return;
                        final transaction = (widget.existing ?? const BudgetTransaction(id: '', amount: 0)).copyWith(
                          type: _type,
                          amount: num.parse(_amount.text.trim()),
                          categoryId: _categoryId,
                          note: _note.text.trim().isEmpty ? null : _note.text.trim(),
                          date: _date,
                        );
                        final controller = ref.read(budgetControllerProvider.notifier);
                        if (isEditing) {
                          await controller.deleteTransaction(widget.existing!.id);
                          await controller.addTransaction(transaction);
                        } else {
                          await controller.addTransaction(transaction);
                        }
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
