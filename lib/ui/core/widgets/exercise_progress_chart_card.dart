import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../domain/models/progress_overview.dart';

class ExerciseProgressChartCard extends StatelessWidget {
  const ExerciseProgressChartCard({
    super.key,
    required this.exercises,
    required this.exercise,
    required this.metric,
    required this.onSelectExercise,
    required this.onSelectMetric,
  });

  final List<ExerciseProgress> exercises;
  final ExerciseProgress exercise;
  final ExerciseProgressMetric metric;
  final ValueChanged<String?> onSelectExercise;
  final ValueChanged<ExerciseProgressMetric> onSelectMetric;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              key: ValueKey('exercise-${exercise.exerciseId}'),
              initialValue: exercise.exerciseId,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Упражнение'),
              items: exercises
                  .map(
                    (item) => DropdownMenuItem(
                      value: item.exerciseId,
                      child: Text(item.name, overflow: TextOverflow.ellipsis),
                    ),
                  )
                  .toList(growable: false),
              onChanged: onSelectExercise,
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ExerciseProgressMetric.values
                  .map(
                    (option) => ChoiceChip(
                      label: Text(option.label),
                      selected: metric == option,
                      onSelected: (_) => onSelectMetric(option),
                      showCheckmark: false,
                    ),
                  )
                  .toList(growable: false),
            ),
            if (metric == ExerciseProgressMetric.estimatedMax) ...[
              const SizedBox(height: 10),
              Text(
                'Примерный максимальный вес на одно повторение, рассчитанный по лучшему подходу.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            const SizedBox(height: 20),
            _ProgressChart(
              key: ValueKey(
                'progress-chart-${exercise.exerciseId}-${metric.name}',
              ),
              points: exercise.points,
              metric: metric,
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
    final spots = List.generate(
      values.length,
      (index) => FlSpot(index.toDouble(), values[index]),
    );
    final latest = values.last;
    final first = values.first;
    final delta = first == 0 ? 0.0 : (latest - first) / first * 100;
    final minValue = values.reduce(math.min);
    final maxValue = values.reduce(math.max);
    final padding = math.max(
      math.max((maxValue - minValue) * 0.12, maxValue.abs() * 0.08),
      1,
    );
    final minY = math.max(0, minValue - padding).toDouble();
    final maxY = maxValue + padding;
    final yInterval = (maxY - minY) / 3;
    final labelIndexes = {0, (points.length - 1) ~/ 2, points.length - 1};
    final axisStyle = Theme.of(
      context,
    ).textTheme.labelSmall?.copyWith(color: AppColors.textSecondary);
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
          const SizedBox(height: 6),
          Text(
            '${metric.label} по тренировкам',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 230,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: math.max(1, points.length - 1).toDouble(),
                minY: minY,
                maxY: maxY,
                gridData: FlGridData(
                  drawVerticalLine: false,
                  horizontalInterval: yInterval,
                  getDrawingHorizontalLine: (_) =>
                      const FlLine(color: AppColors.outline, strokeWidth: 1),
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    axisNameWidget: Text(
                      _metricAxisLabel(metric),
                      style: axisStyle,
                    ),
                    axisNameSize: 22,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 48,
                      interval: yInterval,
                      getTitlesWidget: (value, meta) => SideTitleWidget(
                        meta: meta,
                        space: 8,
                        child: Text(_formatAxisValue(value), style: axisStyle),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    axisNameWidget: Text('Дата тренировки', style: axisStyle),
                    axisNameSize: 24,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final index = value.round();
                        if (index < 0 ||
                            index >= points.length ||
                            !labelIndexes.contains(index)) {
                          return const SizedBox.shrink();
                        }
                        return SideTitleWidget(
                          meta: meta,
                          space: 8,
                          child: Text(
                            _shortDate(points[index].date),
                            style: axisStyle,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) => AppColors.surfaceRaised,
                    tooltipBorder: const BorderSide(color: AppColors.outline),
                    fitInsideHorizontally: true,
                    fitInsideVertically: true,
                    getTooltipItems: (touchedSpots) => touchedSpots
                        .map((spot) {
                          final index = spot.x.round();
                          return LineTooltipItem(
                            '${_shortDate(points[index].date)}\n${_formatMetric(spot.y, metric)}',
                            const TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        })
                        .toList(growable: false),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    color: AppColors.lime,
                    barWidth: 3,
                    isCurved: points.length > 2,
                    preventCurveOverShooting: true,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.lime.withValues(alpha: 0.22),
                          AppColors.lime.withValues(alpha: 0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
            ),
          ),
        ],
      ),
    );
  }
}

String _formatMetric(double value, ExerciseProgressMetric metric) {
  final suffix = metric == ExerciseProgressMetric.volume ? 'кг объёма' : 'кг';
  return '${_formatNumber(value)} $suffix';
}

String _metricAxisLabel(ExerciseProgressMetric metric) => switch (metric) {
  ExerciseProgressMetric.estimatedMax => 'Расчётный 1ПМ, кг',
  ExerciseProgressMetric.maxWeight => 'Макс. вес, кг',
  ExerciseProgressMetric.volume => 'Объём, кг',
};

String _formatAxisValue(double value) {
  if (value.abs() >= 1000) {
    final thousands = value / 1000;
    return '${thousands.toStringAsFixed(thousands >= 10 ? 0 : 1)} тыс.';
  }
  return _formatNumber(value);
}

String _formatNumber(double value) => value == value.roundToDouble()
    ? value.toInt().toString()
    : value.toStringAsFixed(1);

String _shortDate(DateTime date) =>
    '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}';
