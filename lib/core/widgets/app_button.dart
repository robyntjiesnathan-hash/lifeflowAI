import 'package:flutter/material.dart';

import '../theme/app_gradients.dart';
import '../theme/app_spacing.dart';

/// Pill-shaped primary button filled with the brand gradient — used for the
/// FAB-adjacent CTAs like "+ Add Habit" / "+ Add Goal" / "Chat with Flow" in
/// the reference design.
class GradientPillButton extends StatelessWidget {
  const GradientPillButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expand = true,
    this.gradient = AppGradients.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expand;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    final button = Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(gradient: gradient, borderRadius: BorderRadius.circular(AppRadii.pill)),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadii.pill),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: 16),
            child: Row(
              mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: Colors.white, size: 18),
                  const SizedBox(width: AppSpacing.sm),
                ],
                Text(
                  label,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return expand ? button : IntrinsicWidth(child: button);
  }
}
