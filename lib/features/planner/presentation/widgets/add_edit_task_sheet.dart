import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../application/tasks_providers.dart';
import '../../domain/task.dart';

final _dateFormat = DateFormat('EEE, MMM d');

Future<void> showAddEditTaskSheet(BuildContext context, {Task? existing, DateTime? initialDate}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: AddEditTaskSheet(existing: existing, initialDate: initialDate),
    ),
  );
}

class AddEditTaskSheet extends ConsumerStatefulWidget {
  const AddEditTaskSheet({super.key, this.existing, this.initialDate});

  final Task? existing;

  /// Pre-fills the due date for a brand-new task created from a specific
  /// day in the Planner's Day view.
  final DateTime? initialDate;

  @override
  ConsumerState<AddEditTaskSheet> createState() => _AddEditTaskSheetState();
}

class _AddEditTaskSheetState extends ConsumerState<AddEditTaskSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _notes;
  late final TextEditingController _tags;
  DateTime? _dueDate;
  TimeOfDay? _dueTime;
  bool _isAllDay = false;
  TaskPriority _priority = TaskPriority.medium;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _title = TextEditingController(text: existing?.title ?? '');
    _notes = TextEditingController(text: existing?.notes ?? '');
    _tags = TextEditingController(text: existing?.tags.join(', ') ?? '');
    _dueDate = existing?.dueDate ?? widget.initialDate;
    _isAllDay = existing?.isAllDay ?? false;
    _priority = existing?.priority ?? TaskPriority.medium;
    final existingTime = existing?.dueTime;
    if (existingTime != null) {
      final parts = existingTime.split(':');
      if (parts.length == 2) {
        _dueTime = TimeOfDay(hour: int.tryParse(parts[0]) ?? 0, minute: int.tryParse(parts[1]) ?? 0);
      }
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _notes.dispose();
    _tags.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _dueTime ?? TimeOfDay.now());
    if (picked != null) setState(() => _dueTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEditing = widget.existing != null;
    final isLoading = ref.watch(tasksControllerProvider).isLoading;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(isEditing ? 'Edit Task' : 'New Task', style: theme.textTheme.titleLarge),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _title,
                label: 'Task title',
                hint: 'e.g. Finish quarterly report',
                autofocus: !isEditing,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Give it a title' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(controller: _notes, label: 'Notes (optional)', hint: 'Add details', maxLines: 2),
              const SizedBox(height: AppSpacing.md),
              AppTextField(controller: _tags, label: 'Tags (optional)', hint: 'work, urgent'),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_today_rounded, size: 16),
                      label: Text(_dueDate == null ? 'Set date' : _dateFormat.format(_dueDate!)),
                    ),
                  ),
                  if (_dueDate != null)
                    IconButton(
                      icon: const Icon(Icons.close_rounded, size: 18),
                      onPressed: () => setState(() {
                        _dueDate = null;
                        _dueTime = null;
                      }),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                title: const Text('All day'),
                value: _isAllDay,
                onChanged: (v) => setState(() => _isAllDay = v),
              ),
              if (!_isAllDay) ...[
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton.icon(
                  onPressed: _pickTime,
                  icon: const Icon(Icons.schedule_rounded, size: 16),
                  label: Text(_dueTime == null ? 'Set time' : _dueTime!.format(context)),
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              Text('Priority', style: theme.textTheme.labelLarge),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                children: [
                  for (final priority in TaskPriority.values)
                    ChoiceChip(
                      label: Text(priority.label),
                      selected: _priority == priority,
                      onSelected: (_) => setState(() => _priority = priority),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              GradientPillButton(
                label: isLoading ? 'Saving…' : (isEditing ? 'Save changes' : 'Add Task'),
                onPressed: isLoading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) return;
                        final tags = _tags.text
                            .split(',')
                            .map((t) => t.trim())
                            .where((t) => t.isNotEmpty)
                            .toList();
                        final dueTimeStr = (_isAllDay || _dueTime == null)
                            ? null
                            : '${_dueTime!.hour.toString().padLeft(2, '0')}:${_dueTime!.minute.toString().padLeft(2, '0')}';
                        final task = (widget.existing ?? const Task(id: '', title: '')).copyWith(
                          title: _title.text.trim(),
                          notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
                          dueDate: _dueDate,
                          dueTime: dueTimeStr,
                          isAllDay: _isAllDay,
                          priority: _priority,
                          tags: tags,
                        );
                        final controller = ref.read(tasksControllerProvider.notifier);
                        if (isEditing) {
                          await controller.updateTask(task);
                        } else {
                          await controller.createTask(task);
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
