import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_gradients.dart';
import '../widgets/quick_add_sheet.dart';

/// Bottom-nav shell wrapping the 4 primary tabs (Home, Planner, Goals,
/// Profile) plus the raised center FAB — matches the reference design,
/// where AI Coach is reached via a Home card rather than being a 5th tab.
class ShellScaffold extends StatelessWidget {
  const ShellScaffold({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _tabs = [
    (icon: Icons.home_rounded, label: 'Home'),
    (icon: Icons.calendar_today_rounded, label: 'Planner'),
    (icon: Icons.flag_rounded, label: 'Goals'),
    (icon: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(gradient: AppGradients.primary, shape: BoxShape.circle),
        child: FloatingActionButton(
          heroTag: 'quick-add-fab',
          elevation: 0,
          backgroundColor: Colors.transparent,
          onPressed: () => showQuickAddSheet(context),
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 30),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int i = 0; i < _tabs.length; i++) ...[
              if (i == _tabs.length ~/ 2) const SizedBox(width: 56),
              _NavItem(
                icon: _tabs[i].icon,
                label: _tabs[i].label,
                selected: navigationShell.currentIndex == i,
                onTap: () => navigationShell.goBranch(i, initialLocation: i == navigationShell.currentIndex),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.icon, required this.label, required this.selected, required this.onTap});

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = selected ? theme.colorScheme.primary : (theme.brightness == Brightness.dark ? Colors.white54 : Colors.black45);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 2),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
