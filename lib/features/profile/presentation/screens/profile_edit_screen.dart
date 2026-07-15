import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../application/user_profile_providers.dart';
import '../../domain/user_profile.dart';

const Map<CoachingStyle, (String, IconData)> _coachingStyles = {
  CoachingStyle.supportive: ('Supportive', Icons.favorite_rounded),
  CoachingStyle.direct: ('Direct', Icons.bolt_rounded),
  CoachingStyle.analytical: ('Analytical', Icons.insights_rounded),
  CoachingStyle.playful: ('Playful', Icons.celebration_rounded),
};

const List<String> _ageRanges = ['<18', '18-24', '25-34', '35-44', '45-54', '55+'];

/// Edit form for the subset of [UserProfile] fields the user can change
/// after onboarding: display name, age range, occupation, coaching style.
class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  final _nameController = TextEditingController();
  final _occupationController = TextEditingController();
  String? _ageRange;
  CoachingStyle _coachingStyle = CoachingStyle.supportive;
  bool _initialized = false;

  void _hydrate(UserProfile profile) {
    if (_initialized) return;
    _nameController.text = profile.displayName ?? '';
    _occupationController.text = profile.occupation ?? '';
    _ageRange = profile.ageRange;
    _coachingStyle = profile.coachingStyle;
    _initialized = true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _occupationController.dispose();
    super.dispose();
  }

  Future<void> _save(UserProfile current) async {
    final updated = current.copyWith(
      displayName: _nameController.text.trim(),
      occupation: _occupationController.text.trim().isEmpty ? null : _occupationController.text.trim(),
      ageRange: _ageRange,
      coachingStyle: _coachingStyle,
    );
    await ref.read(userProfileControllerProvider.notifier).save(updated);
    if (!mounted) return;
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profileAsync = ref.watch(currentUserProfileProvider);
    final isSaving = ref.watch(userProfileControllerProvider).isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('$error')),
        data: (profile) {
          if (profile == null) {
            return const Center(child: Text('Profile not found.'));
          }
          _hydrate(profile);
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              AppTextField(controller: _nameController, label: 'Display name', hint: 'Your name'),
              const SizedBox(height: AppSpacing.md),
              Text('Age range', style: theme.textTheme.labelLarge),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                children: [
                  for (final range in _ageRanges)
                    ChoiceChip(
                      label: Text(range),
                      selected: _ageRange == range,
                      onSelected: (_) => setState(() => _ageRange = range),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(controller: _occupationController, label: 'Occupation', hint: 'e.g. Software Engineer'),
              const SizedBox(height: AppSpacing.md),
              Text('Coaching style', style: theme.textTheme.labelLarge),
              const SizedBox(height: AppSpacing.sm),
              for (final entry in _coachingStyles.entries)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _CoachingStyleCard(
                    icon: entry.value.$2,
                    title: entry.value.$1,
                    selected: _coachingStyle == entry.key,
                    onTap: () => setState(() => _coachingStyle = entry.key),
                  ),
                ),
              const SizedBox(height: AppSpacing.lg),
              GradientPillButton(
                label: isSaving ? 'Saving…' : 'Save Changes',
                onPressed: isSaving ? null : () => _save(profile),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CoachingStyleCard extends StatelessWidget {
  const _CoachingStyleCard({required this.icon, required this.title, required this.selected, required this.onTap});

  final IconData icon;
  final String title;
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
            Expanded(child: Text(title, style: theme.textTheme.titleMedium)),
            if (selected) Icon(Icons.check_circle_rounded, color: theme.colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
