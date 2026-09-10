import 'package:backend_server/src/generated/protocol.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given training schedule endpoint', (
    sessionBuilder,
    endpoints,
  ) {
    late TestSessionBuilder firstUser;
    late TestSessionBuilder secondUser;

    setUp(() async {
      final session = sessionBuilder.build();
      final firstAuthUser = await const AuthUsers().create(session);
      final secondAuthUser = await const AuthUsers().create(session);
      await session.close();
      firstUser = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          firstAuthUser.id.uuid,
          {},
        ),
      );
      secondUser = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          secondAuthUser.id.uuid,
          {},
        ),
      );
    });

    test('round-trips days and exercises in their submitted order', () async {
      final saved = await endpoints.trainingSchedule.save(
        firstUser,
        _schedule(name: 'Силовая программа'),
      );
      final loaded = await endpoints.trainingSchedule.get(firstUser);

      expect(saved.name, 'Силовая программа');
      expect(loaded?.days.map((day) => day.id), ['monday', 'friday']);
      expect(loaded?.days.first.exercises.map((item) => item.id), [
        'bench',
        'fly',
      ]);
      expect(loaded?.days.first.exercises.last.muscleGroup, 'chest');
    });

    test('keeps schedules isolated even when public ids are equal', () async {
      await endpoints.trainingSchedule.save(
        firstUser,
        _schedule(name: 'Первого пользователя'),
      );
      await endpoints.trainingSchedule.save(
        secondUser,
        _schedule(name: 'Второго пользователя'),
      );

      expect(
        (await endpoints.trainingSchedule.get(firstUser))?.name,
        'Первого пользователя',
      );
      expect(
        (await endpoints.trainingSchedule.get(secondUser))?.name,
        'Второго пользователя',
      );
    });

    test(
      'deleting one schedule does not delete another user schedule',
      () async {
        await endpoints.trainingSchedule.save(firstUser, _schedule(name: 'A'));
        await endpoints.trainingSchedule.save(secondUser, _schedule(name: 'B'));

        await endpoints.trainingSchedule.delete(secondUser);

        expect(await endpoints.trainingSchedule.get(secondUser), isNull);
        expect((await endpoints.trainingSchedule.get(firstUser))?.name, 'A');
      },
    );

    test('rejects duplicate exercise ids', () async {
      final invalid = _schedule(name: 'Invalid');
      invalid.days.last.exercises.add(
        ExerciseDto(
          id: 'bench',
          name: 'Duplicate',
          description: '',
          muscleGroup: 'chest',
        ),
      );

      expect(
        () => endpoints.trainingSchedule.save(firstUser, invalid),
        throwsA(
          isA<ScheduleValidationException>().having(
            (error) => error.reason,
            'reason',
            'invalidExercise',
          ),
        ),
      );
    });
  });
}

TrainingScheduleDto _schedule({required String name}) {
  return TrainingScheduleDto(
    id: 'main-schedule',
    name: name,
    days: [
      TrainingDayDto(
        id: 'monday',
        name: 'Грудь',
        weekday: 0,
        estimatedDurationMinutes: 45,
        exercises: [
          ExerciseDto(
            id: 'bench',
            name: 'Жим лёжа',
            description: '',
            muscleGroup: 'chest',
          ),
          ExerciseDto(
            id: 'fly',
            name: 'Разводка',
            description: 'С гантелями',
            muscleGroup: 'chest',
          ),
        ],
      ),
      TrainingDayDto(
        id: 'friday',
        name: 'Ноги',
        weekday: 4,
        estimatedDurationMinutes: 60,
        exercises: [],
      ),
    ],
  );
}
