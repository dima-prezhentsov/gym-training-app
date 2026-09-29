import 'package:backend_server/src/generated/protocol.dart';
import 'package:backend_server/src/progress/progress_calculator.dart';
import 'package:test/test.dart';

void main() {
  WorkoutRecordDto workout(DateTime date, String exerciseId, String name) =>
      WorkoutRecordDto(
        id: '${date.toIso8601String()}-$exerciseId',
        trainingDayId: 'day',
        title: 'Тренировка',
        startedAt: date.subtract(const Duration(hours: 1)),
        completedAt: date,
        exercises: [
          ExerciseRecordDto(
            exerciseId: exerciseId,
            name: name,
            muscleGroup: 'chest',
            sets: [
              SetRecordDto(
                id: 'set-$exerciseId',
                repetitions: 10,
                weightKg: 60,
              ),
            ],
          ),
        ],
      );

  test('server returns aggregate keyed by exercise ID and current name', () {
    final overview = calculateProgress(
      history: [
        workout(DateTime.utc(2026, 9, 28, 18), 'bench', 'Жим лёжа'),
        workout(DateTime.utc(2026, 10, 5, 18), 'bench', 'Жим лёжа'),
        workout(DateTime.utc(2026, 10, 8, 18), 'new-bench', 'Жим лёжа'),
      ],
      currentExerciseNames: {'bench': 'Жим штанги'},
      scheduledWeekdays: {DateTime.monday, DateTime.thursday},
      period: 'allTime',
      now: DateTime.utc(2026, 10, 9),
      utcOffsetMinutes: 0,
    );
    expect(overview.workoutCount, 3);
    expect(overview.totalMinutes, 180);
    expect(overview.totalSets, 3);
    expect(overview.currentStreakDays, 5);
    expect(overview.exercises, hasLength(2));
    expect(
      overview.exercises.firstWhere((e) => e.exerciseId == 'bench').name,
      'Жим штанги',
    );
    expect(
      overview.exercises.firstWhere((e) => e.exerciseId == 'bench').points,
      hasLength(2),
    );
    expect(
      overview.exercises.firstWhere((e) => e.exerciseId == 'new-bench').points,
      hasLength(1),
    );
  });

  test('offset determines local training date', () {
    final record = workout(DateTime.utc(2026, 10, 1, 23, 30), 'bench', 'Жим');
    final overview = calculateProgress(
      history: [record],
      currentExerciseNames: const {},
      scheduledWeekdays: {DateTime.friday},
      period: 'fourWeeks',
      now: DateTime.utc(2026, 10, 2),
      utcOffsetMinutes: 180,
    );
    expect(overview.currentStreakDays, 1);
  });
}
