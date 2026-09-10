import 'package:backend_server/src/generated/protocol.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given workout history endpoint', (sessionBuilder, endpoints) {
    late TestSessionBuilder firstUser;
    late TestSessionBuilder secondUser;

    setUp(() async {
      final session = sessionBuilder.build();
      final first = await const AuthUsers().create(session);
      final second = await const AuthUsers().create(session);
      await session.close();
      firstUser = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          first.id.uuid,
          {},
        ),
      );
      secondUser = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          second.id.uuid,
          {},
        ),
      );
    });

    test('persists a full workout and keeps users isolated', () async {
      final record = _record('workout-1');
      await endpoints.workoutHistory.save(firstUser, record);

      final firstHistory = await endpoints.workoutHistory.list(firstUser);
      final secondHistory = await endpoints.workoutHistory.list(secondUser);

      expect(firstHistory, hasLength(1));
      expect(firstHistory.single.exercises.single.sets.single.weightKg, 42.5);
      expect(secondHistory, isEmpty);
    });

    test('saving the same public id is idempotent', () async {
      final record = _record('same-id');
      await endpoints.workoutHistory.save(firstUser, record);
      await endpoints.workoutHistory.save(firstUser, record);

      expect(await endpoints.workoutHistory.list(firstUser), hasLength(1));
    });

    test('rejects a workout completed before it started', () async {
      final invalid = _record('invalid').copyWith(
        completedAt: DateTime.utc(2026, 9, 10, 17),
      );

      expect(
        () => endpoints.workoutHistory.save(firstUser, invalid),
        throwsA(isA<WorkoutHistoryValidationException>()),
      );
    });
  });
}

WorkoutRecordDto _record(String id) {
  return WorkoutRecordDto(
    id: id,
    trainingDayId: 'thursday-pull',
    title: 'Спина + бицепс',
    startedAt: DateTime.utc(2026, 9, 10, 18),
    completedAt: DateTime.utc(2026, 9, 10, 19),
    exercises: [
      ExerciseRecordDto(
        exerciseId: 'lat-pulldown',
        name: 'Тяга верхнего блока',
        muscleGroup: 'back',
        sets: [SetRecordDto(id: 'set-1', repetitions: 10, weightKg: 42.5)],
      ),
    ],
  );
}
