import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

/// Labeled text field — thin wrapper over [TextFormField] that adds a
/// consistent label-above-input layout, reused by every add/edit form
/// across features.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    required this.label,
    this.hint,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
    this.suffixIcon,
    this.autofocus = false,
    this.initialValue,
    this.onChangedController,
  });

  final TextEditingController? controller;
  final String label;
  final String? hint;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool autofocus;

  /// Uncontrolled-mode initial text, used together with [onChangedController]
  /// when the caller wants change notifications without owning a
  /// [TextEditingController] (e.g. onboarding steps backed by Riverpod
  /// state rather than local controllers).
  final String? initialValue;
  final ValueChanged<String>? onChangedController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.labelLarge),
        const SizedBox(height: AppSpacing.xs),
        TextFormField(
          controller: controller,
          initialValue: controller == null ? initialValue : null,
          onChanged: onChangedController,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          autofocus: autofocus,
          decoration: InputDecoration(hintText: hint, suffixIcon: suffixIcon),
        ),
      ],
    );
  }
}
