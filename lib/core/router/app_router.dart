import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/application/auth_providers.dart';
import '../../features/auth/presentation/screens/auth_welcome_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/habits/presentation/screens/habit_detail_screen.dart';
import '../../features/habits/presentation/screens/habits_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/profile/application/user_profile_providers.dart';
import '../../features/shell/presentation/screens/shell_scaffold.dart';
import '../../features/shell/presentation/screens/splash_screen.dart';
import '../widgets/placeholder_screen.dart';
import 'go_router_refresh_stream.dart';
import 'route_paths.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  final refreshNotifier = GoRouterRefreshNotifier();
  ref.listen(authStateChangesProvider, (previous, next) => refreshNotifier.refresh());
  ref.listen(currentUserProfileProvider, (previous, next) => refreshNotifier.refresh());
  ref.onDispose(refreshNotifier.dispose);

  return GoRouter(
    initialLocation: RoutePaths.splash,
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final authState = ref.read(authStateChangesProvider);
      if (!authState.hasValue) return null; // still loading -> stay on splash

      final user = authState.value;
      final path = state.matchedLocation;
      final onAuthRoute = path.startsWith('/auth');

      if (user == null) {
        return onAuthRoute ? null : RoutePaths.authWelcome;
      }

      final profileState = ref.read(currentUserProfileProvider);
      if (!profileState.hasValue) return null; // profile still loading

      final onboardingComplete = profileState.value?.onboardingComplete ?? false;
      if (!onboardingComplete) {
        return path == RoutePaths.onboarding ? null : RoutePaths.onboarding;
      }

      if (path == RoutePaths.splash || onAuthRoute || path == RoutePaths.onboarding) {
        return RoutePaths.home;
      }
      return null;
    },
    routes: [
      GoRoute(path: RoutePaths.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: RoutePaths.onboarding, builder: (context, state) => const OnboardingScreen()),
      GoRoute(path: RoutePaths.authWelcome, builder: (context, state) => const AuthWelcomeScreen()),
      GoRoute(path: RoutePaths.authSignIn, builder: (context, state) => const SignInScreen()),
      GoRoute(path: RoutePaths.authSignUp, builder: (context, state) => const SignUpScreen()),
      GoRoute(path: RoutePaths.authForgotPassword, builder: (context, state) => const ForgotPasswordScreen()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => ShellScaffold(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: RoutePaths.home, builder: (context, state) => const HomeScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: RoutePaths.planner,
              builder: (context, state) => const PlaceholderScreen(title: 'Planner'),
              routes: [
                GoRoute(
                  path: 'task/:taskId',
                  builder: (context, state) =>
                      PlaceholderScreen(title: 'Task ${state.pathParameters['taskId']}'),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: RoutePaths.goals,
              builder: (context, state) => const PlaceholderScreen(title: 'Goals'),
              routes: [
                GoRoute(
                  path: ':goalId',
                  builder: (context, state) => PlaceholderScreen(title: 'Goal ${state.pathParameters['goalId']}'),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: RoutePaths.profile, builder: (context, state) => const PlaceholderScreen(title: 'Profile')),
          ]),
        ],
      ),
      GoRoute(
        path: RoutePaths.coach,
        builder: (context, state) => const PlaceholderScreen(title: 'AI Coach'),
        routes: [
          GoRoute(
            path: ':conversationId',
            builder: (context, state) => const PlaceholderScreen(title: 'AI Coach'),
          ),
        ],
      ),
      GoRoute(
        path: RoutePaths.habits,
        builder: (context, state) => const HabitsScreen(),
        routes: [
          GoRoute(
            path: ':habitId',
            builder: (context, state) => HabitDetailScreen(habitId: state.pathParameters['habitId']!),
          ),
        ],
      ),
      GoRoute(
        path: RoutePaths.meals,
        builder: (context, state) => const PlaceholderScreen(title: 'Meal Planner'),
        routes: [
          GoRoute(path: 'recipe/:recipeId', builder: (context, state) => const PlaceholderScreen(title: 'Recipe')),
          GoRoute(path: 'shopping-list', builder: (context, state) => const PlaceholderScreen(title: 'Shopping List')),
        ],
      ),
      GoRoute(
        path: RoutePaths.budget,
        builder: (context, state) => const PlaceholderScreen(title: 'Budget'),
        routes: [
          GoRoute(path: 'transaction/:transactionId', builder: (context, state) => const PlaceholderScreen(title: 'Transaction')),
          GoRoute(path: 'bills', builder: (context, state) => const PlaceholderScreen(title: 'Bills')),
        ],
      ),
      GoRoute(path: RoutePaths.reminders, builder: (context, state) => const PlaceholderScreen(title: 'Reminders')),
      GoRoute(
        path: RoutePaths.notificationsSettings,
        builder: (context, state) => const PlaceholderScreen(title: 'Notification Settings'),
      ),
      GoRoute(path: RoutePaths.premium, builder: (context, state) => const PlaceholderScreen(title: 'Premium')),
      GoRoute(path: RoutePaths.profileEdit, builder: (context, state) => const PlaceholderScreen(title: 'Edit Profile')),
      GoRoute(path: RoutePaths.profileAccount, builder: (context, state) => const PlaceholderScreen(title: 'Account')),
    ],
  );
}
