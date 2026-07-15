import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../application/user_profile_providers.dart';
import '../../domain/user_profile.dart';

/// Toggles bound to [UserProfile.notificationPrefs], persisted via
/// [UserProfileController.updateFields].
class NotificationsSettingsScreen extends ConsumerWidget {
  const NotificationsSettingsScreen({super.key});

  Future<void> _updatePrefs(WidgetRef ref, UserProfile profile, NotificationPrefs prefs) {
    return ref.read(userProfileControllerProvider.notifier).updateFields(profile.uid, {
      'notificationPrefs': prefs.toJson(),
    });
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
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            children: [
              SwitchListTile(
                title: const Text('Daily summary'),
                subtitle: const Text('A morning recap of your day ahead'),
                value: prefs.dailySummary,
                onChanged: (v) => _updatePrefs(ref, profile, prefs.copyWith(dailySummary: v)),
              ),
              SwitchListTile(
                title: const Text('Habit reminders'),
                subtitle: const Text('Nudges to keep your streaks alive'),
                value: prefs.habitReminders,
                onChanged: (v) => _updatePrefs(ref, profile, prefs.copyWith(habitReminders: v)),
              ),
              SwitchListTile(
                title: const Text('Task reminders'),
                subtitle: const Text('Alerts before scheduled tasks are due'),
                value: prefs.taskReminders,
                onChanged: (v) => _updatePrefs(ref, profile, prefs.copyWith(taskReminders: v)),
              ),
              ListTile(
                title: const Text('Reminder time'),
                subtitle: Text(prefs.reminderTime),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => _pickReminderTime(context, ref, profile),
              ),
            ],
          );
        },
      ),
    );
  }
}
