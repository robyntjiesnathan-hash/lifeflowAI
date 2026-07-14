import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

/// A single day cell status, driving the colored dot/fill under each
/// weekday letter (e.g. Habits' weekly overview row).
enum DayStatus { none, partial, complete }

class WeekDayStrip extends StatelessWidget {
  const WeekDayStrip({
    super.key,
    required this.days,
    required this.selectedIndex,
    this.statuses,
    this.onSelect,
  });

  /// Short labels, e.g. ['M','T','W','T','F','S','S'] or day numbers.
  final List<String> days;
  final int selectedIndex;
  final List<DayStatus>? statuses;
  final ValueChanged<int>? onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < days.length; i++)
          GestureDetector(
            onTap: onSelect == null ? null : () => onSelect!(i),
            child: Column(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i == selectedIndex ? theme.colorScheme.primary : Colors.transparent,
                  ),
                  child: Text(
                    days[i],
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: i == selectedIndex ? Colors.white : theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
                if (statuses != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  _StatusDot(status: statuses![i]),
                ],
              ],
            ),
          ),
      ],
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.status});

  final DayStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Color color;
    switch (status) {
      case DayStatus.complete:
        color = theme.colorScheme.primary;
      case DayStatus.partial:
        color = theme.colorScheme.primary.withValues(alpha: 0.4);
      case DayStatus.none:
        color = Colors.transparent;
    }
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
