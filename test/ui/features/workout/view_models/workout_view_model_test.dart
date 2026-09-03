import 'package:flutter_test/flutter_test.dart';
import 'package:gym_training_app/data/repositories/in_memory_workout_repository.dart';
import 'package:gym_training_app/domain/models/exercise.dart';
import 'package:gym_training_app/domain/models/muscle_group.dart';
import 'package:gym_training_app/domain/models/training_day.dart';
import 'package:gym_training_app/domain/models/training_weekday.dart';
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
}
