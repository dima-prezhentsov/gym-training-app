import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../domain/models/training_day.dart';
import '../view_models/schedule_view_model.dart';
import '../widgets/training_day_form.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ScheduleViewModel>();
    final schedule = viewModel.schedule;

    return SafeArea(
      bottom: false,
      child: ListView(
        key: const PageStorageKey('schedule-scroll'),
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 120),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Расписание',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              IconButton.filled(
                onPressed: schedule == null ? null : () => _openEditor(context),
                tooltip: 'Добавить тренировочный день',
                icon: const Icon(Icons.add_rounded),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            schedule?.name ?? 'Основная программа',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 28),
          if (viewModel.isLoading)
            const Center(child: CircularProgressIndicator())
          else if (viewModel.errorMessage != null)
            _ScheduleMessage(
              message: viewModel.errorMessage!,
              actionLabel: 'Повторить',
              onAction: viewModel.load,
            )
          else if (schedule == null || schedule.days.isEmpty)
            _ScheduleMessage(
              message: 'Добавьте первый тренировочный день',
              actionLabel: 'Добавить день',
              onAction: () => _openEditor(context),
            )
          else ...[
            for (final day in schedule.days) ...[
              _ScheduleDayCard(
                day: day,
                onTap: () => _openEditor(context, day: day),
              ),
              const SizedBox(height: 12),
            ],
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () => _openEditor(context),
              icon: const Icon(Icons.add_rounded),
              label: const Text('Добавить тренировочный день'),
            ),
            const SizedBox(height: 16),
            Text(
              'Изменения сохраняются локально до перезапуска приложения.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _openEditor(BuildContext context, {TrainingDay? day}) async {
    final viewModel = context.read<ScheduleViewModel>();
    await showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      builder: (_) => TrainingDayForm(
        initialDay: day,
        onSave: viewModel.saveDay,
        onDelete: day == null ? null : () => viewModel.deleteDay(day.id),
      ),
    );
    if (!context.mounted || viewModel.errorMessage == null) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(viewModel.errorMessage!)));
  }
}

class _ScheduleDayCard extends StatelessWidget {
  const _ScheduleDayCard({required this.day, required this.onTap});

  final TrainingDay day;
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
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.fitness_center_rounded),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      day.weekday.label,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      day.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${day.exercises.length} упражнений · '
                      '${day.estimatedDurationMinutes} мин',
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

class _ScheduleMessage extends StatelessWidget {
  const _ScheduleMessage({
    required this.message,
    required this.actionLabel,
    required this.onAction,
  });

  final String message;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(onPressed: onAction, child: Text(actionLabel)),
          ],
        ),
      ),
    );
  }
}
