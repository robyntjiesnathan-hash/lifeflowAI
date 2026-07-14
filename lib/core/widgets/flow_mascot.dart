import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// "Flow" — LifeFlow AI's friendly robot mascot, drawn as layered shapes so
/// no external art asset is required. Used on the Home AI Coach card and as
/// the avatar in the AI Coach chat header, matching the reference design.
class FlowMascot extends StatelessWidget {
  const FlowMascot({super.key, this.size = 64, this.animate = true});

  final double size;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final Widget body = SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _FlowPainter()),
    );
    if (!animate) return body;
    return body
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .moveY(begin: 0, end: -3, duration: 1400.ms, curve: Curves.easeInOut);
  }
}

class _FlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final Rect headRect = Rect.fromLTWH(w * 0.08, h * 0.14, w * 0.84, h * 0.72);

    // Antenna
    final Paint antennaPaint = Paint()
      ..color = const Color(0xFF7C5CFC)
      ..strokeWidth = w * 0.05
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w * 0.5, h * 0.02), Offset(w * 0.5, h * 0.16), antennaPaint);
    canvas.drawCircle(Offset(w * 0.5, h * 0.02), w * 0.06, Paint()..color = const Color(0xFFFBBF24));

    // Head
    final Paint headPaint = Paint()..color = Colors.white;
    final RRect headRRect = RRect.fromRectAndRadius(headRect, Radius.circular(w * 0.28));
    canvas.drawShadow(Path()..addRRect(headRRect), Colors.black.withValues(alpha: 0.15), 3, false);
    canvas.drawRRect(headRRect, headPaint);
    canvas.drawRRect(
      headRRect,
      Paint()
        ..color = const Color(0xFF7C5CFC).withValues(alpha: 0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.02,
    );

    // Face plate
    final Rect faceRect = Rect.fromLTWH(w * 0.2, h * 0.34, w * 0.6, h * 0.34);
    canvas.drawRRect(
      RRect.fromRectAndRadius(faceRect, Radius.circular(w * 0.16)),
      Paint()..color = const Color(0xFF1E1B4B),
    );

    // Eyes
    final Paint eyePaint = Paint()..color = const Color(0xFF67E8F9);
    canvas.drawCircle(Offset(w * 0.38, h * 0.5), w * 0.06, eyePaint);
    canvas.drawCircle(Offset(w * 0.62, h * 0.5), w * 0.06, eyePaint);

    // Cheeks
    canvas.drawCircle(
      Offset(w * 0.24, h * 0.62),
      w * 0.05,
      Paint()..color = const Color(0xFFFDA4AF).withValues(alpha: 0.6),
    );
    canvas.drawCircle(
      Offset(w * 0.76, h * 0.62),
      w * 0.05,
      Paint()..color = const Color(0xFFFDA4AF).withValues(alpha: 0.6),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
