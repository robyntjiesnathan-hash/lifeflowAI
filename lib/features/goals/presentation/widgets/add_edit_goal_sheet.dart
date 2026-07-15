import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../application/goals_providers.dart';
import '../../domain/goal.dart';

final _dateFormat = DateFormat('MMM d, yyyy');

Future<void> showAddEditGoalSheet(BuildContext context, {Goal? existing}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: AddEditGoalSheet(existing: existing),
    ),
  );
}

class AddEditGoalSheet extends ConsumerStatefulWidget {
  const AddEditGoalSheet({super.key, this.existing});

  final Goal? existing;

  @override
  ConsumerState<AddEditGoalSheet> createState() => _AddEditGoalSheetState();
}

class _AddEditGoalSheetState extends ConsumerState<AddEditGoalSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _description;
  GoalCategory _category = GoalCategory.other;
  GoalProgressMode _progressMode = GoalProgressMode.milestoneBased;
  DateTime? _targetDate;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.existing?.title ?? '');
    _description = TextEditingController(text: widget.existing?.description ?? '');
    _category = widget.existing?.category ?? GoalCategory.other;
    _progressMode = widget.existing?.progressMode ?? GoalProgressMode.milestoneBased;
    _targetDate = widget.existing?.targetDate;
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _pickTargetDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _targetDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 10),
    );
    if (picked != null) setState(() => _targetDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existing != null;
    final isLoading = ref.watch(goalsControllerProvider).isLoading;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(isEditing ? 'Edit Goal' : 'New Goal', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _title,
                label: 'Goal title',
                hint: 'e.g. Save \$5,000',
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Give it a title' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(controller: _description, label: 'Description (optional)', hint: 'e.g. Emergency fund'),
              const SizedBox(height: AppSpacing.md),
              Text('Category', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                children: [
                  for (final category in GoalCategory.values)
                    ChoiceChip(
                      avatar: Icon(category.icon, size: 16),
                      label: Text(category.name),
                      selected: _category == category,
                      onSelected: (_) => setState(() => _category = category),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text('Progress tracking', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                children: [
                  for (final mode in GoalProgressMode.values)
                    ChoiceChip(
                      label: Text(mode == GoalProgressMode.milestoneBased ? 'Milestones' : 'Manual %'),
                      selected: _progressMode == mode,
                      onSelected: (_) => setState(() => _progressMode = mode),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text('Target date', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton.icon(
                onPressed: _pickTargetDate,
                icon: const Icon(Icons.calendar_today_rounded, size: 16),
                label: Text(_targetDate == null ? 'Pick a date' : _dateFormat.format(_targetDate!)),
              ),
              const SizedBox(height: AppSpacing.lg),
              GradientPillButton(
                label: isLoading ? 'Saving…' : (isEditing ? 'Save changes' : 'Add Goal'),
                onPressed: isLoading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) return;
                        final goal = (widget.existing ?? const Goal(id: '', title: '')).copyWith(
                          title: _title.text.trim(),
                          description: _description.text.trim(),
                          category: _category,
                          progressMode: _progressMode,
                          targetDate: _targetDate,
                        );
                        final controller = ref.read(goalsControllerProvider.notifier);
                        if (isEditing) {
                          await controller.updateGoal(goal);
                        } else {
                          await controller.createGoal(goal);
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
