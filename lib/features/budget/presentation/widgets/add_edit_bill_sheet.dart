import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../application/budget_providers.dart';
import '../../domain/bill.dart';
import '../../domain/budget_category.dart';

Future<void> showAddEditBillSheet(BuildContext context, {Bill? existing}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: AddEditBillSheet(existing: existing),
    ),
  );
}

class AddEditBillSheet extends ConsumerStatefulWidget {
  const AddEditBillSheet({super.key, this.existing});

  final Bill? existing;

  @override
  ConsumerState<AddEditBillSheet> createState() => _AddEditBillSheetState();
}

class _AddEditBillSheetState extends ConsumerState<AddEditBillSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _amount;
  late final TextEditingController _dueDay;
  bool _isAutoPay = false;
  String? _categoryId;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.existing?.name ?? '');
    _amount = TextEditingController(text: widget.existing?.amount.toString() ?? '');
    _dueDay = TextEditingController(text: widget.existing?.dueDay.toString() ?? '1');
    _isAutoPay = widget.existing?.isAutoPay ?? false;
    _categoryId = widget.existing?.categoryId;
  }

  @override
  void dispose() {
    _name.dispose();
    _amount.dispose();
    _dueDay.dispose();
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
              Text(isEditing ? 'Edit Bill' : 'New Bill', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _name,
                label: 'Bill name',
                hint: 'e.g. Rent',
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Give it a name' : null,
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
              AppTextField(
                controller: _dueDay,
                label: 'Due day of month (1-31)',
                hint: '1',
                keyboardType: TextInputType.number,
                validator: (v) {
                  final parsed = int.tryParse(v ?? '');
                  if (parsed == null || parsed < 1 || parsed > 31) return 'Enter a day between 1 and 31';
                  return null;
                },
              ),
              if (categories.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.md),
                Text('Category (optional)', style: Theme.of(context).textTheme.labelLarge),
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
              const SizedBox(height: AppSpacing.sm),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Auto-pay'),
                value: _isAutoPay,
                onChanged: (value) => setState(() => _isAutoPay = value),
              ),
              const SizedBox(height: AppSpacing.md),
              GradientPillButton(
                label: isLoading ? 'Saving…' : (isEditing ? 'Save changes' : 'Add Bill'),
                onPressed: isLoading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) return;
                        final bill = (widget.existing ?? const Bill(id: '', name: '', amount: 0)).copyWith(
                          name: _name.text.trim(),
                          amount: num.parse(_amount.text.trim()),
                          dueDay: int.parse(_dueDay.text.trim()),
                          isAutoPay: _isAutoPay,
                          categoryId: _categoryId,
                        );
                        final controller = ref.read(budgetControllerProvider.notifier);
                        if (isEditing) {
                          await controller.updateBill(bill);
                        } else {
                          await controller.addBill(bill);
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
