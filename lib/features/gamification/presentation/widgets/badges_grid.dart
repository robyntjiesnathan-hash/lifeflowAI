import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_semantic_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../application/badges_providers.dart';
import '../../domain/badge_catalog.dart';

/// Grid of every badge in [badgeCatalog] — earned badges render in full
/// color, unearned ones greyed out — used in the Profile screen's
/// Achievements section.
class BadgesGrid extends ConsumerWidget {
  const BadgesGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final earnedAsync = ref.watch(earnedBadgesProvider);

    return earnedAsync.when(
      loading: () => const LoadingCardSkeleton(lines: 2, height: 140),
      error: (error, stack) => const EmptyState(
        icon: Icons.emoji_events_outlined,
        title: 'Achievements unavailable',
        message: "Couldn't load your badges right now. Pull to refresh and try again.",
      ),
      data: (earned) {
        if (badgeCatalog.isEmpty) {
          return const EmptyState(
            icon: Icons.emoji_events_outlined,
            title: 'No badges yet',
            message: 'Keep building habits and hitting goals — badges will show up here.',
          );
        }
        final earnedIds = earned.map((b) => b.badgeDefinitionId).toSet();
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: badgeCatalog.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: AppSpacing.sm,
            crossAxisSpacing: AppSpacing.sm,
            childAspectRatio: 0.82,
          ),
          itemBuilder: (context, index) {
            final badge = badgeCatalog[index];
            return _BadgeTile(badge: badge, earned: earnedIds.contains(badge.id));
          },
        );
      },
    );
  }
}

class _BadgeTile extends StatelessWidget {
  const _BadgeTile({required this.badge, required this.earned});

  final BadgeDefinition badge;
  final bool earned;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final semantic = context.semanticColors;
    final Color iconColor = earned ? semantic.xpGold : theme.disabledColor;
    final Color tint = earned
        ? semantic.xpGoldTint
        : (theme.brightness == Brightness.dark ? Colors.white10 : theme.dividerColor.withValues(alpha: 0.3));

    return AppCard(
      onTap: () => _showBadgeInfo(context, badge, earned),
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm, horizontal: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: tint, shape: BoxShape.circle),
            child: Icon(badge.icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            badge.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelSmall?.copyWith(
              color: earned ? null : theme.disabledColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

void _showBadgeInfo(BuildContext context, BadgeDefinition badge, bool earned) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(badge.title),
      content: Text(earned ? badge.description : '${badge.description}\n\nNot yet earned.'),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close')),
      ],
    ),
  );
}
