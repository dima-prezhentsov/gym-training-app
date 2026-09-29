import 'package:flutter_test/flutter_test.dart';
import 'package:gym_training_app/data/fixtures/demo_training_schedule.dart';
import 'package:gym_training_app/data/repositories/serverpod_training_overview_repository.dart';
import 'package:gym_training_app/data/repositories/training_schedule_repository.dart';
import 'package:gym_training_app/data/repositories/workout_repository.dart';
import 'package:gym_training_app/domain/models/exercise_record.dart';
import 'package:gym_training_app/domain/models/muscle_group.dart';
import 'package:gym_training_app/domain/models/set_record.dart';
import 'package:gym_training_app/domain/models/training_overview.dart';
import 'package:gym_training_app/domain/models/training_schedule.dart';
import 'package:gym_training_app/domain/models/workout_record.dart';

void main() {
  test(
    'builds the current week and statistics from server repositories',
    () async {
      final repository = ServerpodTrainingOverviewRepository(
        scheduleRepository: _ScheduleRepository(demoTrainingSchedule),
        workoutRepository: _WorkoutRepository([
          _workout(
            id: 'current-week',
            startedAt: DateTime(2026, 9, 28, 18),
            completedAt: DateTime(2026, 9, 28, 19),
            setCount: 2,
          ),
          _workout(
            id: 'previous-week',
            startedAt: DateTime(2026, 9, 20, 18),
            completedAt: DateTime(2026, 9, 20, 19),
            setCount: 3,
          ),
        ]),
        now: () => DateTime(2026, 9, 29, 12),
      );

      final overview = await repository.getOverview();

      expect(overview.days, hasLength(7));
      expect(overview.days.first.date, DateTime(2026, 9, 28));
      expect(overview.days.last.date, DateTime(2026, 10, 4));
      expect(overview.days[0].state, TrainingDayState.completed);
      expect(overview.days[1].isToday, isTrue);
      expect(overview.days[1].state, TrainingDayState.rest);
      expect(overview.nextTraining?.id, 'thursday-pull');
      expect(overview.daysUntilNextTraining, 2);
      expect(overview.completedThisWeek, 1);
      expect(overview.totalMinutesThisWeek, 60);
      expect(overview.totalSetsThisWeek, 2);
    },
  );

  test('marks today as a training day when weekdays match', () async {
    final currentDaySchedule = demoTrainingSchedule.copyWith(
      days: [
        demoTrainingSchedule.days.first.copyWith(
          weekday: demoTrainingSchedule.days[1].weekday,
        ),
      ],
    );
    final repository = ServerpodTrainingOverviewRepository(
      scheduleRepository: _ScheduleRepository(currentDaySchedule),
      workoutRepository: _WorkoutRepository(const []),
      now: () => DateTime(2026, 10, 1),
    );

    final overview = await repository.getOverview();
    final today = overview.days.singleWhere((day) => day.isToday);

    expect(today.hasTraining, isTrue);
    expect(today.state, TrainingDayState.upcoming);
    expect(overview.daysUntilNextTraining, 0);
  });

  test('returns an empty next training for an empty schedule', () async {
    final repository = ServerpodTrainingOverviewRepository(
      scheduleRepository: _ScheduleRepository(
        const TrainingSchedule(id: 'empty', name: 'Пустое расписание'),
      ),
      workoutRepository: _WorkoutRepository(const []),
      now: () => DateTime(2026, 9, 29),
    );

    final overview = await repository.getOverview();

    expect(overview.nextTraining, isNull);
    expect(overview.daysUntilNextTraining, isNull);
    expect(overview.days.every((day) => !day.hasTraining), isTrue);
  });
}

WorkoutRecord _workout({
  required String id,
  required DateTime startedAt,
  required DateTime completedAt,
  required int setCount,
}) {
  return WorkoutRecord(
    id: id,
    trainingDayId: 'monday-push',
    title: 'Грудь + трицепс',
    startedAt: startedAt,
    completedAt: completedAt,
    exercises: [
      ExerciseRecord(
        exerciseId: 'bench-press',
        name: 'Жим штанги лёжа',
        muscleGroup: MuscleGroup.chest,
        sets: List.generate(
          setCount,
          (index) =>
              SetRecord(id: '$id-set-$index', repetitions: 10, weightKg: 40),
        ),
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
