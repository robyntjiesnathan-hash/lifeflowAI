import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Circular progress ring used for "Daily Progress" on Home and progress
/// indicators on Goals, matching the thick gradient ring in the reference
/// design.
class AppProgressRing extends StatelessWidget {
  const AppProgressRing({
    super.key,
    required this.percent,
    this.size = 120,
    this.strokeWidth = 12,
    this.color,
    this.backgroundColor,
    this.center,
  });

  /// 0.0 - 1.0
  final double percent;
  final double size;
  final double strokeWidth;
  final Color? color;
  final Color? backgroundColor;
  final Widget? center;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color ringColor = color ?? theme.colorScheme.primary;
    final Color bgColor = backgroundColor ??
        (theme.brightness == Brightness.dark ? Colors.white12 : theme.colorScheme.primary.withValues(alpha: 0.1));
    final double clamped = percent.clamp(0.0, 1.0);

    return TweenAnimationTween(
      begin: 0,
      end: clamped,
      child: SizedBox(
        width: size,
        height: size,
        child: center == null ? null : Center(child: center),
      ),
      builder: (context, value, child) {
        return SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: _RingPainter(percent: value, color: ringColor, backgroundColor: bgColor, strokeWidth: strokeWidth),
            child: child,
          ),
        );
      },
    );
  }
}

/// Small helper so callers don't need to import `TweenAnimationBuilder`
/// boilerplate at every call site.
class TweenAnimationTween extends StatelessWidget {
  const TweenAnimationTween({
    super.key,
    required this.begin,
    required this.end,
    required this.builder,
    this.child,
  });

  final double begin;
  final double end;
  final Widget? child;
  final Widget Function(BuildContext, double, Widget?) builder;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: begin, end: end),
      duration: 900.ms,
      curve: Curves.easeOutCubic,
      builder: builder,
      child: child,
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.percent, required this.color, required this.backgroundColor, required this.strokeWidth});

  final double percent;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double radius = (math.min(size.width, size.height) - strokeWidth) / 2;

    final Paint bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    final Paint fgPaint = Paint()
      ..shader = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: 3 * math.pi / 2,
        colors: [color.withValues(alpha: 0.6), color],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * percent,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      oldDelegate.percent != percent || oldDelegate.color != color;
}
