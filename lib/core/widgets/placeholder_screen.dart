import 'package:flutter/material.dart';

/// Temporary "coming soon" screen used for routes whose real feature UI
/// hasn't landed yet during incremental development. Every usage of this
/// widget is meant to be replaced before the polish pass.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.construction_rounded, size: 40, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 12),
            Text('$title is under construction', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
