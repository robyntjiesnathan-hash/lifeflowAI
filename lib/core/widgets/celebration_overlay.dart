import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_spacing.dart';
import 'app_card.dart';
import 'flow_mascot.dart';

/// The one orchestrated, full-screen motion moment in the app — shown when
/// a [GamificationSummary] level-up, streak milestone, or goal completion
/// happens. Everywhere else in the app stays quiet; this is where the
/// "boldness budget" (per the design brief) gets spent.
///
/// Call [showCelebration] rather than constructing this directly.
Future<void> showCelebration(
  BuildContext context, {
  required String title,
  required String message,
}) {
  HapticFeedback.mediumImpact();
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: title,
    barrierColor: Colors.black.withValues(alpha: 0.45),
    transitionDuration: const Duration(milliseconds: 260),
    pageBuilder: (context, animation, secondaryAnimation) {
      return CelebrationOverlay(title: title, message: message);
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutBack, reverseCurve: Curves.easeIn);
      return ScaleTransition(scale: curved, child: FadeTransition(opacity: animation, child: child));
    },
  );
}

class CelebrationOverlay extends StatefulWidget {
  const CelebrationOverlay({super.key, required this.title, required this.message});

  final String title;
  final String message;

  @override
  State<CelebrationOverlay> createState() => _CelebrationOverlayState();
}

class _CelebrationOverlayState extends State<CelebrationOverlay> with SingleTickerProviderStateMixin {
  late final AnimationController _confettiController;
  late final List<_ConfettiPiece> _pieces;

  static const List<Color> _palette = [
    Color(0xFF6952D6), // Dusk Violet
    Color(0xFF1E9E82), // Meadow
    Color(0xFFF2734A), // Coral Ember
    Color(0xFFE3A83A), // XP Gold
  ];

  @override
  void initState() {
    super.initState();
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    _confettiController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: reduceMotion ? 1 : 1400),
    )..forward();
    final random = Random();
    _pieces = List.generate(18, (i) {
      return _ConfettiPiece(
        color: _palette[random.nextInt(_palette.length)],
        startX: random.nextDouble(),
        fallDelay: random.nextDouble() * 0.3,
        rotationTurns: (random.nextDouble() - 0.5) * 3,
        size: 6 + random.nextDouble() * 6,
      );
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _confettiController,
                builder: (context, _) => CustomPaint(
                  painter: _ConfettiPainter(pieces: _pieces, progress: _confettiController.value),
                ),
              ),
            ),
            FloatingGlassCard(
              radius: AppRadii.floating,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const FlowMascot(size: 88, mood: FlowMascotMood.celebrate),
                  const SizedBox(height: AppSpacing.md),
                  Text(widget.title, textAlign: TextAlign.center, style: theme.textTheme.displaySmall),
                  const SizedBox(height: AppSpacing.xs),
                  Text(widget.message, textAlign: TextAlign.center, style: theme.textTheme.bodyMedium),
                  const SizedBox(height: AppSpacing.lg),
                  FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Keep going'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfettiPiece {
  _ConfettiPiece({
    required this.color,
    required this.startX,
    required this.fallDelay,
    required this.rotationTurns,
    required this.size,
  });

  final Color color;
  final double startX; // 0..1, fraction of width
  final double fallDelay; // 0..1 fraction of total animation before this piece starts falling
  final double rotationTurns;
  final double size;
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter({required this.pieces, required this.progress});

  final List<_ConfettiPiece> pieces;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    for (final piece in pieces) {
      final localProgress = ((progress - piece.fallDelay) / (1 - piece.fallDelay)).clamp(0.0, 1.0);
      if (localProgress <= 0) continue;
      final dy = size.height * 0.15 + (size.height * 0.7) * Curves.easeIn.transform(localProgress);
      final dx = piece.startX * size.width;
      final opacity = localProgress > 0.75 ? (1 - (localProgress - 0.75) / 0.25) : 1.0;

      final paint = Paint()..color = piece.color.withValues(alpha: opacity.clamp(0.0, 1.0));
      canvas.save();
      canvas.translate(dx, dy);
      canvas.rotate(piece.rotationTurns * localProgress * 2 * pi);
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromCenter(center: Offset.zero, width: piece.size, height: piece.size * 0.6), const Radius.circular(2)),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) => oldDelegate.progress != progress;
}
