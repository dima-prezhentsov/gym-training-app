import 'package:flutter_test/flutter_test.dart';
import 'package:gym_training_app/data/repositories/in_memory_progress_repository.dart';
import 'package:gym_training_app/data/repositories/progress_calculator.dart';
import 'package:gym_training_app/data/repositories/serverpod_progress_repository.dart';
import 'package:gym_training_app/data/repositories/training_schedule_repository.dart';
import 'package:gym_training_app/data/repositories/workout_repository.dart';
import 'package:gym_training_app/domain/models/exercise.dart';
import 'package:gym_training_app/domain/models/exercise_record.dart';
import 'package:gym_training_app/domain/models/muscle_group.dart';
import 'package:gym_training_app/domain/models/progress_overview.dart';
import 'package:gym_training_app/domain/models/set_record.dart';
import 'package:gym_training_app/domain/models/training_day.dart';
import 'package:gym_training_app/domain/models/training_schedule.dart';
import 'package:gym_training_app/domain/models/training_weekday.dart';
import 'package:gym_training_app/domain/models/workout_record.dart';

void main() {
  const schedule = TrainingSchedule(
    id: 'schedule',
    name: 'Программа',
    days: [
      TrainingDay(
        id: 'push',
        name: 'Грудь',
        weekday: TrainingWeekday.monday,
        estimatedDurationMinutes: 60,
        exercises: [
          Exercise(
            id: 'bench',
            name: 'Жим лёжа',
            muscleGroup: MuscleGroup.chest,
          ),
        ],
      ),
      TrainingDay(
        id: 'pull',
        name: 'Спина',
        weekday: TrainingWeekday.thursday,
        estimatedDurationMinutes: 60,
      ),
    ],
  );

  test('calculates exercise progress, totals and muscle group sets', () {
    final overview = calculateProgressOverview(
      schedule: schedule,
      history: [
        _workout(DateTime(2026, 9, 28), weight: 60, repetitions: 10),
        _workout(DateTime(2026, 10, 5), weight: 70, repetitions: 8),
      ],
      period: ProgressPeriod.threeMonths,
      now: DateTime(2026, 10, 9),
    );

    expect(overview.workoutCount, 2);
    expect(overview.totalMinutes, 120);
    expect(overview.totalSets, 4);
    expect(overview.exercises, hasLength(1));
    expect(overview.exercises.single.points, hasLength(2));
    expect(overview.exercises.single.points.last.maxWeightKg, 70);
    expect(overview.exercises.single.points.last.volumeKg, 1120);
    expect(
      overview.exercises.single.points.last.estimatedMaxKg,
      closeTo(88.67, 0.01),
    );
    expect(overview.muscleGroups.single.group, MuscleGroup.chest);
    expect(overview.muscleGroups.single.setCount, 4);
    expect(overview.personalRecords.single.weightKg, 70);
  });

  test('counts an ongoing schedule streak in calendar days', () {
    final overview = calculateProgressOverview(
      schedule: schedule,
      history: [
        _workout(DateTime(2026, 9, 28)),
        _workout(DateTime(2026, 10, 1)),
        _workout(DateTime(2026, 10, 5)),
        _workout(DateTime(2026, 10, 8)),
      ],
      period: ProgressPeriod.allTime,
      now: DateTime(2026, 10, 9),
    );

    expect(overview.currentStreakDays, 12);
    expect(overview.bestStreakDays, 12);
  });

  test('resets the schedule streak after a missed training day', () {
    final overview = calculateProgressOverview(
      schedule: schedule,
      history: [
        _workout(DateTime(2026, 9, 28)),
        _workout(DateTime(2026, 10, 5)),
        _workout(DateTime(2026, 10, 8)),
      ],
      period: ProgressPeriod.allTime,
      now: DateTime(2026, 10, 9),
    );

    expect(overview.currentStreakDays, 5);
    expect(overview.bestStreakDays, 5);
  });

  test('filters period statistics without changing the all-time streak', () {
    final overview = calculateProgressOverview(
      schedule: schedule,
      history: [
        _workout(DateTime(2026, 6, 1)),
        _workout(DateTime(2026, 10, 5)),
      ],
      period: ProgressPeriod.fourWeeks,
      now: DateTime(2026, 10, 9),
    );

    expect(overview.workoutCount, 1);
    expect(overview.exercises.single.points, hasLength(1));
  });

  test('server and in-memory repositories use the same calculation', () async {
    final scheduleRepository = _ScheduleRepository(schedule);
    final workoutRepository = _WorkoutRepository([
      _workout(DateTime(2026, 10, 5)),
    ]);
    final inMemory = InMemoryProgressRepository(
      scheduleRepository: scheduleRepository,
      workoutRepository: workoutRepository,
      now: () => DateTime(2026, 10, 9),
    );
    final server = ServerpodProgressRepository(
      scheduleRepository: scheduleRepository,
      workoutRepository: workoutRepository,
      now: () => DateTime(2026, 10, 9),
    );

    final localResult = await inMemory.load(ProgressPeriod.allTime);
    final serverResult = await server.load(ProgressPeriod.allTime);

    expect(serverResult.workoutCount, localResult.workoutCount);
    expect(serverResult.currentStreakDays, localResult.currentStreakDays);
    expect(
      serverResult.exercises.single.points.single.estimatedMaxKg,
      localResult.exercises.single.points.single.estimatedMaxKg,
    );
  });
}

WorkoutRecord _workout(
  DateTime date, {
  double weight = 50,
  int repetitions = 10,
}) {
  final startedAt = DateTime(date.year, date.month, date.day, 18);
  return WorkoutRecord(
    id: 'workout-${date.toIso8601String()}',
    trainingDayId: 'push',
    title: 'Грудь',
    startedAt: startedAt,
    completedAt: startedAt.add(const Duration(hours: 1)),
    exercises: [
      ExerciseRecord(
        exerciseId: 'bench',
        name: 'Жим лёжа',
        muscleGroup: MuscleGroup.chest,
        sets: [
          SetRecord(
            id: 'set-1-${date.toIso8601String()}',
            repetitions: repetitions,
            weightKg: weight,
          ),
          SetRecord(
            id: 'set-2-${date.toIso8601String()}',
            repetitions: repetitions,
            weightKg: weight,
          ),
        ],
      ),
    ],
  );
}

class _ScheduleRepository implements TrainingScheduleRepository {
  _ScheduleRepository(this.schedule);

  final TrainingSchedule schedule;

  @override
  Future<TrainingSchedule> load() async => schedule;

  @override
  Future<void> save(TrainingSchedule schedule) async {}
}

class _WorkoutRepository implements WorkoutRepository {
  _WorkoutRepository(this.history);

  final List<WorkoutRecord> history;

  @override
  Future<List<WorkoutRecord>> loadHistory() async => history;

  @override
  Future<void> save(WorkoutRecord record) async {}
}
