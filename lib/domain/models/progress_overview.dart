import 'muscle_group.dart';

enum ProgressPeriod { fourWeeks, threeMonths, allTime }

extension ProgressPeriodLabel on ProgressPeriod {
  String get label => switch (this) {
    ProgressPeriod.fourWeeks => '4 недели',
    ProgressPeriod.threeMonths => '3 месяца',
    ProgressPeriod.allTime => 'Всё время',
  };
}

enum ExerciseProgressMetric { estimatedMax, maxWeight, volume }

extension ExerciseProgressMetricLabel on ExerciseProgressMetric {
  String get label => switch (this) {
    ExerciseProgressMetric.estimatedMax => 'Расчётный 1ПМ',
    ExerciseProgressMetric.maxWeight => 'Макс. вес',
    ExerciseProgressMetric.volume => 'Объём',
  };
}

class ProgressOverview {
  const ProgressOverview({
    required this.currentStreakDays,
    required this.bestStreakDays,
    required this.workoutCount,
    required this.totalMinutes,
    required this.totalSets,
    required this.exercises,
    required this.muscleGroups,
    required this.personalRecords,
  });

  final int currentStreakDays;
  final int bestStreakDays;
  final int workoutCount;
  final int totalMinutes;
  final int totalSets;
  final List<ExerciseProgress> exercises;
  final List<MuscleGroupProgress> muscleGroups;
  final List<PersonalRecord> personalRecords;

  bool get isEmpty => workoutCount == 0;
}

class ExerciseProgress {
  const ExerciseProgress({
    required this.exerciseId,
    required this.name,
    required this.points,
  });

  final String exerciseId;
  final String name;
  final List<ExerciseProgressPoint> points;
}

class ExerciseProgressPoint {
  const ExerciseProgressPoint({
    required this.date,
    required this.estimatedMaxKg,
    required this.maxWeightKg,
    required this.volumeKg,
  });

  final DateTime date;
  final double estimatedMaxKg;
  final double maxWeightKg;
  final double volumeKg;

  double valueFor(ExerciseProgressMetric metric) => switch (metric) {
    ExerciseProgressMetric.estimatedMax => estimatedMaxKg,
    ExerciseProgressMetric.maxWeight => maxWeightKg,
    ExerciseProgressMetric.volume => volumeKg,
  };
}

class MuscleGroupProgress {
  const MuscleGroupProgress({required this.group, required this.setCount});

  final MuscleGroup group;
  final int setCount;
}

class PersonalRecord {
  const PersonalRecord({
    required this.exerciseId,
    required this.exerciseName,
    required this.weightKg,
    required this.repetitions,
    required this.estimatedMaxKg,
    required this.achievedAt,
  });

  final String exerciseId;
  final String exerciseName;
  final double weightKg;
  final int repetitions;
  final double estimatedMaxKg;
  final DateTime achievedAt;
}
