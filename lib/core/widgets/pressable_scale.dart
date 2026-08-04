import 'package:flutter/material.dart';

/// The app's "press feedback" motion moment — a quiet 120ms scale-to-0.97
/// on press with a spring-back release, used on every primary tappable
/// surface. Deliberately subtle: this is a functional micro-interaction,
/// not an orchestrated moment (see `celebration_overlay.dart` for that).
class PressableScale extends StatefulWidget {
  const PressableScale({super.key, required this.child, this.onTap, this.borderRadius});

  final Widget child;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;

  @override
  State<PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<PressableScale> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (widget.onTap == null) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOutCubic,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: widget.borderRadius,
            onTap: widget.onTap,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
