import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../application/budget_providers.dart';
import '../../domain/budget_profile.dart';

/// Lets the user set their own monthly budget target (defaults to a flat
/// 2000 with no way to change it otherwise — [BudgetProfile.monthlyBudgetTarget]
/// already supports being saved via [BudgetController.saveProfile], it just
/// had no UI pointed at it).
Future<void> showEditBudgetTargetSheet(BuildContext context, {required BudgetProfile profile}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: _EditBudgetTargetSheet(profile: profile),
    ),
  );
}

class _EditBudgetTargetSheet extends ConsumerStatefulWidget {
  const _EditBudgetTargetSheet({required this.profile});

  final BudgetProfile profile;

  @override
  ConsumerState<_EditBudgetTargetSheet> createState() => _EditBudgetTargetSheetState();
}

class _EditBudgetTargetSheetState extends ConsumerState<_EditBudgetTargetSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _target;

  @override
  void initState() {
    super.initState();
    final target = widget.profile.monthlyBudgetTarget;
    _target = TextEditingController(text: target == target.roundToDouble() ? target.toInt().toString() : target.toString());
  }

  @override
  void dispose() {
    _target.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(budgetControllerProvider).isLoading;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Monthly Budget', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.xs),
              Text(
                "How much you're aiming to spend this month — Home and Budget track your progress against it.",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _target,
                label: 'Amount (${widget.profile.currency})',
                hint: '2000',
                autofocus: true,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  final parsed = num.tryParse(v ?? '');
                  if (parsed == null || parsed <= 0) return 'Enter a valid amount';
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              GradientPillButton(
                label: isLoading ? 'Saving…' : 'Save',
                onPressed: isLoading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) return;
                        final target = num.parse(_target.text.trim());
                        await ref
                            .read(budgetControllerProvider.notifier)
                            .saveProfile(widget.profile.copyWith(monthlyBudgetTarget: target));
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
