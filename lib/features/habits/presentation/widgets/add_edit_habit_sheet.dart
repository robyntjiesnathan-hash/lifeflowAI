import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../application/habits_providers.dart';
import '../../domain/habit.dart';

Future<void> showAddEditHabitSheet(BuildContext context, {Habit? existing}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: AddEditHabitSheet(existing: existing),
    ),
  );
}

class AddEditHabitSheet extends ConsumerStatefulWidget {
  const AddEditHabitSheet({super.key, this.existing});

  final Habit? existing;

  @override
  ConsumerState<AddEditHabitSheet> createState() => _AddEditHabitSheetState();
}

class _AddEditHabitSheetState extends ConsumerState<AddEditHabitSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _subtitle;
  HabitIconKey _iconKey = HabitIconKey.custom;
  HabitFrequency _frequency = HabitFrequency.daily;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.existing?.name ?? '');
    _subtitle = TextEditingController(text: widget.existing?.subtitle ?? '');
    _iconKey = widget.existing?.iconKey ?? HabitIconKey.custom;
    _frequency = widget.existing?.frequency ?? HabitFrequency.daily;
  }

  @override
  void dispose() {
    _name.dispose();
    _subtitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existing != null;
    final isLoading = ref.watch(habitsControllerProvider).isLoading;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(isEditing ? 'Edit Habit' : 'New Habit', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _name,
                label: 'Habit name',
                hint: 'e.g. Meditate',
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Give it a name' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(controller: _subtitle, label: 'Note (optional)', hint: 'e.g. 10 min'),
              const SizedBox(height: AppSpacing.md),
              Text('Icon', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                children: [
                  for (final icon in HabitIconKey.values)
                    ChoiceChip(
                      avatar: Icon(icon.icon, size: 16),
                      label: Text(icon.name),
                      selected: _iconKey == icon,
                      onSelected: (_) => setState(() => _iconKey = icon),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text('Frequency', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                children: [
                  for (final freq in HabitFrequency.values)
                    ChoiceChip(
                      label: Text(freq.name),
                      selected: _frequency == freq,
                      onSelected: (_) => setState(() => _frequency = freq),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              GradientPillButton(
                label: isLoading ? 'Saving…' : (isEditing ? 'Save changes' : 'Add Habit'),
                onPressed: isLoading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) return;
                        final habit = (widget.existing ?? const Habit(id: '', name: '')).copyWith(
                          name: _name.text.trim(),
                          subtitle: _subtitle.text.trim().isEmpty ? null : _subtitle.text.trim(),
                          iconKey: _iconKey,
                          frequency: _frequency,
                        );
                        final controller = ref.read(habitsControllerProvider.notifier);
                        if (isEditing) {
                          await controller.updateHabit(habit);
                        } else {
                          await controller.createHabit(habit);
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
