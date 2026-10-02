import 'dart:math' as math;

import '../../domain/models/muscle_group.dart';
import '../../domain/models/progress_overview.dart';
import '../../domain/models/training_schedule.dart';
import '../../domain/models/workout_record.dart';

ProgressOverview calculateProgressOverview({
  required TrainingSchedule schedule,
  required List<WorkoutRecord> history,
  required ProgressPeriod period,
  required DateTime now,
}) {
  final today = _dateOnly(now.toLocal());
  final periodStart = switch (period) {
    ProgressPeriod.fourWeeks => today.subtract(const Duration(days: 27)),
    ProgressPeriod.threeMonths => today.subtract(const Duration(days: 89)),
    ProgressPeriod.allTime => null,
  };
  final records =
      history
          .where((record) {
            final date = _dateOnly(record.completedAt.toLocal());
            return !date.isAfter(today) &&
                (periodStart == null || !date.isBefore(periodStart));
          })
          .toList(growable: false)
        ..sort((left, right) => left.completedAt.compareTo(right.completedAt));

  final streak = _calculateStreak(
    schedule: schedule,
    history: history,
    today: today,
  );
  final exercisePoints = <String, List<ExerciseProgressPoint>>{};
  final currentExerciseNames = {
    for (final day in schedule.days)
      for (final exercise in day.exercises) exercise.id: exercise.name,
  };
  final exerciseNames = <String, String>{};
  final muscleSets = <MuscleGroup, int>{};
  final personalRecords = <String, PersonalRecord>{};

  for (final record in records) {
    for (final exercise in record.exercises) {
      if (exercise.sets.isEmpty) continue;
      final id = exercise.exerciseId;
      exerciseNames[id] = exercise.name;
      final maxWeight = exercise.sets
          .map((set) => set.weightKg)
          .reduce(math.max);
      final volume = exercise.sets.fold<double>(
        0,
        (total, set) => total + set.weightKg * set.repetitions,
      );
      final estimatedMax = exercise.sets
          .map((set) => _estimatedMax(set.weightKg, set.repetitions))
          .reduce(math.max);
      exercisePoints
          .putIfAbsent(id, () => [])
          .add(
            ExerciseProgressPoint(
              date: record.completedAt.toLocal(),
              estimatedMaxKg: estimatedMax,
              maxWeightKg: maxWeight,
              volumeKg: volume,
            ),
          );
      muscleSets.update(
        exercise.muscleGroup,
        (value) => value + exercise.sets.length,
        ifAbsent: () => exercise.sets.length,
      );
      final bestSet = exercise.sets.reduce((left, right) {
        final leftMax = _estimatedMax(left.weightKg, left.repetitions);
        final rightMax = _estimatedMax(right.weightKg, right.repetitions);
        return rightMax > leftMax ? right : left;
      });
      final candidate = PersonalRecord(
        exerciseId: id,
        exerciseName: exercise.name,
        weightKg: bestSet.weightKg,
        repetitions: bestSet.repetitions,
        estimatedMaxKg: _estimatedMax(bestSet.weightKg, bestSet.repetitions),
        achievedAt: record.completedAt.toLocal(),
      );
      final current = personalRecords[id];
      if (current == null ||
          candidate.estimatedMaxKg > current.estimatedMaxKg) {
        personalRecords[id] = candidate;
      }
    }
  }

  final exercises =
      exercisePoints.entries
          .map(
            (entry) => ExerciseProgress(
              exerciseId: entry.key,
              name:
                  currentExerciseNames[entry.key] ?? exerciseNames[entry.key]!,
              points: List.unmodifiable(entry.value),
            ),
          )
          .toList()
        ..sort((left, right) => left.name.compareTo(right.name));
  final groups =
      muscleSets.entries
          .map(
            (entry) =>
                MuscleGroupProgress(group: entry.key, setCount: entry.value),
          )
          .toList()
        ..sort((left, right) => right.setCount.compareTo(left.setCount));
  final recordsList =
      personalRecords.values
          .map(
            (record) => PersonalRecord(
              exerciseId: record.exerciseId,
              exerciseName:
                  currentExerciseNames[record.exerciseId] ??
                  exerciseNames[record.exerciseId]!,
              weightKg: record.weightKg,
              repetitions: record.repetitions,
              estimatedMaxKg: record.estimatedMaxKg,
              achievedAt: record.achievedAt,
            ),
          )
          .toList()
        ..sort((left, right) => right.achievedAt.compareTo(left.achievedAt));

  return ProgressOverview(
    currentStreakDays: streak.current,
    bestStreakDays: streak.best,
    workoutCount: records.length,
    totalMinutes: records.fold(
      0,
      (total, record) => total + record.duration.inMinutes,
    ),
    totalSets: records.fold(0, (total, record) => total + record.totalSets),
    exercises: List.unmodifiable(exercises),
    muscleGroups: List.unmodifiable(groups),
    personalRecords: List.unmodifiable(recordsList),
  );
}

double _estimatedMax(double weightKg, int repetitions) {
  if (weightKg <= 0 || repetitions <= 0) return 0;
  return weightKg * (1 + repetitions / 30);
}

_Streak _calculateStreak({
  required TrainingSchedule schedule,
  required List<WorkoutRecord> history,
  required DateTime today,
}) {
  if (schedule.days.isEmpty || history.isEmpty) {
    return const _Streak(current: 0, best: 0);
  }
  final scheduledWeekdays = schedule.days
      .map((day) => day.weekday.index + 1)
      .toSet();
  final completedDates = history
      .map((record) => _dateOnly(record.completedAt.toLocal()))
      .where((date) => !date.isAfter(today))
      .toSet();
  if (completedDates.isEmpty) return const _Streak(current: 0, best: 0);

  var cursor = completedDates.reduce(
    (left, right) => left.isBefore(right) ? left : right,
  );
  var runLength = 0;
  var best = 0;

  while (!cursor.isAfter(today)) {
    if (scheduledWeekdays.contains(cursor.weekday)) {
      final completed = completedDates.contains(cursor);
      final pendingToday = _isSameDate(cursor, today) && !completed;
      if (!pendingToday) {
        if (completed) {
          runLength++;
          best = math.max(best, runLength);
        } else {
          runLength = 0;
        }
      }
    }
    cursor = cursor.add(const Duration(days: 1));
  }

  return _Streak(current: runLength, best: best);
}

DateTime _dateOnly(DateTime value) =>
    DateTime(value.year, value.month, value.day);

bool _isSameDate(DateTime first, DateTime second) =>
    first.year == second.year &&
    first.month == second.month &&
    first.day == second.day;

class _Streak {
  const _Streak({required this.current, required this.best});

  final int current;
  final int best;
}
