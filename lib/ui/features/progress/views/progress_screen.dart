import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../domain/models/progress_overview.dart';
import '../../../core/utils/app_error_feedback.dart';
import '../../../core/widgets/async_action_button.dart';
import '../../../core/widgets/empty_state.dart';
import '../../history/views/history_screen.dart';
import '../view_models/progress_view_model.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key, this.showHistory = false});

  final bool showHistory;

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  late bool _showOverview;

  @override
  void initState() {
    super.initState();
    _showOverview = !widget.showHistory;
  }

  @override
  void didUpdateWidget(covariant ProgressScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.showHistory != widget.showHistory) {
      _showOverview = !widget.showHistory;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
            child: Text(
              'Прогресс',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _SectionSwitch(
              showOverview: _showOverview,
              onChanged: (value) => setState(() => _showOverview = value),
            ),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: _showOverview
                ? const _ProgressOverviewContent()
                : const HistoryScreen(showHeader: false),
          ),
        ],
      ),
    );
  }
}

class _SectionSwitch extends StatelessWidget {
  const _SectionSwitch({required this.showOverview, required this.onChanged});

  final bool showOverview;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceRaised,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.outline),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SwitchButton(
              key: const ValueKey('progress-overview-tab'),
              label: 'Обзор',
              selected: showOverview,
              onTap: () => onChanged(true),
            ),
          ),
          Expanded(
            child: _SwitchButton(
              key: const ValueKey('progress-history-tab'),
              label: 'История',
              selected: !showOverview,
              onTap: () => onChanged(false),
            ),
          ),
        ],
      ),
    );
  }
}

class _SwitchButton extends StatelessWidget {
  const _SwitchButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.lime : Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: selected ? AppColors.background : AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProgressOverviewContent extends StatelessWidget {
  const _ProgressOverviewContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProgressViewModel>();
    return switch (viewModel.status) {
      ProgressStatus.initial || ProgressStatus.loading => const Center(
        child: CircularProgressIndicator(),
      ),
      ProgressStatus.failure => _ProgressError(
        message: viewModel.errorMessage ?? 'Не удалось загрузить статистику',
        onRetry: () => retryWithErrorFeedback(
          context,
          operation: viewModel.load,
          errorMessage: () => viewModel.errorMessage,
          fallbackMessage: 'Не удалось загрузить статистику',
        ),
      ),
      ProgressStatus.ready when viewModel.overview?.isEmpty ?? true =>
        _ProgressEmpty(onOpenSchedule: () => context.go('/schedule')),
      ProgressStatus.ready => _ProgressDashboard(viewModel: viewModel),
    };
  }
}

class _ProgressDashboard extends StatelessWidget {
  const _ProgressDashboard({required this.viewModel});

  final ProgressViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final overview = viewModel.overview!;
    return ListView(
      key: const PageStorageKey('progress-scroll'),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
      children: [
        _PeriodSelector(viewModel: viewModel),
        const SizedBox(height: 16),
        _StreakCard(overview: overview),
        const SizedBox(height: 12),
        _SummaryCard(overview: overview),
        if (viewModel.selectedExercise case final exercise?) ...[
          const SizedBox(height: 28),
          const _SectionTitle(title: 'Динамика упражнения'),
          const SizedBox(height: 12),
          _ExerciseChartCard(viewModel: viewModel, exercise: exercise),
        ],
        if (overview.personalRecords.isNotEmpty) ...[
          const SizedBox(height: 28),
          const _SectionTitle(title: 'Личные рекорды'),
          const SizedBox(height: 12),
          _PersonalRecordsCard(
            records: overview.personalRecords.take(3).toList(),
          ),
        ],
        if (overview.muscleGroups.isNotEmpty) ...[
          const SizedBox(height: 28),
          const _SectionTitle(title: 'Подходы по группам мышц'),
          const SizedBox(height: 12),
          _MuscleGroupsCard(groups: overview.muscleGroups),
        ],
      ],
    );
  }
}

class _PeriodSelector extends StatelessWidget {
  const _PeriodSelector({required this.viewModel});

  final ProgressViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: ProgressPeriod.values
          .map(
            (period) => ChoiceChip(
              label: Text(period.label),
              selected: viewModel.period == period,
              onSelected: (_) => viewModel.selectPeriod(period),
              showCheckmark: false,
              selectedColor: AppColors.lime,
              backgroundColor: AppColors.surfaceRaised,
              side: BorderSide(
                color: viewModel.period == period
                    ? AppColors.lime
                    : AppColors.outline,
              ),
              labelStyle: TextStyle(
                color: viewModel.period == period
                    ? AppColors.background
                    : AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard({required this.overview});

  final ProgressOverview overview;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('progress-streak-card'),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.lime,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.background.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.local_fire_department_rounded,
              color: AppColors.background,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${overview.currentStreakDays} ${_daysLabel(overview.currentStreakDays)}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.background,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'без пропуска тренировки по плану',
                  style: TextStyle(
                    color: AppColors.background,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Лучший',
                style: TextStyle(color: AppColors.background),
              ),
              Text(
                '${overview.bestStreakDays} дн.',
                style: const TextStyle(
                  color: AppColors.background,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.overview});

  final ProgressOverview overview;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        child: Row(
          children: [
            _SummaryItem(
              value: '${overview.workoutCount}',
              label: 'тренировок',
            ),
            const _VerticalDivider(),
            _SummaryItem(value: '${overview.totalMinutes}', label: 'минут'),
            const _VerticalDivider(),
            _SummaryItem(value: '${overview.totalSets}', label: 'подходов'),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 40,
      child: VerticalDivider(color: AppColors.outline),
    );
  }
}

class _ExerciseChartCard extends StatelessWidget {
  const _ExerciseChartCard({required this.viewModel, required this.exercise});

  final ProgressViewModel viewModel;
  final ExerciseProgress exercise;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              key: ValueKey('exercise-${viewModel.selectedExerciseId}'),
              initialValue: viewModel.selectedExerciseId,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Упражнение'),
              items: viewModel.overview!.exercises
                  .map(
                    (item) => DropdownMenuItem(
                      value: item.exerciseId,
                      child: Text(item.name, overflow: TextOverflow.ellipsis),
                    ),
                  )
                  .toList(growable: false),
              onChanged: viewModel.selectExercise,
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ExerciseProgressMetric.values
                  .map(
                    (metric) => ChoiceChip(
                      label: Text(metric.label),
                      selected: viewModel.metric == metric,
                      onSelected: (_) => viewModel.selectMetric(metric),
                      showCheckmark: false,
                    ),
                  )
                  .toList(growable: false),
            ),
            const SizedBox(height: 20),
            _ProgressChart(
              key: ValueKey(
                'progress-chart-${exercise.exerciseId}-${viewModel.metric.name}',
              ),
              points: exercise.points,
              metric: viewModel.metric,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressChart extends StatelessWidget {
  const _ProgressChart({super.key, required this.points, required this.metric});

  final List<ExerciseProgressPoint> points;
  final ExerciseProgressMetric metric;

  @override
  Widget build(BuildContext context) {
    final values = points.map((point) => point.valueFor(metric)).toList();
    final latest = values.last;
    final first = values.first;
    final delta = first == 0 ? 0.0 : (latest - first) / first * 100;
    return Semantics(
      label:
          '${metric.label}: последнее значение ${_formatMetric(latest, metric)}, изменение ${delta.toStringAsFixed(0)} процентов',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  _formatMetric(latest, metric),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Text(
                '${delta >= 0 ? '+' : ''}${delta.toStringAsFixed(0)}%',
                style: TextStyle(
                  color: delta >= 0 ? AppColors.lime : AppColors.error,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 156,
            child: CustomPaint(
              painter: _ProgressChartPainter(values: values),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_shortDate(points.first.date)),
              Text(_shortDate(points.last.date)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgressChartPainter extends CustomPainter {
  const _ProgressChartPainter({required this.values});

  final List<double> values;

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.outline
      ..strokeWidth = 1;
    for (var index = 0; index < 4; index++) {
      final y = size.height * index / 3;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final minValue = values.reduce(math.min);
    final maxValue = values.reduce(math.max);
    final range = math.max(maxValue - minValue, 1).toDouble();
    final points = List.generate(values.length, (index) {
      final x = values.length == 1
          ? size.width / 2
          : size.width * index / (values.length - 1);
      final normalized = (values[index] - minValue) / range;
      return Offset(x, size.height - 10 - normalized * (size.height - 20));
    });
    final linePaint = Paint()
      ..color = AppColors.lime
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (final point in points.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }
    canvas.drawPath(path, linePaint);

    final dotPaint = Paint()..color = AppColors.lime;
    final innerPaint = Paint()..color = AppColors.background;
    for (final point in points) {
      canvas
        ..drawCircle(point, 5, dotPaint)
        ..drawCircle(point, 2, innerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ProgressChartPainter oldDelegate) =>
      oldDelegate.values != values;
}

class _PersonalRecordsCard extends StatelessWidget {
  const _PersonalRecordsCard({required this.records});

  final List<PersonalRecord> records;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            for (var index = 0; index < records.length; index++) ...[
              if (index > 0) const Divider(height: 25),
              Row(
                children: [
                  const Icon(Icons.emoji_events_rounded, color: AppColors.lime),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          records[index].exerciseName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${_formatNumber(records[index].weightKg)} кг × ${records[index].repetitions}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    _shortDate(records[index].achievedAt),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MuscleGroupsCard extends StatelessWidget {
  const _MuscleGroupsCard({required this.groups});

  final List<MuscleGroupProgress> groups;

  @override
  Widget build(BuildContext context) {
    final maxSets = groups.map((group) => group.setCount).reduce(math.max);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: groups
              .take(6)
              .map((group) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              group.group.label,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          Text(
                            '${group.setCount}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          height: 7,
                          color: AppColors.outline,
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            widthFactor: group.setCount / maxSets,
                            child: const ColoredBox(color: AppColors.lime),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              })
              .toList(growable: false),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleLarge);
  }
}

class _ProgressEmpty extends StatelessWidget {
  const _ProgressEmpty({required this.onOpenSchedule});

  final VoidCallback onOpenSchedule;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const EmptyState(
          icon: Icons.show_chart_rounded,
          title: 'Недостаточно данных',
          description:
              'Завершите первую тренировку, чтобы увидеть статистику и динамику упражнений.',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onOpenSchedule,
              child: const Text('Открыть расписание'),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProgressError extends StatelessWidget {
  const _ProgressError({required this.message, required this.onRetry});

  final String message;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            AsyncActionButton(label: 'Повторить', onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}

String _formatMetric(double value, ExerciseProgressMetric metric) {
  final suffix = metric == ExerciseProgressMetric.volume ? 'кг объёма' : 'кг';
  return '${_formatNumber(value)} $suffix';
}

String _formatNumber(double value) => value == value.roundToDouble()
    ? value.toInt().toString()
    : value.toStringAsFixed(1);

String _shortDate(DateTime date) =>
    '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}';

String _daysLabel(int value) {
  final mod100 = value % 100;
  if (mod100 >= 11 && mod100 <= 14) return 'дней';
  return switch (value % 10) {
    1 => 'день',
    2 || 3 || 4 => 'дня',
    _ => 'дней',
  };
}
