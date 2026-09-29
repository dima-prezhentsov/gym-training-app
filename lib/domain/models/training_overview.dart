enum TrainingDayState { completed, upcoming, rest }

class WeekDaySummary {
  const WeekDaySummary({
    required this.label,
    required this.dayNumber,
    required this.date,
    required this.isToday,
    required this.state,
  });

  final String label;
  final int dayNumber;
  final DateTime date;
  final bool isToday;
  final TrainingDayState state;

  bool get hasTraining => state != TrainingDayState.rest;
}

class TrainingDaySummary {
  const TrainingDaySummary({
    required this.id,
    required this.title,
    required this.muscleGroups,
    required this.exerciseCount,
    required this.estimatedMinutes,
  });

  final String id;
  final String title;
  final List<String> muscleGroups;
  final int exerciseCount;
  final int estimatedMinutes;
}

class TrainingOverview {
  const TrainingOverview({
    required this.scheduleName,
    required this.days,
    required this.nextTraining,
    required this.daysUntilNextTraining,
    required this.completedThisWeek,
    required this.totalMinutesThisWeek,
    required this.totalSetsThisWeek,
  });

  final String scheduleName;
  final List<WeekDaySummary> days;
  final TrainingDaySummary? nextTraining;
  final int? daysUntilNextTraining;
  final int completedThisWeek;
  final int totalMinutesThisWeek;
  final int totalSetsThisWeek;
}
