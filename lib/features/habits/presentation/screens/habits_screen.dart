import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../../../core/widgets/sparkline.dart';
import '../../../../core/widgets/week_day_strip.dart';
import '../../application/habits_providers.dart';
import '../widgets/add_edit_habit_sheet.dart';
import '../widgets/habit_card.dart';

class HabitsScreen extends ConsumerWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitsProvider);
    final weeklyProgressAsync = ref.watch(habitsWeeklyProgressProvider);
    final now = DateTime.now();
    final monday = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Habits'),
        leading: Navigator.canPop(context) ? const BackButton() : null,
        actions: [
          TextButton(onPressed: () {}, child: const Text('This Week')),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(habitsProvider);
          ref.invalidate(habitsWeeklyProgressProvider);
        },
        child: habitsAsync.when(
          loading: () => ListView(children: const [LoadingCardSkeleton(), LoadingCardSkeleton()]),
          error: (error, stack) => ListView(children: [Padding(padding: const EdgeInsets.all(32), child: Text('$error'))]),
          data: (habits) {
            return ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                WeekDayStrip(
                  days: const ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
                  selectedIndex: now.weekday - 1,
                  statuses: List.generate(7, (i) {
                    final day = monday.add(Duration(days: i));
                    if (day.isAfter(now)) return DayStatus.none;
                    return DayStatus.complete;
                  }),
                ),
                const SizedBox(height: AppSpacing.lg),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Overall Progress', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 4),
                      weeklyProgressAsync.when(
                        loading: () => const LoadingSkeleton(width: 80, height: 28),
                        error: (_, _) => const Text('—'),
                        data: (values) => Text(
                          '${values.isEmpty ? 0 : values.last.round()}%',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      weeklyProgressAsync.when(
                        loading: () => const SizedBox(height: 40),
                        error: (_, _) => const SizedBox(height: 40),
                        data: (values) => AppSparkline(values: values),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                if (habits.isEmpty)
                  EmptyState(
                    icon: Icons.repeat_rounded,
                    title: 'No habits yet',
                    message: 'Start a small daily habit — Flow will help you keep the streak alive.',
                    actionLabel: 'Add Habit',
                    onAction: () => showAddEditHabitSheet(context),
                  )
                else
                  for (final habit in habits)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Consumer(
                        builder: (context, ref, _) {
                          final completedToday = ref.watch(habitCompletedTodayProvider(habit.id)).value ?? false;
                          return HabitCard(
                            habit: habit,
                            completedToday: completedToday,
                            onTap: () => context.push('/habits/${habit.id}'),
                            onToggle: () => ref
                                .read(habitsControllerProvider.notifier)
                                .toggleCompletion(habit.id, wasComplete: completedToday),
                          );
                        },
                      ),
                    ),
                const SizedBox(height: AppSpacing.md),
                if (habits.isNotEmpty)
                  GradientPillButton(
                    label: 'Add Habit',
                    icon: Icons.add_rounded,
                    onPressed: () => showAddEditHabitSheet(context),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
