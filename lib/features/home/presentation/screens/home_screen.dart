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
import '../../../gamification/application/gamification_service.dart';
import '../../../habits/application/habits_providers.dart';
import '../../../habits/domain/habit.dart';
import '../../../profile/application/user_profile_providers.dart';

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

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(habitsProvider);
            ref.invalidate(currentUserProfileProvider);
          },
          child: ListView(
            padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, 100),
            children: [
              _HomeHeader(greeting: _greeting(), name: displayName),
              const SizedBox(height: AppSpacing.lg),
              _DailyProgressCard(habits: habits),
              const SizedBox(height: AppSpacing.lg),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _TodayScheduleCard()),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: _HabitsPreviewCard(habits: habits)),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              const _MealPlanCard(),
              const SizedBox(height: AppSpacing.lg),
              const _BudgetTodayCard(),
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
          onPressed: () {},
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
  const _DailyProgressCard({required this.habits});

  final List<Habit> habits;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final habitsMet = habits.where((h) => h.currentStreak > 0).length;
    final habitsTotal = habits.length;
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
                _StatLine(icon: Icons.check_circle_outline_rounded, label: 'Tasks Done', value: '— / —'),
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
  const _TodayScheduleCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      onTap: () => GoRouter.of(context).push(RoutePaths.planner),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: "Today's Schedule"),
          Icon(Icons.calendar_today_rounded, color: theme.colorScheme.primary, size: 20),
          const SizedBox(height: AppSpacing.sm),
          Text('Open Planner to see your day', style: theme.textTheme.bodySmall),
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

class _MealPlanCard extends StatelessWidget {
  const _MealPlanCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final semantic = context.semanticColors;
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
                Text('Breakfast', style: theme.textTheme.bodySmall),
                Text('Plan your meals for today', style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(color: semantic.categoryTealTint, borderRadius: BorderRadius.circular(AppRadii.md)),
            child: Icon(Icons.restaurant_rounded, color: semantic.categoryTeal),
          ),
        ],
      ),
    );
  }
}

class _BudgetTodayCard extends StatelessWidget {
  const _BudgetTodayCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              Text('Budget', style: theme.textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('—', style: theme.textTheme.titleMedium),
              Text('—', style: theme.textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.pill),
            child: LinearProgressIndicator(value: 0, minHeight: 8),
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
