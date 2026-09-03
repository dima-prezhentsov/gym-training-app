import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../domain/models/active_workout.dart';
import '../../../../domain/models/exercise_record.dart';
import '../../../../domain/models/training_day.dart';
import '../../schedule/view_models/schedule_view_model.dart';
import '../view_models/workout_view_model.dart';

class ActiveWorkoutScreen extends StatefulWidget {
  const ActiveWorkoutScreen({super.key, required this.trainingDayId});

  final String trainingDayId;

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  Timer? _timer;
  bool _startScheduled = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheduleViewModel = context.watch<ScheduleViewModel>();
    final workoutViewModel = context.watch<WorkoutViewModel>();
    final active = workoutViewModel.activeWorkout;

    if (active != null) {
      return _WorkoutContent(
        workout: active,
        isDifferentDay: active.trainingDayId != widget.trainingDayId,
      );
    }

    if (scheduleViewModel.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (scheduleViewModel.schedule == null &&
        scheduleViewModel.errorMessage != null) {
      return _WorkoutLoadError(
        message: scheduleViewModel.errorMessage!,
        onRetry: scheduleViewModel.load,
        onBack: () => _goBack(context),
      );
    }

    if (scheduleViewModel.schedule == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final day = _findDay(scheduleViewModel, widget.trainingDayId);
    if (day == null) {
      return _MissingTrainingDay(onBack: () => _goBack(context));
    }

    if (!_startScheduled) {
      _startScheduled = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        context.read<WorkoutViewModel>().startWorkout(day);
      });
    }
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

TrainingDay? _findDay(ScheduleViewModel viewModel, String dayId) {
  for (final day in viewModel.schedule?.days ?? const <TrainingDay>[]) {
    if (day.id == dayId) return day;
  }
  return null;
}

class _WorkoutContent extends StatelessWidget {
  const _WorkoutContent({required this.workout, required this.isDifferentDay});

  final ActiveWorkout workout;
  final bool isDifferentDay;

  @override
  Widget build(BuildContext context) {
    final elapsed = DateTime.now().difference(workout.startedAt);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 20, 14),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => _goBack(context),
                    tooltip: 'Назад',
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Активная тренировка',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          workout.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                  _TimerPill(duration: elapsed),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                key: const PageStorageKey('active-workout-scroll'),
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
                children: [
                  if (isDifferentDay) ...[
                    const _ActiveWorkoutNotice(),
                    const SizedBox(height: 14),
                  ],
                  _WorkoutSummary(workout: workout),
                  const SizedBox(height: 24),
                  for (
                    var index = 0;
                    index < workout.exercises.length;
                    index++
                  ) ...[
                    _ExerciseCard(
                      exercise: workout.exercises[index],
                      number: index + 1,
                    ),
                    if (index != workout.exercises.length - 1)
                      const SizedBox(height: 14),
                  ],
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    key: const ValueKey('finish-workout-button'),
                    onPressed: () => _finishWorkout(context, workout),
                    icon: const Icon(Icons.check_rounded),
                    label: const Text('Завершить тренировку'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Можно выйти: прогресс сохранится до перезапуска приложения.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _finishWorkout(
    BuildContext context,
    ActiveWorkout workout,
  ) async {
    if (workout.totalSets == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Добавьте хотя бы один подход')),
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Завершить тренировку?'),
        content: Text(
          'Будет сохранено: ${_setsLabel(workout.totalSets)}. '
          'После завершения изменить запись будет нельзя.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Продолжить'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Завершить'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final record = await context.read<WorkoutViewModel>().finishWorkout();
    if (!context.mounted) return;
    if (record == null) {
      final message = context.read<WorkoutViewModel>().errorMessage;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message ?? 'Не удалось завершить тренировку')),
      );
      return;
    }
    context.go('/history');
  }
}

class _WorkoutSummary extends StatelessWidget {
  const _WorkoutSummary({required this.workout});

  final ActiveWorkout workout;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.lime,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.fitness_center_rounded,
            size: 30,
            color: AppColors.background,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'Упражнений: ${workout.exercises.length}',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppColors.background),
            ),
          ),
          Text(
            'Подходов: ${workout.totalSets}',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppColors.background),
          ),
        ],
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  const _ExerciseCard({required this.exercise, required this.number});

  final ExerciseRecord exercise;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Text('$number'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
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
                    ],
                  ),
                ),
              ],
            ),
            if (exercise.sets.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 12),
              for (var index = 0; index < exercise.sets.length; index++)
                _SetRow(
                  number: index + 1,
                  repetitions: exercise.sets[index].repetitions,
                  weightKg: exercise.sets[index].weightKg,
                  onDelete: () => context.read<WorkoutViewModel>().deleteSet(
                    exerciseId: exercise.exerciseId,
                    setId: exercise.sets[index].id,
                  ),
                ),
            ],
            const SizedBox(height: 14),
            OutlinedButton.icon(
              onPressed: () => _openSetForm(context, exercise),
              icon: const Icon(Icons.add_rounded),
              label: const Text('Добавить подход'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openSetForm(
    BuildContext context,
    ExerciseRecord exercise,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      builder: (_) => _SetForm(
        exerciseName: exercise.name,
        onSubmit: (repetitions, weightKg) {
          context.read<WorkoutViewModel>().addSet(
            exerciseId: exercise.exerciseId,
            repetitions: repetitions,
            weightKg: weightKg,
          );
        },
      ),
    );
  }
}

class _SetRow extends StatelessWidget {
  const _SetRow({
    required this.number,
    required this.repetitions,
    required this.weightKg,
    required this.onDelete,
  });

  final int number;
  final int repetitions;
  final double weightKg;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(
              '$number',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(child: Text('$repetitions повторений')),
          Text('${_formatWeight(weightKg)} кг'),
          const SizedBox(width: 4),
          IconButton(
            onPressed: onDelete,
            tooltip: 'Удалить подход $number',
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.close_rounded, size: 19),
          ),
        ],
      ),
    );
  }
}

class _SetForm extends StatefulWidget {
  const _SetForm({required this.exerciseName, required this.onSubmit});

  final String exerciseName;
  final void Function(int repetitions, double weightKg) onSubmit;

  @override
  State<_SetForm> createState() => _SetFormState();
}

class _SetFormState extends State<_SetForm> {
  final _formKey = GlobalKey<FormState>();
  final _repetitionsController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void dispose() {
    _repetitionsController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        18,
        20,
        20 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Новый подход',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 4),
            Text(
              widget.exerciseName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    key: const ValueKey('set-repetitions-field'),
                    controller: _repetitionsController,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Повторения',
                      suffixText: 'раз',
                    ),
                    validator: (value) {
                      final repetitions = int.tryParse(value?.trim() ?? '');
                      return repetitions == null || repetitions <= 0
                          ? 'Введите число больше 0'
                          : null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    key: const ValueKey('set-weight-field'),
                    controller: _weightController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Вес',
                      suffixText: 'кг',
                    ),
                    validator: (value) {
                      final weight = double.tryParse(
                        (value ?? '').trim().replaceAll(',', '.'),
                      );
                      return weight == null || weight < 0
                          ? 'Введите вес от 0'
                          : null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            FilledButton(
              key: const ValueKey('save-set-button'),
              onPressed: _submit,
              child: const Text('Добавить подход'),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final repetitions = int.parse(_repetitionsController.text.trim());
    final weight = double.parse(
      _weightController.text.trim().replaceAll(',', '.'),
    );
    widget.onSubmit(repetitions, weight);
    Navigator.of(context).pop();
  }
}

class _TimerPill extends StatelessWidget {
  const _TimerPill({required this.duration});

  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceRaised,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.timer_outlined, size: 18, color: AppColors.lime),
          const SizedBox(width: 6),
          Text(
            _formatDuration(duration),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

class _ActiveWorkoutNotice extends StatelessWidget {
  const _ActiveWorkoutNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceRaised,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.outline),
      ),
      child: const Text(
        'У вас уже есть активная тренировка — продолжаем её.',
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _MissingTrainingDay extends StatelessWidget {
  const _MissingTrainingDay({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.search_off_rounded, size: 42),
                const SizedBox(height: 16),
                Text(
                  'Тренировочный день не найден',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                FilledButton(onPressed: onBack, child: const Text('Назад')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WorkoutLoadError extends StatelessWidget {
  const _WorkoutLoadError({
    required this.message,
    required this.onRetry,
    required this.onBack,
  });

  final String message;
  final VoidCallback onRetry;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                FilledButton(
                  onPressed: onRetry,
                  child: const Text('Повторить'),
                ),
                TextButton(onPressed: onBack, child: const Text('На главную')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String _formatDuration(Duration duration) {
  String twoDigits(int value) => value.toString().padLeft(2, '0');
  final safeDuration = duration.isNegative ? Duration.zero : duration;
  final hours = safeDuration.inHours;
  final minutes = safeDuration.inMinutes.remainder(60);
  final seconds = safeDuration.inSeconds.remainder(60);
  return hours > 0
      ? '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}'
      : '${twoDigits(minutes)}:${twoDigits(seconds)}';
}

String _formatWeight(double weight) {
  return weight == weight.roundToDouble()
      ? weight.toInt().toString()
      : weight.toStringAsFixed(1);
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

void _goBack(BuildContext context) {
  if (context.canPop()) {
    context.pop();
  } else {
    context.go('/home');
  }
}
