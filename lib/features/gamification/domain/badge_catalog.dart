import 'package:flutter/material.dart';

/// Broad grouping used to organize the badges grid / future filters.
enum BadgeCategory { streak, habits, goals, tasks }

/// Static definition of an achievable badge — pure data, no Firestore.
/// Awarding (checking criteria against real user activity) is owned by the
/// individual feature verticals (habits/goals/tasks), which call
/// `BadgesRepository.awardBadge(uid, badge.id)` when a criterion is met.
class BadgeDefinition {
  const BadgeDefinition({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.category,
  });

  /// Stable id, also used as the Firestore doc id under
  /// `users/{uid}/badges/{id}` once earned.
  final String id;
  final String title;

  /// Human-readable criteria description shown on the badge detail view.
  final String description;
  final IconData icon;
  final BadgeCategory category;
}

/// The full set of badges LifeFlow AI currently supports.
const List<BadgeDefinition> badgeCatalog = [
  BadgeDefinition(
    id: 'streak_3',
    title: '3-Day Streak',
    description: 'Complete a habit 3 days in a row.',
    icon: Icons.local_fire_department_rounded,
    category: BadgeCategory.streak,
  ),
  BadgeDefinition(
    id: 'streak_7',
    title: '7-Day Streak',
    description: 'Complete a habit 7 days in a row.',
    icon: Icons.local_fire_department_rounded,
    category: BadgeCategory.streak,
  ),
  BadgeDefinition(
    id: 'streak_30',
    title: '30-Day Streak',
    description: 'Complete a habit 30 days in a row.',
    icon: Icons.local_fire_department_rounded,
    category: BadgeCategory.streak,
  ),
  BadgeDefinition(
    id: 'habits_10',
    title: 'Habit Starter',
    description: 'Log 10 habit completions.',
    icon: Icons.check_circle_rounded,
    category: BadgeCategory.habits,
  ),
  BadgeDefinition(
    id: 'habits_50',
    title: 'Habit Builder',
    description: 'Log 50 habit completions.',
    icon: Icons.check_circle_rounded,
    category: BadgeCategory.habits,
  ),
  BadgeDefinition(
    id: 'habits_100',
    title: 'Habit Master',
    description: 'Log 100 habit completions.',
    icon: Icons.military_tech_rounded,
    category: BadgeCategory.habits,
  ),
  BadgeDefinition(
    id: 'goals_first',
    title: 'First Goal',
    description: 'Complete your first goal.',
    icon: Icons.flag_rounded,
    category: BadgeCategory.goals,
  ),
  BadgeDefinition(
    id: 'goals_5',
    title: 'Goal Getter',
    description: 'Complete 5 goals.',
    icon: Icons.emoji_events_rounded,
    category: BadgeCategory.goals,
  ),
  BadgeDefinition(
    id: 'tasks_25',
    title: 'Task Starter',
    description: 'Complete 25 tasks.',
    icon: Icons.task_alt_rounded,
    category: BadgeCategory.tasks,
  ),
  BadgeDefinition(
    id: 'tasks_100',
    title: 'Productivity Pro',
    description: 'Complete 100 tasks.',
    icon: Icons.workspace_premium_rounded,
    category: BadgeCategory.tasks,
  ),
];

/// Looks up a [BadgeDefinition] by id, or `null` if it isn't (or is no
/// longer) part of the catalog.
BadgeDefinition? badgeById(String id) {
  for (final badge in badgeCatalog) {
    if (badge.id == id) return badge;
  }
  return null;
}
