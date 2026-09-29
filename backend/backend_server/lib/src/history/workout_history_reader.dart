import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Internal reader. Endpoints must authorize the owner before calling this.
class WorkoutHistoryReader {
  static Future<List<WorkoutRecordDto>> listForUser(
    Session session,
    UuidValue authUserId,
  ) async {
    final records = await WorkoutRecordEntity.db.find(
      session,
      where: (table) => table.authUserId.equals(authUserId),
      orderBy: (table) => table.completedAt,
      orderDescending: true,
    );
    final result = <WorkoutRecordDto>[];
    for (final record in records) {
      result.add(await loadRecord(session, record));
    }
    return result;
  }

  static Future<WorkoutRecordDto> loadRecord(
    Session session,
    WorkoutRecordEntity record, {
    Transaction? transaction,
  }) async {
    final exerciseEntities = await ExerciseRecordEntity.db.find(
      session,
      where: (table) => table.workoutId.equals(record.id!),
      orderBy: (table) => table.position,
      transaction: transaction,
    );
    final exercises = <ExerciseRecordDto>[];
    for (final exercise in exerciseEntities) {
      final setEntities = await SetRecordEntity.db.find(
        session,
        where: (table) => table.exerciseRecordId.equals(exercise.id!),
        orderBy: (table) => table.position,
        transaction: transaction,
      );
      exercises.add(
        ExerciseRecordDto(
          exerciseId: exercise.exercisePublicId,
          name: exercise.name,
          muscleGroup: exercise.muscleGroup,
          sets: setEntities
              .map(
                (set) => SetRecordDto(
                  id: set.publicId,
                  repetitions: set.repetitions,
                  weightKg: set.weightKg,
                ),
              )
              .toList(),
        ),
      );
    }
    return WorkoutRecordDto(
      id: record.publicId,
      trainingDayId: record.trainingDayPublicId,
      title: record.title,
      startedAt: record.startedAt,
      completedAt: record.completedAt,
      exercises: exercises,
    );
  }
}
