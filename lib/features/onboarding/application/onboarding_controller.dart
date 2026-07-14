import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/application/auth_providers.dart';
import '../../profile/application/user_profile_providers.dart';
import '../../profile/domain/user_profile.dart';
import '../domain/onboarding_draft.dart';

part 'onboarding_controller.g.dart';

@riverpod
class OnboardingDraftNotifier extends _$OnboardingDraftNotifier {
  @override
  OnboardingDraft build() => const OnboardingDraft();

  void update(OnboardingDraft Function(OnboardingDraft) updater) => state = updater(state);
}

@riverpod
class OnboardingController extends _$OnboardingController {
  @override
  FutureOr<void> build() {}

  Future<void> completeOnboarding(OnboardingDraft draft) async {
    final user = ref.read(authStateChangesProvider).value;
    if (user == null) {
      state = AsyncError(StateError('No signed-in user'), StackTrace.current);
      return;
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final profile = UserProfile(
        uid: user.uid,
        email: user.email,
        displayName: draft.displayName.isEmpty ? user.displayName : draft.displayName,
        onboardingComplete: true,
        ageRange: draft.ageRange,
        occupation: draft.occupation,
        wakeTime: draft.wakeTime,
        sleepTime: draft.sleepTime,
        primaryGoals: draft.primaryGoals,
        coachingStyle: draft.coachingStyle,
        preferences: UserPreferences(
          budgetTrackingEnabled: draft.budgetTrackingEnabled,
          mealPlanningEnabled: draft.mealPlanningEnabled,
          habitRemindersEnabled: draft.habitRemindersEnabled,
        ),
        notificationPrefs: NotificationPrefs(
          dailySummary: draft.dailySummary,
          habitReminders: draft.habitReminders,
          taskReminders: draft.taskReminders,
          reminderTime: draft.reminderTime,
        ),
      );
      await ref.read(userProfileRepositoryProvider).saveProfile(profile);
    });
  }
}
