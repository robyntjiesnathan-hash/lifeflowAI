import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/task.dart';

/// Vertical-timeline task row with a colored priority left-bar and a
/// checkbox-style completion toggle, matching the Planner mockup's Day
/// view.
class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task, required this.onToggle, this.onTap});

  final Task task;
  final VoidCallback onToggle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final priorityColor = task.priority.color(context);
    final done = task.isDone;

    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: priorityColor,
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(AppRadii.card)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              decoration: done ? TextDecoration.lineThrough : null,
                              color: done ? theme.textTheme.bodySmall?.color : null,
                            ),
                          ),
                          if (task.dueTime != null || task.notes != null) ...[
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                if (task.dueTime != null) ...[
                                  Icon(Icons.schedule_rounded, size: 13, color: theme.textTheme.bodySmall?.color),
                                  const SizedBox(width: 4),
                                  Text(task.dueTime!, style: theme.textTheme.bodySmall),
                                  if (task.notes != null) const SizedBox(width: AppSpacing.sm),
                                ],
                                if (task.notes != null)
                                  Expanded(
                                    child: Text(
                                      task.notes!,
                                      style: theme.textTheme.bodySmall,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    GestureDetector(
                      onTap: onToggle,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: done ? theme.colorScheme.primary : Colors.transparent,
                          border: Border.all(color: done ? theme.colorScheme.primary : theme.dividerColor, width: 2),
                        ),
                        child: done ? const Icon(Icons.check_rounded, color: Colors.white, size: 16) : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
