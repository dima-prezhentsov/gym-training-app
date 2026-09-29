import 'dart:math' as math;

import '../generated/protocol.dart';

/// Calculates a presentation-ready aggregate without returning raw workouts.
ProgressOverviewDto calculateProgress({
  required List<WorkoutRecordDto> history,
  required Map<String, String> currentExerciseNames,
  required Set<int> scheduledWeekdays,
  required String period,
  required DateTime now,
  required int utcOffsetMinutes,
}) {
  if (!{'fourWeeks', 'threeMonths', 'allTime'}.contains(period)) {
    throw ArgumentError.value(period, 'period');
  }
  if (utcOffsetMinutes < -720 || utcOffsetMinutes > 840) {
    throw ArgumentError.value(utcOffsetMinutes, 'utcOffsetMinutes');
  }
  DateTime localDate(DateTime instant) =>
      instant.toUtc().add(Duration(minutes: utcOffsetMinutes));
  DateTime dateOnly(DateTime instant) {
    final local = localDate(instant);
    return DateTime.utc(local.year, local.month, local.day);
  }

  final today = dateOnly(now);
  final periodStart = switch (period) {
    'fourWeeks' => today.subtract(const Duration(days: 27)),
    'threeMonths' => today.subtract(const Duration(days: 89)),
    _ => null,
  };
  final records = history.where((record) {
    final date = dateOnly(record.completedAt);
    return !date.isAfter(today) &&
        (periodStart == null || !date.isBefore(periodStart));
  }).toList()..sort((a, b) => a.completedAt.compareTo(b.completedAt));

  final completedDates = history
      .map((record) => dateOnly(record.completedAt))
      .where((date) => !date.isAfter(today))
      .toSet();
  var currentStreak = 0;
  var bestStreak = 0;
  if (scheduledWeekdays.isNotEmpty && completedDates.isNotEmpty) {
    var cursor = completedDates.reduce((a, b) => a.isBefore(b) ? a : b);
    DateTime? runStart;
    while (!cursor.isAfter(today)) {
      if (scheduledWeekdays.contains(cursor.weekday)) {
        final completed = completedDates.contains(cursor);
        final pendingToday = cursor == today && !completed;
        if (!pendingToday) {
          if (completed) {
            runStart ??= cursor;
            bestStreak = math.max(
              bestStreak,
              cursor.difference(runStart).inDays + 1,
            );
          } else {
            runStart = null;
          }
        }
      }
      cursor = cursor.add(const Duration(days: 1));
    }
    if (runStart != null) {
      currentStreak = today.difference(runStart).inDays + 1;
      bestStreak = math.max(bestStreak, currentStreak);
    }
  }

  final points = <String, List<ExerciseProgressPointDto>>{};
  final names = <String, String>{};
  final muscleSets = <String, int>{};
  final prs = <String, PersonalRecordDto>{};
  var totalSets = 0;
  var totalMinutes = 0;
  for (final workout in records) {
    totalMinutes += workout.completedAt.difference(workout.startedAt).inMinutes;
    for (final exercise in workout.exercises) {
      final sets = exercise.sets;
      totalSets += sets.length;
      if (sets.isEmpty) continue;
      final id = exercise.exerciseId;
      names[id] = exercise.name;
      final maxWeight = sets.map((set) => set.weightKg).reduce(math.max);
      final volume = sets.fold<double>(
        0,
        (sum, set) => sum + set.weightKg * set.repetitions,
      );
      final maxEstimate = sets
          .map((set) => _estimatedMax(set.weightKg, set.repetitions))
          .reduce(math.max);
      points
          .putIfAbsent(id, () => [])
          .add(
            ExerciseProgressPointDto(
              date: workout.completedAt,
              estimatedMaxKg: maxEstimate,
              maxWeightKg: maxWeight,
              volumeKg: volume,
            ),
          );
      muscleSets.update(
        exercise.muscleGroup,
        (value) => value + sets.length,
        ifAbsent: () => sets.length,
      );
      final bestSet = sets.reduce(
        (a, b) =>
            _estimatedMax(b.weightKg, b.repetitions) >
                _estimatedMax(a.weightKg, a.repetitions)
            ? b
            : a,
      );
      final previous = prs[id];
      if (previous == null || maxEstimate > previous.estimatedMaxKg) {
        prs[id] = PersonalRecordDto(
          exerciseId: id,
          exerciseName: exercise.name,
          weightKg: bestSet.weightKg,
          repetitions: bestSet.repetitions,
          estimatedMaxKg: _estimatedMax(bestSet.weightKg, bestSet.repetitions),
          achievedAt: workout.completedAt,
        );
      }
    }
  }
  final exercises =
      points.entries
          .map(
            (entry) => ExerciseProgressDto(
              exerciseId: entry.key,
              name: currentExerciseNames[entry.key] ?? names[entry.key]!,
              points: entry.value,
            ),
          )
          .toList()
        ..sort((a, b) => a.name.compareTo(b.name));
  final groups =
      muscleSets.entries
          .map(
            (entry) => MuscleGroupProgressDto(
              group: entry.key,
              setCount: entry.value,
            ),
          )
          .toList()
        ..sort((a, b) => b.setCount.compareTo(a.setCount));
  final personalRecords =
      prs.values
          .map(
            (record) => PersonalRecordDto(
              exerciseId: record.exerciseId,
              exerciseName:
                  currentExerciseNames[record.exerciseId] ??
                  record.exerciseName,
              weightKg: record.weightKg,
              repetitions: record.repetitions,
              estimatedMaxKg: record.estimatedMaxKg,
              achievedAt: record.achievedAt,
            ),
          )
          .toList()
        ..sort((a, b) => b.achievedAt.compareTo(a.achievedAt));
  return ProgressOverviewDto(
    currentStreakDays: currentStreak,
    bestStreakDays: bestStreak,
    workoutCount: records.length,
    totalMinutes: totalMinutes,
    totalSets: totalSets,
    exercises: exercises,
    muscleGroups: groups,
    personalRecords: personalRecords,
  );
}

double _estimatedMax(double weightKg, int reps) =>
    weightKg <= 0 || reps <= 0 ? 0 : weightKg * (1 + reps / 30);
