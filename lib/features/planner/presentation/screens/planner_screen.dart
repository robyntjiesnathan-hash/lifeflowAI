import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_segmented_control.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../../../core/widgets/week_day_strip.dart';
import '../../application/tasks_providers.dart';
import '../../domain/task.dart';
import '../widgets/add_edit_task_sheet.dart';
import '../widgets/task_tile.dart';

enum _PlannerView { day, week, month }

bool _isSameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

DateTime _dayOnly(DateTime d) => DateTime(d.year, d.month, d.day);

DateTime _mondayOf(DateTime d) => _dayOnly(d).subtract(Duration(days: d.weekday - 1));

int _timeSortKey(Task t) {
  if (t.dueTime == null) return 24 * 60 + 1;
  final parts = t.dueTime!.split(':');
  final hour = parts.isNotEmpty ? int.tryParse(parts[0]) ?? 0 : 0;
  final minute = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;
  return hour * 60 + minute;
}

List<Task> _tasksOn(List<Task> tasks, DateTime day) {
  final matching = tasks.where((t) => t.dueDate != null && _isSameDay(t.dueDate!, day)).toList();
  matching.sort((a, b) => _timeSortKey(a).compareTo(_timeSortKey(b)));
  return matching;
}

class PlannerScreen extends ConsumerStatefulWidget {
  const PlannerScreen({super.key});

  @override
  ConsumerState<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends ConsumerState<PlannerScreen> {
  _PlannerView _view = _PlannerView.day;
  DateTime _selectedDate = _dayOnly(DateTime.now());
  DateTime _focusedMonth = _dayOnly(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(tasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Planner'),
        leading: Navigator.canPop(context) ? const BackButton() : null,
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(tasksProvider),
        child: tasksAsync.when(
          loading: () => ListView(children: const [LoadingCardSkeleton(), LoadingCardSkeleton()]),
          error: (error, stack) =>
              ListView(children: [Padding(padding: const EdgeInsets.all(32), child: Text('$error'))]),
          data: (tasks) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 0),
                child: AppSegmentedControl<_PlannerView>(
                  options: const [
                    (_PlannerView.day, 'Day'),
                    (_PlannerView.week, 'Week'),
                    (_PlannerView.month, 'Month'),
                  ],
                  value: _view,
                  onChanged: (v) => setState(() => _view = v),
                ),
              ),
              Expanded(
                child: switch (_view) {
                  _PlannerView.day => _DayView(
                      tasks: tasks,
                      selectedDate: _selectedDate,
                      onDateChanged: (d) => setState(() => _selectedDate = d),
                    ),
                  _PlannerView.week => _WeekView(tasks: tasks, selectedDate: _selectedDate),
                  _PlannerView.month => _MonthView(
                      tasks: tasks,
                      selectedDate: _selectedDate,
                      focusedMonth: _focusedMonth,
                      onDaySelected: (d, f) => setState(() {
                        _selectedDate = d;
                        _focusedMonth = f;
                      }),
                    ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DayView extends ConsumerWidget {
  const _DayView({required this.tasks, required this.selectedDate, required this.onDateChanged});

  final List<Task> tasks;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monday = _mondayOf(selectedDate);
    final dayTasks = _tasksOn(tasks, selectedDate);
    final today = _dayOnly(DateTime.now());
    final isToday = _isSameDay(selectedDate, today);
    final headerLabel = isToday ? 'Today, ${DateFormat('MMM d').format(selectedDate)}' : DateFormat('EEE, MMM d').format(selectedDate);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left_rounded),
              onPressed: () => onDateChanged(selectedDate.subtract(const Duration(days: 1))),
            ),
            Text(headerLabel, style: Theme.of(context).textTheme.titleMedium),
            IconButton(
              icon: const Icon(Icons.chevron_right_rounded),
              onPressed: () => onDateChanged(selectedDate.add(const Duration(days: 1))),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        WeekDayStrip(
          days: [for (int i = 0; i < 7; i++) '${monday.add(Duration(days: i)).day}'],
          selectedIndex: selectedDate.weekday - 1,
          onSelect: (i) => onDateChanged(monday.add(Duration(days: i))),
        ),
        const SizedBox(height: AppSpacing.lg),
        if (dayTasks.isEmpty)
          EmptyState(
            icon: Icons.event_available_rounded,
            title: 'Nothing scheduled',
            message: 'Add a task for this day and Flow will help you stay on track.',
            actionLabel: 'Add Task',
            onAction: () => showAddEditTaskSheet(context, initialDate: selectedDate),
          )
        else
          for (final task in dayTasks)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: TaskTile(
                task: task,
                onTap: () => context.push('/planner/task/${task.id}'),
                onToggle: () => ref.read(tasksControllerProvider.notifier).toggleStatus(task.id),
              ),
            ),
        const SizedBox(height: AppSpacing.md),
        if (dayTasks.isNotEmpty)
          GradientPillButton(
            label: 'Add Task',
            icon: Icons.add_rounded,
            onPressed: () => showAddEditTaskSheet(context, initialDate: selectedDate),
          ),
      ],
    );
  }
}

class _WeekView extends ConsumerWidget {
  const _WeekView({required this.tasks, required this.selectedDate});

  final List<Task> tasks;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monday = _mondayOf(selectedDate);
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        for (int i = 0; i < 7; i++) ...[
          Builder(builder: (context) {
            final day = monday.add(Duration(days: i));
            final dayTasks = _tasksOn(tasks, day);
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateFormat('EEEE, MMM d').format(day), style: theme.textTheme.titleSmall),
                  const SizedBox(height: AppSpacing.sm),
                  if (dayTasks.isEmpty)
                    Text('No tasks', style: theme.textTheme.bodySmall)
                  else
                    for (final task in dayTasks)
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: TaskTile(
                          task: task,
                          onTap: () => context.push('/planner/task/${task.id}'),
                          onToggle: () => ref.read(tasksControllerProvider.notifier).toggleStatus(task.id),
                        ),
                      ),
                ],
              ),
            );
          }),
        ],
      ],
    );
  }
}

class _MonthView extends ConsumerWidget {
  const _MonthView({
    required this.tasks,
    required this.selectedDate,
    required this.focusedMonth,
    required this.onDaySelected,
  });

  final List<Task> tasks;
  final DateTime selectedDate;
  final DateTime focusedMonth;
  final void Function(DateTime selected, DateTime focused) onDaySelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dayTasks = _tasksOn(tasks, selectedDate);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        TableCalendar<Task>(
          firstDay: DateTime(DateTime.now().year - 2),
          lastDay: DateTime(DateTime.now().year + 2),
          focusedDay: focusedMonth,
          calendarFormat: CalendarFormat.month,
          headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
          selectedDayPredicate: (d) => _isSameDay(d, selectedDate),
          eventLoader: (d) => _tasksOn(tasks, d),
          onDaySelected: (selected, focused) => onDaySelected(_dayOnly(selected), focused),
          onPageChanged: (focused) => onDaySelected(selectedDate, focused),
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(color: theme.colorScheme.primary, shape: BoxShape.circle),
            todayDecoration: BoxDecoration(color: theme.colorScheme.primary.withValues(alpha: 0.3), shape: BoxShape.circle),
            markerDecoration: BoxDecoration(color: theme.colorScheme.primary, shape: BoxShape.circle),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(DateFormat('EEEE, MMM d').format(selectedDate), style: theme.textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        if (dayTasks.isEmpty)
          EmptyState(
            icon: Icons.event_available_rounded,
            title: 'Nothing scheduled',
            message: 'Add a task for this day.',
            actionLabel: 'Add Task',
            onAction: () => showAddEditTaskSheet(context, initialDate: selectedDate),
          )
        else
          for (final task in dayTasks)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: TaskTile(
                task: task,
                onTap: () => context.push('/planner/task/${task.id}'),
                onToggle: () => ref.read(tasksControllerProvider.notifier).toggleStatus(task.id),
              ),
            ),
      ],
    );
  }
}
