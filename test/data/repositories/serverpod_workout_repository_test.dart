import 'package:flutter_test/flutter_test.dart';
import 'package:gym_training_app/data/repositories/serverpod_workout_repository.dart';
import 'package:gym_training_app/domain/models/exercise_record.dart';
import 'package:gym_training_app/domain/models/muscle_group.dart';
import 'package:gym_training_app/domain/models/set_record.dart';
import 'package:gym_training_app/domain/models/workout_record.dart';

void main() {
  test('maps a completed workout to the API contract and back', () {
    final record = WorkoutRecord(
      id: 'workout-1',
      trainingDayId: 'day-1',
      title: 'Спина',
      startedAt: DateTime(2026, 9, 10, 18),
      completedAt: DateTime(2026, 9, 10, 19, 5),
      exercises: const [
        ExerciseRecord(
          exerciseId: 'lat-pulldown',
          name: 'Тяга верхнего блока',
          muscleGroup: MuscleGroup.back,
          sets: [SetRecord(id: 'set-1', repetitions: 10, weightKg: 42.5)],
        ),
      ],
    );

    final restored = workoutRecordFromDto(workoutRecordToDto(record));

    expect(restored.id, record.id);
    expect(restored.trainingDayId, record.trainingDayId);
    expect(restored.duration, const Duration(hours: 1, minutes: 5));
    expect(restored.exercises.single.muscleGroup, MuscleGroup.back);
    expect(restored.exercises.single.sets.single.repetitions, 10);
    expect(restored.exercises.single.sets.single.weightKg, 42.5);
  });
}
