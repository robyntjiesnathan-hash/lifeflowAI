import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../application/reminders_providers.dart';
import '../../domain/reminder.dart';

final _dateTimeFormat = DateFormat('EEE, MMM d · h:mm a');

Future<void> showAddEditReminderSheet(BuildContext context, {Reminder? existing}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: AddEditReminderSheet(existing: existing),
    ),
  );
}

class AddEditReminderSheet extends ConsumerStatefulWidget {
  const AddEditReminderSheet({super.key, this.existing});

  final Reminder? existing;

  @override
  ConsumerState<AddEditReminderSheet> createState() => _AddEditReminderSheetState();
}

class _AddEditReminderSheetState extends ConsumerState<AddEditReminderSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late DateTime _scheduledAt;
  ReminderRepeat _repeat = ReminderRepeat.none;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _title = TextEditingController(text: existing?.title ?? '');
    _scheduledAt = existing?.scheduledAt ?? DateTime.now().add(const Duration(hours: 1));
    _repeat = existing?.repeat ?? ReminderRepeat.none;
  }

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _scheduledAt.isBefore(now) ? now : _scheduledAt,
      firstDate: now.subtract(const Duration(days: 1)),
      lastDate: DateTime(now.year + 5),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(_scheduledAt));
    if (time == null) return;
    setState(() => _scheduledAt = DateTime(date.year, date.month, date.day, time.hour, time.minute));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEditing = widget.existing != null;
    final isLoading = ref.watch(remindersControllerProvider).isLoading;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(isEditing ? 'Edit Reminder' : 'New Reminder', style: theme.textTheme.titleLarge),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _title,
                label: 'Reminder title',
                hint: 'e.g. Drink water',
                autofocus: !isEditing,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Give it a title' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              OutlinedButton.icon(
                onPressed: _pickDateTime,
                icon: const Icon(Icons.schedule_rounded, size: 16),
                label: Text(_dateTimeFormat.format(_scheduledAt)),
              ),
              const SizedBox(height: AppSpacing.md),
              Text('Repeat', style: theme.textTheme.labelLarge),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                children: [
                  for (final repeat in ReminderRepeat.values)
                    ChoiceChip(
                      label: Text(repeat.name),
                      selected: _repeat == repeat,
                      onSelected: (_) => setState(() => _repeat = repeat),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              GradientPillButton(
                label: isLoading ? 'Saving…' : (isEditing ? 'Save changes' : 'Add Reminder'),
                onPressed: isLoading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) return;
                        final reminder = (widget.existing ?? Reminder(id: '', title: '', scheduledAt: _scheduledAt))
                            .copyWith(title: _title.text.trim(), scheduledAt: _scheduledAt, repeat: _repeat);
                        final controller = ref.read(remindersControllerProvider.notifier);
                        if (isEditing) {
                          await controller.updateReminder(reminder);
                        } else {
                          await controller.createReminder(reminder);
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
