import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_gradients.dart';
import '../../../../core/widgets/flow_mascot.dart';

/// Shown briefly while the router's redirect logic determines where the
/// user should land (auth welcome / onboarding / home shell).
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.homeHero),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const FlowMascot(size: 88),
              const SizedBox(height: 20),
              ShaderMask(
                shaderCallback: (bounds) => AppGradients.primary.createShader(bounds),
                child: const Text(
                  'LifeFlow AI',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Colors.white),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your personal secretary in your pocket.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ).animate().fadeIn(duration: 500.ms),
        ),
      ),
    );
  }
}
