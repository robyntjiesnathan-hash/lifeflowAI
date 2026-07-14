import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Thin trend sparkline used under "Overall Progress" on the Habits screen,
/// per the reference design.
class AppSparkline extends StatelessWidget {
  const AppSparkline({super.key, required this.values, this.color, this.height = 40});

  final List<double> values;
  final Color? color;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) return SizedBox(height: height);
    final Color lineColor = color ?? Theme.of(context).colorScheme.primary;
    return SizedBox(
      height: height,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineTouchData: const LineTouchData(enabled: false),
          minY: 0,
          maxY: 100,
          lineBarsData: [
            LineChartBarData(
              spots: [for (int i = 0; i < values.length; i++) FlSpot(i.toDouble(), values[i])],
              isCurved: true,
              color: lineColor,
              barWidth: 3,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [lineColor.withValues(alpha: 0.18), lineColor.withValues(alpha: 0.0)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
