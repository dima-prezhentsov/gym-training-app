import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../domain/models/workout_record.dart';
import '../../../core/widgets/empty_state.dart';
import '../../workout/view_models/workout_view_model.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<WorkoutViewModel>();

    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
            child: Text(
              'История',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          Expanded(child: _HistoryContent(viewModel: viewModel)),
        ],
      ),
    );
  }
}

class _HistoryContent extends StatelessWidget {
  const _HistoryContent({required this.viewModel});

  final WorkoutViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return switch (viewModel.historyStatus) {
      WorkoutHistoryStatus.initial || WorkoutHistoryStatus.loading =>
        const Center(child: CircularProgressIndicator()),
      WorkoutHistoryStatus.failure => _HistoryError(
        message: viewModel.errorMessage ?? 'Не удалось загрузить историю',
        onRetry: viewModel.loadHistory,
      ),
      WorkoutHistoryStatus.ready when viewModel.history.isEmpty =>
        const EmptyState(
          icon: Icons.bar_chart_rounded,
          title: 'История пока пуста',
          description:
              'Завершённые тренировки появятся здесь вместе с упражнениями, весом и повторениями.',
        ),
      WorkoutHistoryStatus.ready => ListView.separated(
        key: const PageStorageKey('history-scroll'),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
        itemCount: viewModel.history.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final record = viewModel.history[index];
          return _WorkoutRecordCard(
            record: record,
            onTap: () => _showDetails(context, record),
          );
        },
      ),
    };
  }

  Future<void> _showDetails(BuildContext context, WorkoutRecord record) async {
    await showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      builder: (_) => _WorkoutDetails(record: record),
    );
  }
}

class _WorkoutRecordCard extends StatelessWidget {
  const _WorkoutRecordCard({required this.record, required this.onTap});

  final WorkoutRecord record;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.lime,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: AppColors.background,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      record.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDate(record.completedAt),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${record.exercises.length} упр. · '
                      '${_setsLabel(record.totalSets)} · '
                      '${_durationLabel(record.duration)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkoutDetails extends StatelessWidget {
  const _WorkoutDetails({required this.record});

  final WorkoutRecord record;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.86,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  '${_formatDate(record.completedAt)} · '
                  '${_durationLabel(record.duration)} · '
                  '${_setsLabel(record.totalSets)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
              itemCount: record.exercises.length,
              separatorBuilder: (_, _) => const SizedBox(height: 18),
              itemBuilder: (context, index) {
                final exercise = record.exercises[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      exercise.muscleGroup.label,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    if (exercise.sets.isEmpty)
                      Text(
                        'Нет выполненных подходов',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    else
                      for (
                        var setIndex = 0;
                        setIndex < exercise.sets.length;
                        setIndex++
                      )
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: Text(
                            '${setIndex + 1}. '
                            '${exercise.sets[setIndex].repetitions} повторений · '
                            '${_formatWeight(exercise.sets[setIndex].weightKg)} кг',
                          ),
                        ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryError extends StatelessWidget {
  const _HistoryError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

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
            FilledButton(onPressed: onRetry, child: const Text('Повторить')),
          ],
        ),
      ),
    );
  }
}

String _formatDate(DateTime date) {
  String twoDigits(int value) => value.toString().padLeft(2, '0');
  return '${twoDigits(date.day)}.${twoDigits(date.month)}.${date.year}';
}

String _formatWeight(double weight) {
  return weight == weight.roundToDouble()
      ? weight.toInt().toString()
      : weight.toStringAsFixed(1);
}

String _durationLabel(Duration duration) {
  return duration.inMinutes == 0 ? '< 1 мин' : '${duration.inMinutes} мин';
}

String _setsLabel(int count) {
  final mod100 = count % 100;
  final mod10 = count % 10;
  final suffix = mod100 >= 11 && mod100 <= 14
      ? 'подходов'
      : switch (mod10) {
          1 => 'подход',
          2 || 3 || 4 => 'подхода',
          _ => 'подходов',
        };
  return '$count $suffix';
}
