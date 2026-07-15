import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_segmented_control.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../application/goals_providers.dart';
import '../../domain/goal.dart';
import '../widgets/add_edit_goal_sheet.dart';
import '../widgets/goal_card.dart';

enum _GoalFilter { active, completed, all }

class GoalsScreen extends ConsumerStatefulWidget {
  const GoalsScreen({super.key});

  @override
  ConsumerState<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends ConsumerState<GoalsScreen> {
  _GoalFilter _filter = _GoalFilter.active;

  List<Goal> _applyFilter(List<Goal> goals) {
    switch (_filter) {
      case _GoalFilter.active:
        return goals.where((g) => g.status == GoalStatus.active).toList();
      case _GoalFilter.completed:
        return goals.where((g) => g.status == GoalStatus.completed).toList();
      case _GoalFilter.all:
        return goals;
    }
  }

  @override
  Widget build(BuildContext context) {
    final goalsAsync = ref.watch(goalsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals'),
        leading: Navigator.canPop(context) ? const BackButton() : null,
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(goalsProvider),
        child: goalsAsync.when(
          loading: () => ListView(children: const [LoadingCardSkeleton(), LoadingCardSkeleton()]),
          error: (error, stack) => ListView(children: [Padding(padding: const EdgeInsets.all(32), child: Text('$error'))]),
          data: (allGoals) {
            final goals = _applyFilter(allGoals);
            return ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppSegmentedControl<_GoalFilter>(
                    options: const [
                      (_GoalFilter.active, 'Active'),
                      (_GoalFilter.completed, 'Completed'),
                      (_GoalFilter.all, 'All'),
                    ],
                    value: _filter,
                    onChanged: (value) => setState(() => _filter = value),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                if (goals.isEmpty)
                  EmptyState(
                    icon: Icons.flag_rounded,
                    title: allGoals.isEmpty ? 'No goals yet' : 'Nothing here',
                    message: allGoals.isEmpty
                        ? 'Set a goal and Flow will help you track every milestone.'
                        : 'No goals match this filter yet.',
                    actionLabel: allGoals.isEmpty ? 'Add Goal' : null,
                    onAction: allGoals.isEmpty ? () => showAddEditGoalSheet(context) : null,
                  )
                else
                  for (final goal in goals)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: GoalCard(goal: goal, onTap: () => context.push('/goals/${goal.id}')),
                    ),
                const SizedBox(height: AppSpacing.md),
                if (goals.isNotEmpty)
                  GradientPillButton(
                    label: 'Add Goal',
                    icon: Icons.add_rounded,
                    onPressed: () => showAddEditGoalSheet(context),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
