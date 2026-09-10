import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

class WorkoutHistoryEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<WorkoutRecordDto>> list(Session session) async {
    final authUserId = session.authenticated!.authUserId;
    final records = await WorkoutRecordEntity.db.find(
      session,
      where: (table) => table.authUserId.equals(authUserId),
      orderBy: (table) => table.completedAt,
      orderDescending: true,
    );
    final result = <WorkoutRecordDto>[];
    for (final record in records) {
      result.add(await _loadRecord(session, record));
    }
    return result;
  }

  Future<WorkoutRecordDto> save(
    Session session,
    WorkoutRecordDto record,
  ) async {
    _validate(record);
    final authUserId = session.authenticated!.authUserId;
    return DatabaseUtil.runInTransactionOrSavepoint(
      session.db,
      null,
      (transaction) async {
        var entity = await WorkoutRecordEntity.db.findFirstRow(
          session,
          where: (table) =>
              table.authUserId.equals(authUserId) &
              table.publicId.equals(record.id),
          transaction: transaction,
        );
        if (entity == null) {
          entity = await WorkoutRecordEntity.db.insertRow(
            session,
            WorkoutRecordEntity(
              publicId: record.id,
              trainingDayPublicId: record.trainingDayId,
              title: record.title.trim(),
              startedAt: record.startedAt.toUtc(),
              completedAt: record.completedAt.toUtc(),
              authUserId: authUserId,
            ),
            transaction: transaction,
          );
        } else {
          await ExerciseRecordEntity.db.deleteWhere(
            session,
            where: (table) => table.workoutId.equals(entity!.id!),
            transaction: transaction,
          );
          entity = await WorkoutRecordEntity.db.updateRow(
            session,
            entity.copyWith(
              trainingDayPublicId: record.trainingDayId,
              title: record.title.trim(),
              startedAt: record.startedAt.toUtc(),
              completedAt: record.completedAt.toUtc(),
            ),
            transaction: transaction,
          );
        }

        for (final (exercisePosition, exercise) in record.exercises.indexed) {
          final exerciseEntity = await ExerciseRecordEntity.db.insertRow(
            session,
            ExerciseRecordEntity(
              exercisePublicId: exercise.exerciseId,
              name: exercise.name.trim(),
              muscleGroup: exercise.muscleGroup,
              position: exercisePosition,
              workoutId: entity.id!,
            ),
            transaction: transaction,
          );
          for (final (setPosition, set) in exercise.sets.indexed) {
            await SetRecordEntity.db.insertRow(
              session,
              SetRecordEntity(
                publicId: set.id,
                repetitions: set.repetitions,
                weightKg: set.weightKg,
                position: setPosition,
                exerciseRecordId: exerciseEntity.id!,
              ),
              transaction: transaction,
            );
          }
        }
        return _loadRecord(session, entity, transaction: transaction);
      },
    );
  }

  Future<WorkoutRecordDto> _loadRecord(
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

  void _validate(WorkoutRecordDto record) {
    if (record.id.trim().isEmpty ||
        record.trainingDayId.trim().isEmpty ||
        record.title.trim().isEmpty ||
        record.completedAt.isBefore(record.startedAt)) {
      throw WorkoutHistoryValidationException(reason: 'invalidWorkout');
    }
    final exerciseIds = <String>{};
    final setIds = <String>{};
    for (final exercise in record.exercises) {
      if (exercise.exerciseId.trim().isEmpty ||
          exercise.name.trim().isEmpty ||
          exercise.muscleGroup.trim().isEmpty ||
          !exerciseIds.add(exercise.exerciseId)) {
        throw WorkoutHistoryValidationException(reason: 'invalidExercise');
      }
      for (final set in exercise.sets) {
        if (set.id.trim().isEmpty ||
            set.repetitions <= 0 ||
            set.weightKg < 0 ||
            !setIds.add(set.id)) {
          throw WorkoutHistoryValidationException(reason: 'invalidSet');
        }
      }
    }
  }
}
