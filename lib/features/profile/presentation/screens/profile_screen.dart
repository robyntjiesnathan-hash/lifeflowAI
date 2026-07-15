import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_paths.dart';
import '../../../../core/theme/app_semantic_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_mode_provider.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_segmented_control.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../gamification/presentation/widgets/badges_grid.dart';
import '../../../gamification/presentation/widgets/xp_level_card.dart';
import '../../../premium/application/premium_providers.dart';
import '../../application/user_profile_providers.dart';

/// Profile tab — avatar/identity header, XP/level summary, a "More
/// Highlights" 2x2 grid (Smart Reminders / AI Insights / Achievements /
/// Mood & Energy, matching the reference mockup), the achievements badge
/// grid, and the settings list (theme, notifications, premium, account,
/// sign out).
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _achievementsKey = GlobalKey();

  void _scrollToAchievements() {
    final achievementsContext = _achievementsKey.currentContext;
    if (achievementsContext != null) {
      Scrollable.ensureVisible(achievementsContext, duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
    }
  }

  Future<void> _confirmSignOut() async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Sign out?',
      message: "You'll need to sign back in to access your LifeFlow AI data.",
      confirmLabel: 'Sign Out',
      isDestructive: true,
    );
    if (!confirmed) return;
    await ref.read(authControllerProvider.notifier).signOut();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profileAsync = ref.watch(currentUserProfileProvider);
    final isPremium = ref.watch(isPremiumProvider);
    final themeMode = ref.watch(appThemeModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: profileAsync.when(
        loading: () => const _ProfileLoading(),
        error: (error, stack) => Center(child: Padding(padding: const EdgeInsets.all(AppSpacing.lg), child: Text('$error'))),
        data: (profile) {
          final uid = profile?.uid ?? ref.watch(authStateChangesProvider).value?.uid;
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.push(RoutePaths.profileEdit),
                    child: CircleAvatar(
                      radius: 36,
                      backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.12),
                      backgroundImage: profile?.photoUrl != null ? CachedNetworkImageProvider(profile!.photoUrl!) : null,
                      child: profile?.photoUrl == null
                          ? Icon(Icons.person_rounded, size: 36, color: theme.colorScheme.primary)
                          : null,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (profile?.displayName?.isNotEmpty ?? false) ? profile!.displayName! : 'LifeFlow AI User',
                          style: theme.textTheme.titleLarge,
                        ),
                        if (profile?.email != null) Text(profile!.email!, style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => context.push(RoutePaths.profileEdit),
                    icon: const Icon(Icons.edit_rounded),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              if (uid != null) XpLevelCard(uid: uid),
              const SizedBox(height: AppSpacing.lg),
              const SectionHeader(title: 'More Highlights'),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: AppSpacing.sm,
                crossAxisSpacing: AppSpacing.sm,
                childAspectRatio: 1.35,
                children: [
                  _HighlightTile(
                    icon: Icons.notifications_active_rounded,
                    color: context.semanticColors.categoryPink,
                    tint: context.semanticColors.categoryPinkTint,
                    title: 'Smart Reminders',
                    subtitle: 'Never miss what matters',
                    onTap: () => context.push(RoutePaths.notificationsSettings),
                  ),
                  _HighlightTile(
                    icon: Icons.auto_awesome_rounded,
                    color: context.semanticColors.categoryPurple,
                    tint: context.semanticColors.categoryPurpleTint,
                    title: 'AI Insights',
                    subtitle: 'Personalized insights to improve your life',
                    onTap: () => context.push(RoutePaths.coach),
                  ),
                  _HighlightTile(
                    icon: Icons.emoji_events_rounded,
                    color: context.semanticColors.xpGold,
                    tint: context.semanticColors.xpGoldTint,
                    title: 'Achievements',
                    subtitle: 'Earn badges and level up!',
                    onTap: _scrollToAchievements,
                  ),
                  _HighlightTile(
                    icon: Icons.sentiment_satisfied_alt_rounded,
                    color: context.semanticColors.success,
                    tint: context.semanticColors.successTint,
                    title: 'Mood & Energy',
                    subtitle: 'Coming soon',
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Mood & Energy tracking is coming soon.')),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              SectionHeader(key: _achievementsKey, title: 'Achievements'),
              const BadgesGrid(),
              const SizedBox(height: AppSpacing.lg),
              Text('Settings', style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Theme', style: theme.textTheme.bodyMedium),
                          AppSegmentedControl<ThemeMode>(
                            options: const [
                              (ThemeMode.light, 'Light'),
                              (ThemeMode.system, 'System'),
                              (ThemeMode.dark, 'Dark'),
                            ],
                            value: themeMode,
                            onChanged: (mode) => ref.read(appThemeModeProvider.notifier).set(mode),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    _SettingsTile(
                      icon: Icons.notifications_rounded,
                      title: 'Notifications',
                      onTap: () => context.push(RoutePaths.notificationsSettings),
                    ),
                    const Divider(height: 1),
                    _SettingsTile(
                      icon: Icons.workspace_premium_rounded,
                      title: isPremium ? 'Premium' : 'Upgrade to Premium',
                      trailing: isPremium ? const Icon(Icons.check_circle_rounded, color: Colors.green) : null,
                      onTap: () => context.push(RoutePaths.premium),
                    ),
                    const Divider(height: 1),
                    _SettingsTile(
                      icon: Icons.account_circle_rounded,
                      title: 'Account',
                      onTap: () => context.push(RoutePaths.profileAccount),
                    ),
                    const Divider(height: 1),
                    _SettingsTile(
                      icon: Icons.logout_rounded,
                      title: 'Sign Out',
                      destructive: true,
                      onTap: _confirmSignOut,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          );
        },
      ),
    );
  }
}

class _ProfileLoading extends StatelessWidget {
  const _ProfileLoading();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          LoadingCardSkeleton(lines: 2, height: 90),
          SizedBox(height: AppSpacing.lg),
          LoadingCardSkeleton(lines: 3, height: 120),
        ],
      ),
    );
  }
}

class _HighlightTile extends StatelessWidget {
  const _HighlightTile({
    required this.icon,
    required this.color,
    required this.tint,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final Color color;
  final Color tint;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: tint, shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(title, style: theme.textTheme.labelLarge),
          const SizedBox(height: 2),
          Text(subtitle, style: theme.textTheme.bodySmall, maxLines: 2, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
    this.destructive = false,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Widget? trailing;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color color = destructive ? theme.colorScheme.error : theme.textTheme.bodyLarge?.color ?? theme.colorScheme.onSurface;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color)),
      trailing: trailing ?? const Icon(Icons.chevron_right_rounded),
      onTap: onTap,
    );
  }
}
