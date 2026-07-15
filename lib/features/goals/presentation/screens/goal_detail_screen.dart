import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/badge_chip.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/progress_ring.dart';
import '../../application/goals_providers.dart';
import '../../domain/goal.dart';
import '../../domain/milestone.dart';
import '../widgets/add_edit_goal_sheet.dart';

final _dateFormat = DateFormat('MMM d, yyyy');

class GoalDetailScreen extends ConsumerWidget {
  const GoalDetailScreen({super.key, required this.goalId});

  final String goalId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalsAsync = ref.watch(goalsProvider);
    final matches = goalsAsync.value?.where((g) => g.id == goalId);
    final goal = (matches == null || matches.isEmpty) ? null : matches.first;

    if (goal == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(goal.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => showAddEditGoalSheet(context, existing: goal),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            onPressed: () async {
              final confirmed = await showConfirmDialog(
                context,
                title: 'Delete goal?',
                message: 'This removes "${goal.title}" and its milestones.',
                confirmLabel: 'Delete',
                isDestructive: true,
              );
              if (confirmed && context.mounted) {
                await ref.read(goalsControllerProvider.notifier).deleteGoal(goalId);
                if (context.mounted) Navigator.of(context).pop();
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
              children: [
                AppProgressRing(
                  percent: goal.progressFraction,
                  color: goal.category.color,
                  center: Text(
                    '${(goal.progressFraction * 100).round()}%',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  alignment: WrapAlignment.center,
                  children: [
                    BadgeChip(label: goal.category.name, icon: goal.category.icon, color: goal.category.color, tint: goal.category.tint),
                    if (goal.targetDate != null)
                      BadgeChip(label: _dateFormat.format(goal.targetDate!), icon: Icons.event_rounded),
                    if (goal.status == GoalStatus.completed)
                      const BadgeChip(label: 'Completed', icon: Icons.check_circle_rounded),
                  ],
                ),
                if (goal.description.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.md),
                  Text(goal.description, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (goal.progressMode == GoalProgressMode.manual)
            _ManualProgressCard(goal: goal)
          else
            _MilestonesCard(goalId: goalId),
        ],
      ),
    );
  }
}

class _ManualProgressCard extends ConsumerWidget {
  const _ManualProgressCard({required this.goal});

  final Goal goal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(goalsControllerProvider).isLoading;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Progress', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          Slider(
            value: goal.progressFraction,
            onChanged: isLoading
                ? null
                : (value) => ref
                    .read(goalsControllerProvider.notifier)
                    .updateManualProgress(goal.id, (value * 100).roundToDouble()),
          ),
        ],
      ),
    );
  }
}

class _MilestonesCard extends ConsumerStatefulWidget {
  const _MilestonesCard({required this.goalId});

  final String goalId;

  @override
  ConsumerState<_MilestonesCard> createState() => _MilestonesCardState();
}

class _MilestonesCardState extends ConsumerState<_MilestonesCard> {
  final _newMilestoneController = TextEditingController();

  @override
  void dispose() {
    _newMilestoneController.dispose();
    super.dispose();
  }

  Future<void> _addMilestone() async {
    final title = _newMilestoneController.text.trim();
    if (title.isEmpty) return;
    await ref.read(goalsControllerProvider.notifier).addMilestone(widget.goalId, Milestone(id: '', title: title));
    _newMilestoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final milestonesAsync = ref.watch(goalMilestonesProvider(widget.goalId));
    final isLoading = ref.watch(goalsControllerProvider).isLoading;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Milestones', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          milestonesAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, _) => const Text('Could not load milestones'),
            data: (milestones) {
              if (milestones.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  child: Text('No milestones yet — add the first step below.', style: Theme.of(context).textTheme.bodySmall),
                );
              }
              return Column(
                children: [
                  for (final milestone in milestones)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Checkbox(
                        value: milestone.isDone,
                        onChanged: isLoading
                            ? null
                            : (_) => ref
                                .read(goalsControllerProvider.notifier)
                                .toggleMilestone(widget.goalId, milestone.id),
                      ),
                      title: Text(
                        milestone.title,
                        style: milestone.isDone
                            ? Theme.of(context).textTheme.bodyLarge?.copyWith(decoration: TextDecoration.lineThrough)
                            : Theme.of(context).textTheme.bodyLarge,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.close_rounded, size: 18),
                        onPressed: isLoading
                            ? null
                            : () => ref
                                .read(goalsControllerProvider.notifier)
                                .deleteMilestone(widget.goalId, milestone.id),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: _newMilestoneController,
                  label: '',
                  hint: 'Add a milestone…',
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              IconButton.filled(
                onPressed: isLoading ? null : _addMilestone,
                icon: const Icon(Icons.add_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
