import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

class TrainingScheduleEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<TrainingScheduleDto?> get(Session session) async {
    final authUserId = session.authenticated!.authUserId;
    final schedule = await TrainingScheduleEntity.db.findFirstRow(
      session,
      where: (table) => table.authUserId.equals(authUserId),
    );
    if (schedule == null) return null;
    return _loadAggregate(session, schedule);
  }

  Future<TrainingScheduleDto> save(
    Session session,
    TrainingScheduleDto schedule,
  ) async {
    _validate(schedule);
    final authUserId = session.authenticated!.authUserId;

    return DatabaseUtil.runInTransactionOrSavepoint(
      session.db,
      null,
      (transaction) async {
        var entity = await TrainingScheduleEntity.db.findFirstRow(
          session,
          where: (table) => table.authUserId.equals(authUserId),
          transaction: transaction,
        );
        if (entity == null) {
          entity = await TrainingScheduleEntity.db.insertRow(
            session,
            TrainingScheduleEntity(
              publicId: schedule.id,
              name: schedule.name.trim(),
              authUserId: authUserId,
            ),
            transaction: transaction,
          );
        } else {
          entity = await TrainingScheduleEntity.db.updateRow(
            session,
            entity.copyWith(
              publicId: schedule.id,
              name: schedule.name.trim(),
              updatedAt: DateTime.now().toUtc(),
            ),
            transaction: transaction,
          );
          await TrainingDayEntity.db.deleteWhere(
            session,
            where: (table) => table.scheduleId.equals(entity!.id!),
            transaction: transaction,
          );
        }

        for (final (dayPosition, day) in schedule.days.indexed) {
          final dayEntity = await TrainingDayEntity.db.insertRow(
            session,
            TrainingDayEntity(
              publicId: day.id,
              name: day.name.trim(),
              weekday: day.weekday,
              estimatedDurationMinutes: day.estimatedDurationMinutes,
              position: dayPosition,
              scheduleId: entity.id!,
            ),
            transaction: transaction,
          );
          for (final (exercisePosition, exercise) in day.exercises.indexed) {
            await ExerciseEntity.db.insertRow(
              session,
              ExerciseEntity(
                publicId: exercise.id,
                name: exercise.name.trim(),
                description: exercise.description.trim(),
                muscleGroup: exercise.muscleGroup,
                position: exercisePosition,
                trainingDayId: dayEntity.id!,
              ),
              transaction: transaction,
            );
          }
        }

        return _loadAggregate(session, entity, transaction: transaction);
      },
    );
  }

  Future<void> delete(Session session) async {
    final authUserId = session.authenticated!.authUserId;
    await TrainingScheduleEntity.db.deleteWhere(
      session,
      where: (table) => table.authUserId.equals(authUserId),
    );
  }

  Future<TrainingScheduleDto> _loadAggregate(
    Session session,
    TrainingScheduleEntity schedule, {
    Transaction? transaction,
  }) async {
    final days = await TrainingDayEntity.db.find(
      session,
      where: (table) => table.scheduleId.equals(schedule.id!),
      orderBy: (table) => table.position,
      transaction: transaction,
    );
    final dayDtos = <TrainingDayDto>[];
    for (final day in days) {
      final exercises = await ExerciseEntity.db.find(
        session,
        where: (table) => table.trainingDayId.equals(day.id!),
        orderBy: (table) => table.position,
        transaction: transaction,
      );
      dayDtos.add(
        TrainingDayDto(
          id: day.publicId,
          name: day.name,
          weekday: day.weekday,
          estimatedDurationMinutes: day.estimatedDurationMinutes,
          exercises: exercises
              .map(
                (exercise) => ExerciseDto(
                  id: exercise.publicId,
                  name: exercise.name,
                  description: exercise.description,
                  muscleGroup: exercise.muscleGroup,
                ),
              )
              .toList(),
        ),
      );
    }
    return TrainingScheduleDto(
      id: schedule.publicId,
      name: schedule.name,
      days: dayDtos,
    );
  }

  void _validate(TrainingScheduleDto schedule) {
    if (schedule.id.trim().isEmpty || schedule.name.trim().isEmpty) {
      throw ScheduleValidationException(reason: 'invalidSchedule');
    }
    final dayIds = <String>{};
    final exerciseIds = <String>{};
    for (final day in schedule.days) {
      if (day.id.trim().isEmpty ||
          day.name.trim().isEmpty ||
          day.weekday < 0 ||
          day.weekday > 6 ||
          day.estimatedDurationMinutes <= 0 ||
          !dayIds.add(day.id)) {
        throw ScheduleValidationException(reason: 'invalidDay');
      }
      for (final exercise in day.exercises) {
        if (exercise.id.trim().isEmpty ||
            exercise.name.trim().isEmpty ||
            exercise.muscleGroup.trim().isEmpty ||
            !exerciseIds.add(exercise.id)) {
          throw ScheduleValidationException(reason: 'invalidExercise');
        }
      }
    }
  }
}
