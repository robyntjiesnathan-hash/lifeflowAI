import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../auth/application/auth_providers.dart';
import '../../application/user_profile_providers.dart';
import '../../domain/user_profile.dart';

/// Account details + destructive "Delete account" action. Full account
/// deletion needs a re-auth flow (Firebase requires a recent sign-in for
/// `User.delete()`) plus a Firestore data-purge Cloud Function to remove
/// every `users/{uid}/**` subcollection — that's a v2 item, so for now the
/// destructive action only signs the user out (see [_confirmDelete]).
class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Delete account?',
      message: 'This will sign you out. Permanently deleting your data requires re-authentication and is not yet '
          'available in this build — contact support if you need your data fully removed.',
      confirmLabel: 'Sign Out',
      isDestructive: true,
    );
    if (!confirmed) return;
    // NOTE: full account deletion requires re-authenticating the user plus
    // a Firestore data-purge flow — see class doc above. This only signs
    // the user out for now.
    await ref.read(authControllerProvider.notifier).signOut();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final profileAsync = ref.watch(currentUserProfileProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('$error')),
        data: (profile) {
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _InfoRow(label: 'Email', value: profile?.email ?? 'Not available'),
                    const SizedBox(height: AppSpacing.sm),
                    _InfoRow(label: 'Sign-in method', value: _providerLabel(profile?.authProvider)),
                    const SizedBox(height: AppSpacing.sm),
                    _InfoRow(label: 'Member since', value: _formatDate(profile?.createdAt)),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.colorScheme.error,
                  side: BorderSide(color: theme.colorScheme.error),
                  // Matches GradientPillButton's fully-rounded shape and
                  // padding instead of Material's default rectangular
                  // outlined-button chrome.
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadii.pill)),
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: 16),
                ),
                onPressed: () => _confirmDelete(context, ref),
                icon: const Icon(Icons.delete_forever_rounded),
                label: const Text('Delete Account'),
              ),
            ],
          );
        },
      ),
    );
  }
}

String _providerLabel(AuthProviderName? provider) {
  switch (provider) {
    case AuthProviderName.email:
      return 'Email & password';
    case AuthProviderName.google:
      return 'Google';
    case AuthProviderName.apple:
      return 'Apple';
    case AuthProviderName.guest:
    case null:
      return 'Guest';
  }
}

String _formatDate(DateTime? date) {
  if (date == null) return 'Unknown';
  return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: theme.textTheme.bodyMedium),
        Text(value, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
      ],
    );
  }
}
