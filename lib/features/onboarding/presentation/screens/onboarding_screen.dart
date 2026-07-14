import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/services/local_notification_service.dart';
import '../../../profile/domain/user_profile.dart';
import '../../application/onboarding_controller.dart';

const _goalOptions = [
  'Be more productive',
  'Build better habits',
  'Save money',
  'Eat healthier',
  'Reduce stress',
  'Learn something new',
  'Sleep better',
  'Get fit',
];

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _step = 0;
  static const int _stepCount = 7;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next() {
    if (_step == _stepCount - 1) {
      final draft = ref.read(onboardingDraftProvider);
      ref.read(onboardingControllerProvider.notifier).completeOnboarding(draft);
      return;
    }
    setState(() => _step++);
    _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  void _back() {
    if (_step == 0) return;
    setState(() => _step--);
    _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(onboardingControllerProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.error.toString())));
      }
    });
    final isSaving = ref.watch(onboardingControllerProvider).isLoading;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
              child: Row(
                children: [
                  if (_step > 0) IconButton(onPressed: _back, icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadii.pill),
                        child: LinearProgressIndicator(value: (_step + 1) / _stepCount, minHeight: 6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  _IdentityStep(),
                  _RhythmStep(),
                  _GoalsStep(),
                  _CoachingStyleStep(),
                  _PreferencesStep(),
                  _NotificationsStep(),
                  _SummaryStep(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: GradientPillButton(
                label: isSaving ? 'Saving…' : (_step == _stepCount - 1 ? "Let's go!" : 'Continue'),
                onPressed: isSaving ? null : _next,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepScaffold extends StatelessWidget {
  const _StepScaffold({required this.title, required this.subtitle, required this.child});

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.xs),
          Text(subtitle, style: theme.textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.lg),
          child,
        ],
      ),
    );
  }
}

class _IdentityStep extends ConsumerWidget {
  const _IdentityStep();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(onboardingDraftProvider);
    final notifier = ref.read(onboardingDraftProvider.notifier);
    return _StepScaffold(
      title: 'Nice to meet you!',
      subtitle: "Let's personalize LifeFlow AI around your life.",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            label: 'What should Flow call you?',
            hint: 'Your name',
            onChangedController: (v) => notifier.update((d) => d.copyWith(displayName: v)),
            initialValue: draft.displayName,
          ),
          const SizedBox(height: AppSpacing.md),
          Text('Age range', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              for (final range in ['<18', '18-24', '25-34', '35-44', '45-54', '55+'])
                ChoiceChip(
                  label: Text(range),
                  selected: draft.ageRange == range,
                  onSelected: (_) => notifier.update((d) => d.copyWith(ageRange: range)),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: 'Occupation (optional)',
            hint: 'e.g. Software Engineer',
            onChangedController: (v) => notifier.update((d) => d.copyWith(occupation: v)),
            initialValue: draft.occupation,
          ),
        ],
      ),
    );
  }
}

class _RhythmStep extends ConsumerWidget {
  const _RhythmStep();

  Future<void> _pickTime(BuildContext context, WidgetRef ref, {required bool isWake}) async {
    final draft = ref.read(onboardingDraftProvider);
    final current = isWake ? draft.wakeTime : draft.sleepTime;
    final parts = current.split(':');
    final initial = TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    final picked = await showTimePicker(context: context, initialTime: initial);
    if (picked == null) return;
    final formatted = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
    ref.read(onboardingDraftProvider.notifier).update(
          (d) => isWake ? d.copyWith(wakeTime: formatted) : d.copyWith(sleepTime: formatted),
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(onboardingDraftProvider);
    return _StepScaffold(
      title: 'Your daily rhythm',
      subtitle: 'So Flow can plan around your day, not against it.',
      child: Row(
        children: [
          Expanded(
            child: _TimeCard(
              icon: Icons.wb_sunny_rounded,
              label: 'Wake up',
              time: draft.wakeTime,
              onTap: () => _pickTime(context, ref, isWake: true),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: _TimeCard(
              icon: Icons.bedtime_rounded,
              label: 'Sleep',
              time: draft.sleepTime,
              onTap: () => _pickTime(context, ref, isWake: false),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeCard extends StatelessWidget {
  const _TimeCard({required this.icon, required this.label, required this.time, required this.onTap});

  final IconData icon;
  final String label;
  final String time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadii.lg),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppRadii.lg),
        ),
        child: Column(
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            const SizedBox(height: AppSpacing.xs),
            Text(label, style: theme.textTheme.labelMedium),
            const SizedBox(height: 4),
            Text(time, style: theme.textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}

class _GoalsStep extends ConsumerWidget {
  const _GoalsStep();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(onboardingDraftProvider);
    final notifier = ref.read(onboardingDraftProvider.notifier);
    return _StepScaffold(
      title: "What's on your mind?",
      subtitle: 'Pick what you want LifeFlow AI to help you focus on. Choose as many as you like.',
      child: Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: [
          for (final goal in _goalOptions)
            FilterChip(
              label: Text(goal),
              selected: draft.primaryGoals.contains(goal),
              onSelected: (selected) => notifier.update(
                (d) => d.copyWith(
                  primaryGoals: selected ? [...d.primaryGoals, goal] : d.primaryGoals.where((g) => g != goal).toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CoachingStyleStep extends ConsumerWidget {
  const _CoachingStyleStep();

  static const _styles = {
    CoachingStyle.supportive: ('Supportive', 'Warm encouragement and gentle nudges', Icons.favorite_rounded),
    CoachingStyle.direct: ('Direct', 'Straight to the point, no fluff', Icons.bolt_rounded),
    CoachingStyle.analytical: ('Analytical', 'Data-driven insights and tradeoffs', Icons.insights_rounded),
    CoachingStyle.playful: ('Playful', 'Upbeat, fun, a little cheeky', Icons.celebration_rounded),
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(onboardingDraftProvider);
    final notifier = ref.read(onboardingDraftProvider.notifier);
    return _StepScaffold(
      title: 'How should Flow coach you?',
      subtitle: 'You can change this anytime in settings.',
      child: Column(
        children: [
          for (final entry in _styles.entries)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _StyleCard(
                icon: entry.value.$3,
                title: entry.value.$1,
                subtitle: entry.value.$2,
                selected: draft.coachingStyle == entry.key,
                onTap: () => notifier.update((d) => d.copyWith(coachingStyle: entry.key)),
              ),
            ),
        ],
      ),
    );
  }
}

class _StyleCard extends StatelessWidget {
  const _StyleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadii.lg),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: selected ? theme.colorScheme.primary.withValues(alpha: 0.1) : theme.cardTheme.color,
          borderRadius: BorderRadius.circular(AppRadii.lg),
          border: Border.all(color: selected ? theme.colorScheme.primary : Colors.transparent, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.titleMedium),
                  Text(subtitle, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            if (selected) Icon(Icons.check_circle_rounded, color: theme.colorScheme.primary),
          ],
        ),
      ),
    );
  }
}

class _PreferencesStep extends ConsumerWidget {
  const _PreferencesStep();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(onboardingDraftProvider);
    final notifier = ref.read(onboardingDraftProvider.notifier);
    return _StepScaffold(
      title: 'Which areas matter most?',
      subtitle: 'This shapes what shows up first on your Home dashboard.',
      child: Column(
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Budget tracking'),
            subtitle: const Text('Expenses, income, and savings goals'),
            value: draft.budgetTrackingEnabled,
            onChanged: (v) => notifier.update((d) => d.copyWith(budgetTrackingEnabled: v)),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Meal planning'),
            subtitle: const Text('Weekly meals and shopping lists'),
            value: draft.mealPlanningEnabled,
            onChanged: (v) => notifier.update((d) => d.copyWith(mealPlanningEnabled: v)),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Habit reminders'),
            subtitle: const Text('Nudges to keep your streaks alive'),
            value: draft.habitRemindersEnabled,
            onChanged: (v) => notifier.update((d) => d.copyWith(habitRemindersEnabled: v)),
          ),
        ],
      ),
    );
  }
}

class _NotificationsStep extends ConsumerWidget {
  const _NotificationsStep();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(onboardingDraftProvider);
    final notifier = ref.read(onboardingDraftProvider.notifier);
    return _StepScaffold(
      title: 'Stay on track',
      subtitle: "We'll only notify you about things that matter.",
      child: Column(
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Daily summary'),
            value: draft.dailySummary,
            onChanged: (v) => notifier.update((d) => d.copyWith(dailySummary: v)),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Habit reminders'),
            value: draft.habitReminders,
            onChanged: (v) => notifier.update((d) => d.copyWith(habitReminders: v)),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Task reminders'),
            value: draft.taskReminders,
            onChanged: (v) => notifier.update((d) => d.copyWith(taskReminders: v)),
          ),
          const SizedBox(height: AppSpacing.md),
          OutlinedButton.icon(
            onPressed: () => LocalNotificationService.instance.requestPermission(),
            icon: const Icon(Icons.notifications_active_rounded),
            label: const Text('Enable notifications'),
          ),
        ],
      ),
    );
  }
}

class _SummaryStep extends ConsumerWidget {
  const _SummaryStep();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(onboardingDraftProvider);
    final theme = Theme.of(context);
    return _StepScaffold(
      title: draft.displayName.isEmpty ? "You're all set!" : "You're all set, ${draft.displayName}!",
      subtitle: 'Flow will use this to personalize your dashboard and coaching.',
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(AppRadii.lg),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SummaryRow(label: 'Wake / Sleep', value: '${draft.wakeTime} · ${draft.sleepTime}'),
            _SummaryRow(label: 'Goals', value: draft.primaryGoals.isEmpty ? 'None yet' : draft.primaryGoals.join(', ')),
            _SummaryRow(label: 'Coaching style', value: draft.coachingStyle.name),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 120, child: Text(label, style: theme.textTheme.labelMedium)),
          Expanded(child: Text(value, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
