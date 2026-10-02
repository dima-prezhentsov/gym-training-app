import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:gym_training_app/data/repositories/in_memory_workout_repository.dart';
import 'package:gym_training_app/data/repositories/workout_repository.dart';
import 'package:gym_training_app/domain/models/exercise.dart';
import 'package:gym_training_app/domain/models/active_workout.dart';
import 'package:gym_training_app/domain/models/muscle_group.dart';
import 'package:gym_training_app/domain/models/training_day.dart';
import 'package:gym_training_app/domain/models/training_weekday.dart';
import 'package:gym_training_app/domain/models/workout_record.dart';
import 'package:gym_training_app/ui/features/workout/view_models/workout_view_model.dart';

void main() {
  const day = TrainingDay(
    id: 'pull-day',
    name: 'Спина + бицепс',
    weekday: TrainingWeekday.thursday,
    estimatedDurationMinutes: 60,
    exercises: [
      Exercise(
        id: 'lat-pulldown',
        name: 'Тяга верхнего блока',
        muscleGroup: MuscleGroup.back,
      ),
    ],
  );

  test('starts one workout and snapshots the selected training day', () {
    final viewModel = WorkoutViewModel(repository: InMemoryWorkoutRepository());
    final startedAt = DateTime(2026, 9, 3, 18);

    viewModel.startWorkout(day, startedAt: startedAt);
    viewModel.startWorkout(
      day.copyWith(name: 'Другая тренировка'),
      startedAt: startedAt.add(const Duration(hours: 1)),
    );

    expect(viewModel.activeWorkout?.trainingDayId, day.id);
    expect(viewModel.activeWorkout?.title, day.name);
    expect(viewModel.activeWorkout?.startedAt, startedAt);
    expect(
      viewModel.activeWorkout?.exercises.single.name,
      'Тяга верхнего блока',
    );
  });

  test('adds only valid sets and deletes an existing set', () {
    final viewModel = WorkoutViewModel(repository: InMemoryWorkoutRepository())
      ..startWorkout(day);

    viewModel.addSet(exerciseId: 'missing', repetitions: 10, weightKg: 40);
    viewModel.addSet(exerciseId: 'lat-pulldown', repetitions: 0, weightKg: 40);
    viewModel.addSet(exerciseId: 'lat-pulldown', repetitions: 10, weightKg: 40);

    final set = viewModel.activeWorkout!.exercises.single.sets.single;
    expect(set.repetitions, 10);
    expect(set.weightKg, 40);

    viewModel.deleteSet(exerciseId: 'lat-pulldown', setId: set.id);

    expect(viewModel.activeWorkout?.totalSets, 0);
  });

  test('does not finish a workout without completed sets', () async {
    final viewModel = WorkoutViewModel(repository: InMemoryWorkoutRepository())
      ..startWorkout(day);

    final record = await viewModel.finishWorkout();

    expect(record, isNull);
    expect(viewModel.activeWorkout, isNotNull);
    expect(viewModel.history, isEmpty);
  });

  test('finishes a workout, saves it and clears the active session', () async {
    final repository = InMemoryWorkoutRepository();
    final viewModel = WorkoutViewModel(repository: repository);
    final startedAt = DateTime(2026, 9, 3, 18);
    final completedAt = startedAt.add(const Duration(minutes: 47));
    viewModel.startWorkout(day, startedAt: startedAt);
    viewModel.addSet(exerciseId: 'lat-pulldown', repetitions: 12, weightKg: 35);

    final record = await viewModel.finishWorkout(completedAt: completedAt);

    expect(record?.duration, const Duration(minutes: 47));
    expect(record?.totalSets, 1);
    expect(viewModel.activeWorkout, isNull);
    expect(viewModel.history, [record]);
    expect(await repository.loadHistory(), [record]);
  });

  test('keeps the active workout when saving fails', () async {
    final viewModel = WorkoutViewModel(repository: _FailingWorkoutRepository());
    viewModel.startWorkout(day);
    viewModel.addSet(exerciseId: 'lat-pulldown', repetitions: 8, weightKg: 45);

    final record = await viewModel.finishWorkout();

    expect(record, isNull);
    expect(viewModel.activeWorkout?.totalSets, 1);
    expect(viewModel.errorMessage, 'Не удалось сохранить тренировку');
  });

  test(
    'restores sets and start time after recreating the view model',
    () async {
      final repository = InMemoryWorkoutRepository();
      final startedAt = DateTime(2026, 10, 2, 18);
      final first = WorkoutViewModel(repository: repository);
      first.startWorkout(day, startedAt: startedAt);
      first.addSet(exerciseId: 'lat-pulldown', repetitions: 8, weightKg: 50);
      await first.touchActivity();

      final restored = WorkoutViewModel(repository: repository);
      await restored.initialize();

      expect(restored.activeWorkout?.startedAt, startedAt);
      expect(restored.activeWorkout?.exercises.single.sets.single.weightKg, 50);
    },
  );

  test('concurrent finish taps save only one workout', () async {
    final repository = _DelayedSaveWorkoutRepository();
    final viewModel = WorkoutViewModel(repository: repository);
    viewModel.startWorkout(day, startedAt: DateTime(2026, 10, 2, 18));
    viewModel.addSet(exerciseId: 'lat-pulldown', repetitions: 8, weightKg: 50);

    final first = viewModel.finishWorkout();
    final second = viewModel.finishWorkout();
    expect(await second, isNull);
    repository.release();
    expect(await first, isNotNull);
    expect(await repository.loadHistory(), hasLength(1));
    expect(await repository.loadDraft(), isNull);
  });
}

class _DelayedSaveWorkoutRepository extends InMemoryWorkoutRepository {
  final _saveGate = Completer<void>();

  @override
  Future<void> save(WorkoutRecord record) async {
    await _saveGate.future;
    await super.save(record);
  }

  void release() => _saveGate.complete();
}

class _FailingWorkoutRepository implements WorkoutRepository {
  @override
  Future<List<WorkoutRecord>> loadHistory() async => const [];

  @override
  Future<ActiveWorkout?> loadDraft() async => null;

  @override
  Future<void> saveDraft(ActiveWorkout workout) async {}

  @override
  Future<void> touchDraft() async {}

  @override
  Future<void> save(WorkoutRecord record) =>
      Future.error(StateError('save failed'));
}
