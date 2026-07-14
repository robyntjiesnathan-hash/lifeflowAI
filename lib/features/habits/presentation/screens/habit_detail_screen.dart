import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_semantic_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/badge_chip.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../application/habits_providers.dart';
import '../widgets/add_edit_habit_sheet.dart';

class HabitDetailScreen extends ConsumerWidget {
  const HabitDetailScreen({super.key, required this.habitId});

  final String habitId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitsProvider);
    final matches = habitsAsync.value?.where((h) => h.id == habitId);
    final habit = (matches == null || matches.isEmpty) ? null : matches.first;

    if (habit == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 34));
    final completionsAsync = ref.watch(habitCompletionsForRangeProvider(habitId, start: start, end: now));
    final semantic = context.semanticColors;

    return Scaffold(
      appBar: AppBar(
        title: Text(habit.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => showAddEditHabitSheet(context, existing: habit),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            onPressed: () async {
              final confirmed = await showConfirmDialog(
                context,
                title: 'Delete habit?',
                message: 'This removes "${habit.name}" and its history.',
                confirmLabel: 'Delete',
                isDestructive: true,
              );
              if (confirmed && context.mounted) {
                await ref.read(habitsControllerProvider.notifier).deleteHabit(habitId);
                if (context.mounted) context.pop();
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Row(
            children: [
              Expanded(
                child: AppCard(
                  child: Column(
                    children: [
                      Text('${habit.currentStreak}', style: Theme.of(context).textTheme.displaySmall),
                      Text('Current streak', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppCard(
                  child: Column(
                    children: [
                      Text('${habit.longestStreak}', style: Theme.of(context).textTheme.displaySmall),
                      Text('Best streak', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Last 35 days', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: AppSpacing.md),
                completionsAsync.when(
                  loading: () => const SizedBox(height: 120, child: Center(child: CircularProgressIndicator())),
                  error: (_, _) => const Text('Could not load history'),
                  data: (completions) {
                    final completedDates = completions.where((c) => c.completed).map((c) => c.date).toSet();
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 35,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 6,
                      ),
                      itemBuilder: (context, index) {
                        final day = start.add(Duration(days: index));
                        final key = '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
                        final done = completedDates.contains(key);
                        return Container(
                          decoration: BoxDecoration(
                            color: done ? habit.color : semantic.categoryPurpleTint,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (habit.reminderTime != null) BadgeChip(label: 'Reminder ${habit.reminderTime}', icon: Icons.alarm_rounded),
        ],
      ),
    );
  }
}
