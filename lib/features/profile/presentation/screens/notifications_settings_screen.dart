import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/local_notification_service.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../application/user_profile_providers.dart';
import '../../domain/user_profile.dart';

/// Toggles bound to [UserProfile.notificationPrefs], persisted via
/// [UserProfileController.updateFields] and mirrored into real scheduled
/// local notifications via [LocalNotificationService].
class NotificationsSettingsScreen extends ConsumerWidget {
  const NotificationsSettingsScreen({super.key});

  // Fixed ids so re-scheduling (toggle on/off, or a changed reminder time)
  // replaces the existing notification instead of stacking duplicates.
  static const int _dailySummaryNotificationId = 9001;
  static const int _habitReminderNotificationId = 9002;

  Future<void> _updatePrefs(WidgetRef ref, UserProfile profile, NotificationPrefs prefs) async {
    await ref.read(userProfileControllerProvider.notifier).updateFields(profile.uid, {
      'notificationPrefs': prefs.toJson(),
    });
    await _applySchedule(prefs);
  }

  Future<void> _applySchedule(NotificationPrefs prefs) async {
    final service = LocalNotificationService.instance;
    final parts = prefs.reminderTime.split(':');
    final hour = int.tryParse(parts[0]) ?? 8;
    final minute = int.tryParse(parts.length > 1 ? parts[1] : '0') ?? 0;

    if (prefs.dailySummary) {
      await service.scheduleDaily(
        id: _dailySummaryNotificationId,
        title: 'Your day ahead',
        body: 'Good morning! Check today\'s plan in LifeFlow AI.',
        hour: hour,
        minute: minute,
      );
    } else {
      await service.cancel(_dailySummaryNotificationId);
    }

    if (prefs.habitReminders) {
      await service.scheduleDaily(
        id: _habitReminderNotificationId,
        title: 'Keep your streak alive',
        body: 'Don\'t forget to log today\'s habits in LifeFlow AI.',
        hour: hour,
        minute: minute,
      );
    } else {
      await service.cancel(_habitReminderNotificationId);
    }
  }

  Future<void> _pickReminderTime(BuildContext context, WidgetRef ref, UserProfile profile) async {
    final parts = profile.notificationPrefs.reminderTime.split(':');
    final initial = TimeOfDay(
      hour: int.tryParse(parts[0]) ?? 8,
      minute: int.tryParse(parts.length > 1 ? parts[1] : '0') ?? 0,
    );
    final picked = await showTimePicker(context: context, initialTime: initial);
    if (picked == null) return;
    final formatted = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
    await _updatePrefs(ref, profile, profile.notificationPrefs.copyWith(reminderTime: formatted));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(currentUserProfileProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('$error')),
        data: (profile) {
          if (profile == null) return const Center(child: Text('Profile not found.'));
          final prefs = profile.notificationPrefs;
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              // The one screen in the app with zero AppCard usage — bare
              // SwitchListTiles with no grouping or elevation. Wrapped to
              // match the settings-list pattern used on Profile.
              AppCard(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text('Daily summary'),
                      subtitle: const Text('A morning recap of your day ahead'),
                      value: prefs.dailySummary,
                      onChanged: (v) => _updatePrefs(ref, profile, prefs.copyWith(dailySummary: v)),
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      title: const Text('Habit reminders'),
                      subtitle: const Text('Nudges to keep your streaks alive'),
                      value: prefs.habitReminders,
                      onChanged: (v) => _updatePrefs(ref, profile, prefs.copyWith(habitReminders: v)),
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      title: const Text('Task reminders'),
                      subtitle: const Text('Alerts before scheduled tasks are due'),
                      value: prefs.taskReminders,
                      onChanged: (v) => _updatePrefs(ref, profile, prefs.copyWith(taskReminders: v)),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text('Reminder time'),
                      subtitle: Text(prefs.reminderTime),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => _pickReminderTime(context, ref, profile),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
