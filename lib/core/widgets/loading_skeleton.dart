import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/app_spacing.dart';

/// Shimmering placeholder block shown while async data loads, using
/// flutter_animate's built-in shimmer effect instead of a separate package.
class LoadingSkeleton extends StatelessWidget {
  const LoadingSkeleton({super.key, this.width, this.height = 16, this.borderRadius = AppRadii.sm});

  final double? width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 1200.ms, color: Colors.white24);
  }
}

/// Stack of skeleton lines mimicking a dashboard card while it loads.
class LoadingCardSkeleton extends StatelessWidget {
  const LoadingCardSkeleton({super.key, this.lines = 3, this.height = 120});

  final int lines;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 0; i < lines; i++) LoadingSkeleton(width: i.isEven ? double.infinity : 140),
          ],
        ),
      ),
    );
  }
}
