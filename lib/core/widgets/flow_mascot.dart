import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Which of Flow's two named motion moments to play: the ambient "arrival
/// breathe" idle loop, or the orchestrated "celebration" pose used by
/// `CelebrationOverlay` for level-ups, streak milestones, and completed
/// goals.
enum FlowMascotMood { idle, celebrate }

/// "Flow" — LifeFlow AI's friendly robot mascot, drawn as layered shapes so
/// no external art asset is required. Used on the Home hero scene and as
/// the avatar in the AI Coach chat header.
class FlowMascot extends StatelessWidget {
  const FlowMascot({super.key, this.size = 64, this.animate = true, this.mood = FlowMascotMood.idle});

  final double size;
  final bool animate;
  final FlowMascotMood mood;

  @override
  Widget build(BuildContext context) {
    final Widget body = SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _FlowPainter(celebrating: mood == FlowMascotMood.celebrate)),
    );
    if (!animate || MediaQuery.of(context).disableAnimations) return body;

    if (mood == FlowMascotMood.celebrate) {
      // The one energetic, attention-grabbing motion in the app — reserved
      // for the milestone-celebration moment, never played ambiently.
      return body
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scaleXY(begin: 1.0, end: 1.1, duration: 260.ms, curve: Curves.easeOutBack)
          .rotate(begin: -0.03, end: 0.03, duration: 260.ms, curve: Curves.easeInOut);
    }

    // "Arrival breathe" — quiet, continuous, ambient. Not attention-grabbing.
    return body
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .moveY(begin: 0, end: -4, duration: 1800.ms, curve: Curves.easeInOut)
        .scaleXY(begin: 1.0, end: 1.02, duration: 1800.ms, curve: Curves.easeInOut);
  }
}

class _FlowPainter extends CustomPainter {
  _FlowPainter({required this.celebrating});

  final bool celebrating;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final Rect headRect = Rect.fromLTWH(w * 0.08, h * 0.14, w * 0.84, h * 0.72);

    // Antenna — brightens on celebration.
    final Paint antennaPaint = Paint()
      ..color = const Color(0xFF6952D6)
      ..strokeWidth = w * 0.05
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w * 0.5, h * 0.02), Offset(w * 0.5, h * 0.16), antennaPaint);
    canvas.drawCircle(
      Offset(w * 0.5, h * 0.02),
      w * (celebrating ? 0.075 : 0.06),
      Paint()..color = celebrating ? const Color(0xFFE3A83A) : const Color(0xFFFBBF24),
    );

    // Head
    final Paint headPaint = Paint()..color = Colors.white;
    final RRect headRRect = RRect.fromRectAndRadius(headRect, Radius.circular(w * 0.28));
    canvas.drawShadow(Path()..addRRect(headRRect), Colors.black.withValues(alpha: 0.15), 3, false);
    canvas.drawRRect(headRRect, headPaint);
    canvas.drawRRect(
      headRRect,
      Paint()
        ..color = const Color(0xFF6952D6).withValues(alpha: 0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.02,
    );

    // Face plate
    final Rect faceRect = Rect.fromLTWH(w * 0.2, h * 0.34, w * 0.6, h * 0.34);
    canvas.drawRRect(
      RRect.fromRectAndRadius(faceRect, Radius.circular(w * 0.16)),
      Paint()..color = const Color(0xFF211C2E),
    );

    // Eyes — bigger and brighter when celebrating, with a small highlight.
    final Paint eyePaint = Paint()..color = const Color(0xFF67E8F9);
    final double eyeRadius = w * (celebrating ? 0.075 : 0.06);
    canvas.drawCircle(Offset(w * 0.38, h * 0.5), eyeRadius, eyePaint);
    canvas.drawCircle(Offset(w * 0.62, h * 0.5), eyeRadius, eyePaint);
    if (celebrating) {
      final Paint highlight = Paint()..color = Colors.white.withValues(alpha: 0.9);
      canvas.drawCircle(Offset(w * 0.36, h * 0.475), w * 0.018, highlight);
      canvas.drawCircle(Offset(w * 0.6, h * 0.475), w * 0.018, highlight);
    }

    // Cheeks
    canvas.drawCircle(
      Offset(w * 0.24, h * 0.62),
      w * 0.05,
      Paint()..color = const Color(0xFFF2734A).withValues(alpha: celebrating ? 0.75 : 0.55),
    );
    canvas.drawCircle(
      Offset(w * 0.76, h * 0.62),
      w * 0.05,
      Paint()..color = const Color(0xFFF2734A).withValues(alpha: celebrating ? 0.75 : 0.55),
    );

    // Sparkle accents — celebration only.
    if (celebrating) {
      _drawSparkle(canvas, Offset(w * 0.08, h * 0.1), w * 0.06, const Color(0xFFE3A83A));
      _drawSparkle(canvas, Offset(w * 0.92, h * 0.22), w * 0.045, const Color(0xFF1E9E82));
    }
  }

  void _drawSparkle(Canvas canvas, Offset center, double armLength, Color color) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = armLength * 0.28
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center.translate(0, -armLength), center.translate(0, armLength), paint);
    canvas.drawLine(center.translate(-armLength, 0), center.translate(armLength, 0), paint);
  }

  @override
  bool shouldRepaint(covariant _FlowPainter oldDelegate) => oldDelegate.celebrating != celebrating;
}
