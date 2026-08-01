import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_paths.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_semantic_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/flow_mascot.dart';
import '../../../../core/widgets/progress_ring.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../budget/application/budget_providers.dart';
import '../../../gamification/application/gamification_service.dart';
import '../../../habits/application/habits_providers.dart';
import '../../../habits/domain/habit.dart';
import '../../../meals/application/meals_providers.dart';
import '../../../meals/domain/meal_plan.dart';
import '../../../meals/domain/recipe.dart';
import '../../../planner/application/tasks_providers.dart';
import '../../../planner/domain/task.dart';
import '../../../profile/application/user_profile_providers.dart';

bool _isSameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(currentUserProfileProvider);
    final user = ref.watch(authStateChangesProvider).value;
    final habitsAsync = ref.watch(habitsProvider);
    final habits = habitsAsync.value ?? const [];
    final uid = user?.uid;
    final summaryAsync = uid == null ? null : ref.watch(gamificationSummaryProvider(uid));
    final name = profileAsync.value?.displayName?.trim();
    final displayName = (name == null || name.isEmpty) ? (user?.displayName ?? 'there') : name;

    final tasks = ref.watch(tasksProvider).value ?? const <Task>[];
    final now = DateTime.now();
    final todaysTasks = tasks.where((t) => t.dueDate != null && _isSameDay(t.dueDate!, now)).toList()
      ..sort((a, b) => (a.dueTime ?? '').compareTo(b.dueTime ?? ''));

    final mealPlanAsync = ref.watch(currentWeekMealPlanProvider);
    final recipesAsync = ref.watch(recipesProvider);
    final budgetSummaryAsync = ref.watch(todayBudgetSummaryProvider);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(habitsProvider);
            ref.invalidate(currentUserProfileProvider);
            ref.invalidate(tasksProvider);
            ref.invalidate(currentWeekMealPlanProvider);
            ref.invalidate(todayBudgetSummaryProvider);
          },
          child: ListView(
            padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, 100),
            children: [
              _HomeHeader(greeting: _greeting(), name: displayName),
              const SizedBox(height: AppSpacing.lg),
              _DailyProgressCard(habits: habits, todaysTasks: todaysTasks),
              const SizedBox(height: AppSpacing.lg),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _TodayScheduleCard(todaysTasks: todaysTasks)),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: _HabitsPreviewCard(habits: habits)),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              _MealPlanCard(mealPlanAsync: mealPlanAsync, recipesAsync: recipesAsync),
              const SizedBox(height: AppSpacing.lg),
              _BudgetTodayCard(summaryAsync: budgetSummaryAsync),
              const SizedBox(height: AppSpacing.lg),
              _AiCoachCard(
                streakDays: summaryAsync?.value?.currentStreakDays ?? 0,
                onTap: () => context.push(RoutePaths.coach),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.greeting, required this.name});

  final String greeting;
  final String name;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$greeting, $name! ☀️', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 2),
              Text("Let's make today amazing.", style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
        IconButton(
          onPressed: () => GoRouter.of(context).push(RoutePaths.reminders),
          icon: Icon(Icons.notifications_none_rounded, color: theme.textTheme.headlineSmall?.color),
        ),
        GestureDetector(
          onTap: () => GoRouter.of(context).push(RoutePaths.profile),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.15),
            child: Icon(Icons.person_rounded, color: theme.colorScheme.primary),
          ),
        ),
      ],
    );
  }
}

class _DailyProgressCard extends StatelessWidget {
  const _DailyProgressCard({required this.habits, required this.todaysTasks});

  final List<Habit> habits;
  final List<Task> todaysTasks;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final habitsMet = habits.where((h) => h.currentStreak > 0).length;
    final habitsTotal = habits.length;
    final tasksDone = todaysTasks.where((t) => t.isDone).length;
    final tasksTotal = todaysTasks.length;
    final percent = habitsTotal == 0 ? 0.0 : habitsMet / habitsTotal;

    return AppCard(
      child: Row(
        children: [
          AppProgressRing(
            percent: percent,
            size: 110,
            center: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${(percent * 100).round()}%', style: theme.textTheme.headlineMedium),
                Text('doing great!', style: theme.textTheme.bodySmall),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Daily Progress', style: theme.textTheme.titleMedium),
                _StatLine(
                  icon: Icons.check_circle_outline_rounded,
                  label: 'Tasks Done',
                  value: tasksTotal == 0 ? '0 / 0' : '$tasksDone / $tasksTotal',
                ),
                _StatLine(icon: Icons.repeat_rounded, label: 'Habits Met', value: '$habitsMet / $habitsTotal'),
                _StatLine(icon: Icons.timer_outlined, label: 'Focus Time', value: '—'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatLine extends StatelessWidget {
  const _StatLine({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.primary),
          const SizedBox(width: 6),
          Expanded(child: Text(label, style: theme.textTheme.bodySmall)),
          Text(value, style: theme.textTheme.labelLarge),
        ],
      ),
    );
  }
}

class _TodayScheduleCard extends StatelessWidget {
  const _TodayScheduleCard({required this.todaysTasks});

  final List<Task> todaysTasks;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      onTap: () => GoRouter.of(context).push(RoutePaths.planner),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: "Today's Schedule"),
          if (todaysTasks.isEmpty) ...[
            Icon(Icons.calendar_today_rounded, color: theme.colorScheme.primary, size: 20),
            const SizedBox(height: AppSpacing.sm),
            Text('Nothing scheduled today', style: theme.textTheme.bodySmall),
          ] else
            for (final task in todaysTasks.take(3))
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        task.title,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          decoration: task.isDone ? TextDecoration.lineThrough : null,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      task.isDone ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                      size: 18,
                      color: task.isDone ? theme.colorScheme.primary : theme.dividerColor,
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}

class _HabitsPreviewCard extends StatelessWidget {
  const _HabitsPreviewCard({required this.habits});

  final List<Habit> habits;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      onTap: () => GoRouter.of(context).push(RoutePaths.habits),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: 'Habits', actionLabel: 'View all', onAction: () => GoRouter.of(context).push(RoutePaths.habits)),
          if (habits.isEmpty)
            Text('No habits yet', style: theme.textTheme.bodySmall)
          else
            for (final habit in habits.take(3))
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(child: Text(habit.name, style: theme.textTheme.bodyMedium, overflow: TextOverflow.ellipsis)),
                    Icon(
                      habit.currentStreak > 0 ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                      size: 18,
                      color: habit.currentStreak > 0 ? theme.colorScheme.primary : theme.dividerColor,
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}

/// Picks the meal slot most relevant to the current time of day, so the
/// Home card always shows "what's next" rather than always Breakfast.
MealSlot _currentMealSlot() {
  final hour = DateTime.now().hour;
  if (hour < 11) return MealSlot.breakfast;
  if (hour < 15) return MealSlot.lunch;
  if (hour < 21) return MealSlot.dinner;
  return MealSlot.snack;
}

class _MealPlanCard extends StatelessWidget {
  const _MealPlanCard({required this.mealPlanAsync, required this.recipesAsync});

  final AsyncValue<MealPlan> mealPlanAsync;
  final AsyncValue<List<Recipe>> recipesAsync;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final semantic = context.semanticColors;
    final slot = _currentMealSlot();
    final todayKey = MealPlanWeek.weekdayKeys[DateTime.now().weekday - 1];

    final recipeId = mealPlanAsync.value?.recipeIdFor(todayKey, slot.key);
    Recipe? recipe;
    if (recipeId != null) {
      final recipes = recipesAsync.value ?? const <Recipe>[];
      for (final r in recipes) {
        if (r.id == recipeId) {
          recipe = r;
          break;
        }
      }
    }

    return AppCard(
      onTap: () => GoRouter.of(context).push(RoutePaths.meals),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Meal Plan', style: theme.textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(slot.label, style: theme.textTheme.bodySmall),
                Text(
                  recipe?.title ?? 'Plan your meals for today',
                  style: theme.textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(color: semantic.categoryTealTint, borderRadius: BorderRadius.circular(AppRadii.md)),
            child: Icon(slot.icon, color: semantic.categoryTeal),
          ),
        ],
      ),
    );
  }
}

class _BudgetTodayCard extends StatelessWidget {
  const _BudgetTodayCard({required this.summaryAsync});

  final AsyncValue<BudgetTodaySummary> summaryAsync;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final summary = summaryAsync.value;
    final spentToday = summary?.spentToday ?? 0;
    final budgetTarget = summary?.budgetTarget ?? 0;
    final percent = budgetTarget > 0 ? (spentToday / budgetTarget).clamp(0.0, 1.0).toDouble() : 0.0;

    return AppCard(
      onTap: () => GoRouter.of(context).push(RoutePaths.budget),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Budget Today', style: theme.textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Spent', style: theme.textTheme.bodySmall),
              Text('Monthly budget', style: theme.textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${spentToday.toStringAsFixed(2)}', style: theme.textTheme.titleMedium),
              Text('\$${budgetTarget.toStringAsFixed(2)}', style: theme.textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.pill),
            child: LinearProgressIndicator(value: percent, minHeight: 8),
          ),
        ],
      ),
    );
  }
}

class _AiCoachCard extends StatelessWidget {
  const _AiCoachCard({required this.streakDays, required this.onTap});

  final int streakDays;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GradientHeroCard(
      gradient: AppGradients.aiCoach,
      onTap: onTap,
      child: Row(
        children: [
          const FlowMascot(size: 56),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI Coach', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),
                const SizedBox(height: 4),
                Text(
                  streakDays > 0
                      ? "You're on a $streakDays-day streak! Keep the momentum going."
                      : 'Ready when you are — ask Flow anything.',
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: const [
                    Text('Chat with Flow', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
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
