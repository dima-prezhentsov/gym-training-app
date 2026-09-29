import '../../domain/models/training_overview.dart';
import '../../domain/models/training_schedule.dart';
import '../../domain/models/workout_record.dart';

TrainingOverview buildTrainingOverview({
  required TrainingSchedule schedule,
  required List<WorkoutRecord> history,
  required DateTime now,
}) {
  final today = _dateOnly(now.toLocal());
  final weekStart = today.subtract(Duration(days: today.weekday - 1));
  final weekEnd = weekStart.add(const Duration(days: 7));
  final workoutsThisWeek = history
      .where((record) {
        final completedAt = record.completedAt.toLocal();
        return !completedAt.isBefore(weekStart) &&
            completedAt.isBefore(weekEnd);
      })
      .toList(growable: false);
  final scheduledWeekdays = schedule.days
      .map((day) => day.weekday.index + 1)
      .toSet();

  final days = List.generate(7, (index) {
    final date = weekStart.add(Duration(days: index));
    final completed = workoutsThisWeek.any(
      (record) => _isSameDate(record.completedAt.toLocal(), date),
    );
    final scheduled = scheduledWeekdays.contains(date.weekday);
    return WeekDaySummary(
      label: _weekdayLabels[index],
      dayNumber: date.day,
      date: date,
      isToday: _isSameDate(date, today),
      state: completed
          ? TrainingDayState.completed
          : scheduled
          ? TrainingDayState.upcoming
          : TrainingDayState.rest,
    );
  }, growable: false);

  final next = _findNextTraining(schedule, today);
  return TrainingOverview(
    scheduleName: schedule.name,
    days: days,
    nextTraining: next?.summary,
    daysUntilNextTraining: next?.daysUntil,
    completedThisWeek: workoutsThisWeek.length,
    totalMinutesThisWeek: workoutsThisWeek.fold(
      0,
      (total, record) => total + record.duration.inMinutes,
    ),
    totalSetsThisWeek: workoutsThisWeek.fold(
      0,
      (total, record) => total + record.totalSets,
    ),
  );
}

_NextTraining? _findNextTraining(TrainingSchedule schedule, DateTime today) {
  for (var daysUntil = 0; daysUntil < 7; daysUntil++) {
    final weekday = today.add(Duration(days: daysUntil)).weekday;
    final matchingDays = schedule.days.where(
      (day) => day.weekday.index + 1 == weekday,
    );
    if (matchingDays.isEmpty) continue;

    final day = matchingDays.first;
    return _NextTraining(
      daysUntil: daysUntil,
      summary: TrainingDaySummary(
        id: day.id,
        title: day.name,
        muscleGroups: day.exercises
            .map((exercise) => exercise.muscleGroup.label)
            .toSet()
            .toList(growable: false),
        exerciseCount: day.exercises.length,
        estimatedMinutes: day.estimatedDurationMinutes,
      ),
    );
  }
  return null;
}

DateTime _dateOnly(DateTime value) =>
    DateTime(value.year, value.month, value.day);

bool _isSameDate(DateTime first, DateTime second) =>
    first.year == second.year &&
    first.month == second.month &&
    first.day == second.day;

const _weekdayLabels = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];

class _NextTraining {
  const _NextTraining({required this.daysUntil, required this.summary});

  final int daysUntil;
  final TrainingDaySummary summary;
}
