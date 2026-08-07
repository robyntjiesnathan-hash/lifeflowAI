import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_semantic_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/badge_chip.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../application/reminders_providers.dart';
import '../../domain/reminder.dart';
import '../widgets/add_edit_reminder_sheet.dart';

final _dateTimeFormat = DateFormat('EEE, MMM d · h:mm a');

class RemindersScreen extends ConsumerWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(remindersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
        leading: Navigator.canPop(context) ? const BackButton() : null,
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(remindersProvider),
        child: remindersAsync.when(
          loading: () => ListView(children: const [LoadingCardSkeleton(), LoadingCardSkeleton()]),
          error: (error, stack) =>
              ListView(children: [Padding(padding: const EdgeInsets.all(32), child: Text('$error'))]),
          data: (reminders) {
            return ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                if (reminders.isEmpty)
                  EmptyState(
                    icon: Icons.notifications_active_outlined,
                    title: 'No reminders yet',
                    message: 'Set a reminder and Flow will nudge you at the right time.',
                    actionLabel: 'Add Reminder',
                    onAction: () => showAddEditReminderSheet(context),
                  )
                else
                  for (final reminder in reminders)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: _ReminderTile(reminder: reminder),
                    ),
                const SizedBox(height: AppSpacing.md),
                if (reminders.isNotEmpty)
                  GradientPillButton(
                    label: 'Add Reminder',
                    icon: Icons.add_rounded,
                    onPressed: () => showAddEditReminderSheet(context),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ReminderTile extends ConsumerWidget {
  const _ReminderTile({required this.reminder});

  final Reminder reminder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final semantic = context.semanticColors;
    return AppCard(
      onTap: () => showAddEditReminderSheet(context, existing: reminder),
      child: Row(
        children: [
          // Every reminder row previously had zero leading visual — no icon
          // chip at all, so the list had no visual anchor. Matches the same
          // pink used for "Smart Reminders" on Profile.
          CategoryIconChip(
            icon: Icons.notifications_active_rounded,
            color: semantic.categoryPink,
            tint: semantic.categoryPinkTint,
            size: 40,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(reminder.title, style: theme.textTheme.titleMedium),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.schedule_rounded, size: 13, color: theme.textTheme.bodySmall?.color),
                    const SizedBox(width: 4),
                    Text(_dateTimeFormat.format(reminder.scheduledAt), style: theme.textTheme.bodySmall),
                  ],
                ),
                if (reminder.repeat != ReminderRepeat.none) ...[
                  const SizedBox(height: AppSpacing.xs),
                  BadgeChip(label: 'Repeats ${reminder.repeat.name}', icon: Icons.repeat_rounded),
                ],
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            onPressed: () async {
              final confirmed = await showConfirmDialog(
                context,
                title: 'Delete reminder?',
                message: 'This removes "${reminder.title}" and cancels its notification.',
                confirmLabel: 'Delete',
                isDestructive: true,
              );
              if (confirmed) {
                await ref.read(remindersControllerProvider.notifier).deleteReminder(reminder);
              }
            },
          ),
          Switch.adaptive(
            value: reminder.isEnabled,
            onChanged: (v) => ref.read(remindersControllerProvider.notifier).setEnabled(reminder, v),
          ),
        ],
      ),
    );
  }
}
