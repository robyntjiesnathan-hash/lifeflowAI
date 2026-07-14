import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_paths.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/flow_mascot.dart';
import '../../application/auth_providers.dart';

class AuthWelcomeScreen extends ConsumerWidget {
  const AuthWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerState = ref.watch(authControllerProvider);
    final isLoading = controllerState.isLoading;
    final bool showApple = defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS;

    ref.listen(authControllerProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_friendlyError(next.error))),
        );
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              const Spacer(),
              const FlowMascot(size: 96),
              const SizedBox(height: AppSpacing.lg),
              ShaderMask(
                shaderCallback: (bounds) => AppGradients.primary.createShader(bounds),
                child: Text(
                  'LifeFlow AI',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Your personal secretary in your pocket.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.only(bottom: AppSpacing.md),
                  child: CircularProgressIndicator(),
                ),
              GradientPillButton(
                label: 'Continue with Google',
                icon: Icons.g_mobiledata_rounded,
                onPressed: isLoading ? null : () => ref.read(authControllerProvider.notifier).signInWithGoogle(),
              ),
              if (showApple) ...[
                const SizedBox(height: AppSpacing.sm),
                GradientPillButton(
                  label: 'Continue with Apple',
                  icon: Icons.apple_rounded,
                  gradient: const LinearGradient(colors: [Colors.black87, Colors.black]),
                  onPressed: isLoading ? null : () => ref.read(authControllerProvider.notifier).signInWithApple(),
                ),
              ],
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton(
                onPressed: isLoading ? null : () => context.push(RoutePaths.authSignIn),
                child: const SizedBox(width: double.infinity, child: Text('Sign in with email', textAlign: TextAlign.center)),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextButton(
                onPressed: isLoading ? null : () => context.push(RoutePaths.authSignUp),
                child: const Text('Create an account'),
              ),
              TextButton(
                onPressed: isLoading ? null : () => ref.read(authControllerProvider.notifier).signInAnonymously(),
                child: const Text('Continue as guest'),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }

  String _friendlyError(Object? error) {
    if (error == null) return 'Something went wrong. Please try again.';
    final message = error.toString();
    return message.contains(']') ? message.split(']').last.trim() : message;
  }
}
