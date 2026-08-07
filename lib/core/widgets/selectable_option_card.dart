import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import 'badge_chip.dart';
import 'pressable_scale.dart';

/// A tappable, selectable option row — icon chip + title (+ optional
/// subtitle) + a checkmark when selected. Used for "pick one" choices like
/// coaching style, shared between onboarding and Profile's edit screen
/// instead of each hand-rolling its own InkWell+Container selection card
/// with a bare (non-chip) icon.
class SelectableOptionCard extends StatelessWidget {
  const SelectableOptionCard({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.selected,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final bool selected;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color accent = color ?? theme.colorScheme.primary;
    return PressableScale(
      borderRadius: BorderRadius.circular(AppRadii.raised),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: selected ? accent.withValues(alpha: 0.1) : theme.cardTheme.color,
          borderRadius: BorderRadius.circular(AppRadii.raised),
          border: Border.all(color: selected ? accent : Colors.transparent, width: 1.5),
        ),
        child: Row(
          children: [
            CategoryIconChip(icon: icon, color: accent, tint: accent.withValues(alpha: 0.14), size: 40),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: subtitle == null
                  ? Text(title, style: theme.textTheme.titleMedium)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: theme.textTheme.titleMedium),
                        Text(subtitle!, style: theme.textTheme.bodySmall),
                      ],
                    ),
            ),
            if (selected) Icon(Icons.check_circle_rounded, color: accent),
          ],
        ),
      ),
    );
  }
}
