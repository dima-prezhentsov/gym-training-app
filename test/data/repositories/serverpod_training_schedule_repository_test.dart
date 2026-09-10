import 'package:flutter_test/flutter_test.dart';
import 'package:gym_training_app/data/repositories/serverpod_training_schedule_repository.dart';
import 'package:gym_training_app/domain/models/exercise.dart';
import 'package:gym_training_app/domain/models/muscle_group.dart';
import 'package:gym_training_app/domain/models/training_day.dart';
import 'package:gym_training_app/domain/models/training_schedule.dart';
import 'package:gym_training_app/domain/models/training_weekday.dart';

void main() {
  test('maps a training schedule to the API contract and back', () {
    const schedule = TrainingSchedule(
      id: 'schedule-1',
      name: 'Моя программа',
      days: [
        TrainingDay(
          id: 'day-1',
          name: 'Тяговая',
          weekday: TrainingWeekday.thursday,
          estimatedDurationMinutes: 55,
          exercises: [
            Exercise(
              id: 'exercise-1',
              name: 'Тяга верхнего блока',
              description: 'Средний хват',
              muscleGroup: MuscleGroup.back,
            ),
          ],
        ),
      ],
    );

    final restored = trainingScheduleFromDto(trainingScheduleToDto(schedule));

    expect(restored.id, schedule.id);
    expect(restored.name, schedule.name);
    expect(restored.days.single.id, 'day-1');
    expect(restored.days.single.weekday, TrainingWeekday.thursday);
    expect(restored.days.single.estimatedDurationMinutes, 55);
    expect(restored.days.single.exercises.single.muscleGroup, MuscleGroup.back);
    expect(restored.days.single.exercises.single.description, 'Средний хват');
  });
}
