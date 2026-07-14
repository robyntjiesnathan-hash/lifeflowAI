import 'package:flutter/material.dart';

import '../theme/app_semantic_colors.dart';
import '../theme/app_spacing.dart';

/// Small pill chip with an icon, used for streak badges ("6 day streak")
/// and XP indicators throughout the app.
class BadgeChip extends StatelessWidget {
  const BadgeChip({super.key, required this.label, required this.icon, this.color, this.tint});

  final String label;
  final IconData icon;
  final Color? color;
  final Color? tint;

  factory BadgeChip.streak(int days) => BadgeChip(label: '$days day streak', icon: Icons.local_fire_department_rounded);
  factory BadgeChip.xp(int xp) => BadgeChip(label: '+$xp XP', icon: Icons.bolt_rounded);

  @override
  Widget build(BuildContext context) {
    final semantic = context.semanticColors;
    final bool isXp = icon == Icons.bolt_rounded && color == null;
    final Color fg = color ?? (isXp ? semantic.xpGold : semantic.streakFlame);
    final Color bg = tint ?? (isXp ? semantic.xpGoldTint : semantic.streakFlameTint);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(AppRadii.pill)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(color: fg, fontWeight: FontWeight.w700, fontSize: 11)),
        ],
      ),
    );
  }
}

/// Colored rounded-square icon chip used for category/habit/goal icons
/// (e.g. Budget category rows, Goal cards) — tinted pastel background with
/// a saturated icon on top, per the reference design.
class CategoryIconChip extends StatelessWidget {
  const CategoryIconChip({super.key, required this.icon, required this.color, required this.tint, this.size = 44});

  final IconData icon;
  final Color color;
  final Color tint;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: tint, borderRadius: BorderRadius.circular(size * 0.32)),
      child: Icon(icon, color: color, size: size * 0.5),
    );
  }
}
