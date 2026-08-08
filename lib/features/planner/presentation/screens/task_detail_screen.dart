import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/badge_chip.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../application/tasks_providers.dart';
import '../../domain/task.dart';
import '../widgets/add_edit_task_sheet.dart';

class TaskDetailScreen extends ConsumerWidget {
  const TaskDetailScreen({super.key, required this.taskId});

  final String taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(tasksProvider);
    final matches = tasksAsync.value?.where((t) => t.id == taskId);
    final task = (matches == null || matches.isEmpty) ? null : matches.first;

    if (task == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final theme = Theme.of(context);
    final priorityColor = task.priority.color(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => showAddEditTaskSheet(context, existing: task),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            onPressed: () async {
              final confirmed = await showConfirmDialog(
                context,
                title: 'Delete task?',
                message: 'This removes "${task.title}" permanently.',
                confirmLabel: 'Delete',
                isDestructive: true,
              );
              if (confirmed && context.mounted) {
                await ref.read(tasksControllerProvider.notifier).deleteTask(taskId);
                if (context.mounted) context.pop();
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        task.title,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          decoration: task.isDone ? TextDecoration.lineThrough : null,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => ref.read(tasksControllerProvider.notifier).toggleStatus(task.id),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: task.isDone ? theme.colorScheme.primary : Colors.transparent,
                          border: Border.all(color: task.isDone ? theme.colorScheme.primary : theme.dividerColor, width: 2),
                        ),
                        child: task.isDone ? const Icon(Icons.check_rounded, color: Colors.white, size: 18) : null,
                      ),
                    ),
                  ],
                ),
                if (task.notes != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(task.notes!, style: theme.textTheme.bodyMedium),
                ],
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    BadgeChip(label: task.priority.label, icon: Icons.flag_rounded, color: priorityColor, tint: priorityColor.withValues(alpha: 0.14)),
                    if (task.dueDate != null)
                      BadgeChip(
                        label: task.isAllDay
                            ? DateFormat('EEE, MMM d').format(task.dueDate!)
                            : '${DateFormat('EEE, MMM d').format(task.dueDate!)}${task.dueTime != null ? ' · ${task.dueTime}' : ''}',
                        icon: Icons.event_rounded,
                      ),
                    for (final tag in task.tags) BadgeChip(label: tag, icon: Icons.label_outline_rounded),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
