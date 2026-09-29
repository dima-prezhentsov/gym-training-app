import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../history/workout_history_reader.dart';
import 'progress_calculator.dart';

class ProgressService {
  static Future<ProgressOverviewDto> forUser(
    Session session,
    UuidValue userId, {
    required String period,
    required int utcOffsetMinutes,
  }) async {
    final history = await WorkoutHistoryReader.listForUser(session, userId);
    final schedule = await TrainingScheduleEntity.db.findFirstRow(
      session,
      where: (table) => table.authUserId.equals(userId),
    );
    final names = <String, String>{};
    final weekdays = <int>{};
    if (schedule != null) {
      final days = await TrainingDayEntity.db.find(
        session,
        where: (table) => table.scheduleId.equals(schedule.id!),
      );
      for (final day in days) {
        weekdays.add(day.weekday + 1);
        final exercises = await ExerciseEntity.db.find(
          session,
          where: (table) => table.trainingDayId.equals(day.id!),
        );
        for (final exercise in exercises) {
          names[exercise.publicId] = exercise.name;
        }
      }
    }
    return calculateProgress(
      history: history,
      currentExerciseNames: names,
      scheduledWeekdays: weekdays,
      period: period,
      now: DateTime.now().toUtc(),
      utcOffsetMinutes: utcOffsetMinutes,
    );
  }
}
