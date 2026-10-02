import 'package:backend_client/backend_client.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_training_app/data/repositories/in_memory_progress_repository.dart';
import 'package:gym_training_app/data/repositories/progress_calculator.dart';
import 'package:gym_training_app/data/repositories/serverpod_progress_repository.dart';
import 'package:gym_training_app/data/repositories/training_schedule_repository.dart';
import 'package:gym_training_app/data/repositories/workout_repository.dart';
import 'package:gym_training_app/domain/models/active_workout.dart';
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

  test('counts only completed scheduled training days in a streak', () {
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

    expect(overview.currentStreakDays, 4);
    expect(overview.bestStreakDays, 4);
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

    expect(overview.currentStreakDays, 2);
    expect(overview.bestStreakDays, 2);
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

  test('renamed exercise keeps one series and shows its current name', () {
    final renamedSchedule = schedule.copyWith(
      days: [
        schedule.days.first.copyWith(
          exercises: [
            schedule.days.first.exercises.single.copyWith(name: 'Жим штанги'),
          ],
        ),
        schedule.days.last,
      ],
    );
    final overview = calculateProgressOverview(
      schedule: renamedSchedule,
      history: [
        _workout(DateTime(2026, 9, 28), exerciseName: 'Жим лёжа'),
        _workout(DateTime(2026, 10, 5), exerciseName: 'Жим штанги'),
      ],
      period: ProgressPeriod.allTime,
      now: DateTime(2026, 10, 9),
    );

    expect(overview.exercises, hasLength(1));
    expect(overview.exercises.single.exerciseId, 'bench');
    expect(overview.exercises.single.name, 'Жим штанги');
    expect(overview.exercises.single.points, hasLength(2));
    expect(overview.personalRecords.single.exerciseName, 'Жим штанги');
  });

  test('same name with a new ID starts a separate series', () {
    final replacementSchedule = schedule.copyWith(
      days: [
        schedule.days.first.copyWith(
          exercises: const [
            Exercise(
              id: 'new-bench',
              name: 'Жим лёжа',
              muscleGroup: MuscleGroup.chest,
            ),
          ],
        ),
        schedule.days.last,
      ],
    );
    final overview = calculateProgressOverview(
      schedule: replacementSchedule,
      history: [
        _workout(DateTime(2026, 9, 28)),
        _workout(DateTime(2026, 10, 5), exerciseId: 'new-bench'),
      ],
      period: ProgressPeriod.allTime,
      now: DateTime(2026, 10, 9),
    );

    expect(overview.exercises, hasLength(2));
    expect(overview.exercises.map((exercise) => exercise.exerciseId), {
      'bench',
      'new-bench',
    });
    expect(
      overview.exercises.every((exercise) => exercise.points.length == 1),
      isTrue,
    );
  });

  test('in-memory repository calculates demo data locally', () async {
    final scheduleRepository = _ScheduleRepository(schedule);
    final workoutRepository = _WorkoutRepository([
      _workout(DateTime(2026, 10, 5)),
    ]);
    final inMemory = InMemoryProgressRepository(
      scheduleRepository: scheduleRepository,
      workoutRepository: workoutRepository,
      now: () => DateTime(2026, 10, 9),
    );
    final localResult = await inMemory.load(ProgressPeriod.allTime);
    expect(localResult.workoutCount, 1);
    expect(localResult.exercises.single.exerciseId, 'bench');
  });

  test('maps server aggregate without requesting raw history', () {
    final mapped = progressOverviewFromDto(
      api.ProgressOverviewDto(
        currentStreakDays: 3,
        bestStreakDays: 5,
        workoutCount: 1,
        totalMinutes: 60,
        totalSets: 2,
        exercises: [
          api.ExerciseProgressDto(
            exerciseId: 'bench',
            name: 'Жим штанги',
            points: [
              api.ExerciseProgressPointDto(
                date: DateTime.utc(2026, 10, 5),
                estimatedMaxKg: 80,
                maxWeightKg: 60,
                volumeKg: 1200,
              ),
            ],
          ),
        ],
        muscleGroups: [api.MuscleGroupProgressDto(group: 'chest', setCount: 2)],
        personalRecords: [
          api.PersonalRecordDto(
            exerciseId: 'bench',
            exerciseName: 'Жим штанги',
            weightKg: 60,
            repetitions: 10,
            estimatedMaxKg: 80,
            achievedAt: DateTime.utc(2026, 10, 5),
          ),
        ],
      ),
    );
    expect(mapped.currentStreakDays, 3);
    expect(mapped.exercises.single.name, 'Жим штанги');
    expect(mapped.muscleGroups.single.group, MuscleGroup.chest);
  });
}

WorkoutRecord _workout(
  DateTime date, {
  double weight = 50,
  int repetitions = 10,
  String exerciseId = 'bench',
  String exerciseName = 'Жим лёжа',
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
        exerciseId: exerciseId,
        name: exerciseName,
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
  Future<ActiveWorkout?> loadDraft() async => null;

  @override
  Future<void> saveDraft(ActiveWorkout workout) async {}

  @override
  Future<void> touchDraft() async {}

  @override
  Future<void> save(WorkoutRecord record) async {}
}
