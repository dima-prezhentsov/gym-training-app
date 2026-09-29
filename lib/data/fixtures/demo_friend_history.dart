import '../../domain/models/workout_record.dart';
import 'demo_workout_history.dart';

/// Separate sample history so friend screens remain useful offline.
List<WorkoutRecord> buildDemoFriendHistory({DateTime? now}) {
  final records = buildDemoWorkoutHistory(now: now);
  return records
      .where(
        (record) => record.completedAt.isAfter(
          (now ?? DateTime.now()).subtract(const Duration(days: 42)),
        ),
      )
      .map(
        (record) => WorkoutRecord(
          id: 'friend-${record.id}',
          trainingDayId: record.trainingDayId,
          title: record.title,
          startedAt: record.startedAt,
          completedAt: record.completedAt,
          exercises: record.exercises,
        ),
      )
      .toList(growable: false);
}
