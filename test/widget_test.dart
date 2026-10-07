import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_training_app/app/app.dart';
import 'package:gym_training_app/data/fixtures/demo_training_schedule.dart';
import 'package:gym_training_app/data/repositories/in_memory_training_schedule_repository.dart';
import 'package:gym_training_app/data/repositories/in_memory_workout_repository.dart';
import 'package:gym_training_app/data/repositories/progress_repository.dart';
import 'package:gym_training_app/data/repositories/training_schedule_repository.dart';
import 'package:gym_training_app/data/repositories/training_overview_repository.dart';
import 'package:gym_training_app/domain/models/progress_overview.dart';
import 'package:gym_training_app/domain/models/training_overview.dart';
import 'package:gym_training_app/domain/models/training_schedule.dart';
import 'package:gym_training_app/domain/models/workout_record.dart';
import 'package:gym_training_app/telegram/telegram_web_app.dart';
import 'package:gym_training_app/ui/features/workout/view_models/workout_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('shows the training overview', (tester) async {
    await tester.pumpWidget(
      GymTrainingApp(telegram: const TelegramLaunchData.browser()),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('тренировк'), findsWidgets);
    expect(find.text('Следующая тренировка'), findsOneWidget);
    expect(
      find.text('Грудь + трицепс').evaluate().isNotEmpty ||
          find.text('Спина + бицепс').evaluate().isNotEmpty ||
          find.text('Ноги + плечи').evaluate().isNotEmpty,
      isTrue,
    );
    expect(find.text('Начать тренировку'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle_rounded), findsWidgets);
  });

  testWidgets('redirects the root URL to the home screen', (tester) async {
    final app = GymTrainingApp(telegram: const TelegramLaunchData.browser());
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();

    app.router.config.go('/');
    await tester.pumpAndSettle();

    expect(find.textContaining('тренировк'), findsWidgets);
    expect(find.text('Не удалось открыть экран'), findsNothing);
  });

  testWidgets('opens home when Telegram launch data occupies the hash', (
    tester,
  ) async {
    final app = GymTrainingApp(telegram: const TelegramLaunchData.browser());
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();

    app.router.config.go(
      '/tgWebAppData=user%3Dtest&tgWebAppVersion=10.1'
      '&tgWebAppPlatform=tdesktop&tgWebAppThemeParams=%7B%7D',
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('тренировк'), findsWidgets);
    expect(find.textContaining('Не удалось открыть экран'), findsNothing);
  });

  testWidgets('keeps shell navigation between main sections', (tester) async {
    await tester.pumpWidget(
      GymTrainingApp(telegram: const TelegramLaunchData.browser()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Расписание'));
    await tester.pumpAndSettle();
    expect(find.text('Расписание'), findsWidgets);
    expect(find.text('Грудь + трицепс'), findsOneWidget);

    await tester.tap(find.byTooltip('Прогресс'));
    await tester.pumpAndSettle();
    expect(find.text('Прогресс'), findsWidgets);
    expect(find.byKey(const ValueKey('progress-streak-card')), findsOneWidget);
    expect(find.text('Динамика упражнения'), findsOneWidget);
  });

  testWidgets('switches between progress overview and workout history', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      GymTrainingApp(telegram: const TelegramLaunchData.browser()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Прогресс'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Расчётный 1ПМ'), 250);
    expect(find.text('Расчётный 1ПМ'), findsOneWidget);
    expect(
      find.text(
        'Примерный максимальный вес на одно повторение, рассчитанный по лучшему подходу.',
      ),
      findsOneWidget,
    );
    expect(find.text('Расчётный 1ПМ по тренировкам'), findsOneWidget);
    expect(find.text('Расчётный 1ПМ, кг'), findsOneWidget);
    expect(find.text('Дата тренировки'), findsOneWidget);

    final volumeChip = tester.widget<ChoiceChip>(
      find.widgetWithText(ChoiceChip, 'Объём'),
    );
    volumeChip.onSelected!(true);
    await tester.pumpAndSettle();
    expect(find.text('Объём по тренировкам'), findsOneWidget);
    expect(find.text('Объём, кг'), findsOneWidget);
    expect(
      find.text(
        'Примерный максимальный вес на одно повторение, рассчитанный по лучшему подходу.',
      ),
      findsNothing,
    );
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('progress-streak-card')),
      -250,
    );
    expect(find.byKey(const ValueKey('progress-streak-card')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('progress-history-tab')));
    await tester.pumpAndSettle();
    expect(find.byType(Card), findsWidgets);
    expect(find.textContaining('подход'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows an empty progress state without workout history', (
    tester,
  ) async {
    await tester.pumpWidget(
      GymTrainingApp(
        telegram: const TelegramLaunchData.browser(),
        workoutRepository: InMemoryWorkoutRepository(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Прогресс'));
    await tester.pumpAndSettle();

    expect(find.text('Недостаточно данных'), findsOneWidget);
    expect(find.text('Открыть расписание'), findsOneWidget);
  });

  testWidgets('shows loading feedback while retrying progress', (tester) async {
    await tester.pumpWidget(
      GymTrainingApp(
        telegram: const TelegramLaunchData.browser(),
        progressRepository: _FailingProgressRepository(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Прогресс'));
    await tester.pumpAndSettle();
    expect(find.text('Не удалось загрузить статистику'), findsOneWidget);

    await tester.tap(find.text('Повторить'));
    await tester.pump();
    expect(find.byKey(const ValueKey('async-action-progress')), findsOneWidget);
  });

  testWidgets('shows Telegram identity in profile', (tester) async {
    const telegram = TelegramLaunchData(
      isTelegram: true,
      platform: 'tdesktop',
      version: '10.1',
      isDarkMode: true,
      userName: 'Dima (@dima)',
    );
    await tester.pumpWidget(GymTrainingApp(telegram: telegram));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Профиль'));
    await tester.pumpAndSettle();

    expect(find.text('Dima (@dima)'), findsOneWidget);
    expect(find.text('Telegram подключён'), findsOneWidget);
    expect(find.text('tdesktop'), findsOneWidget);
  });

  testWidgets('opens friends and shows sample progress with private sharing', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      GymTrainingApp(telegram: const TelegramLaunchData.browser()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Профиль'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Друзья'));
    await tester.pumpAndSettle();
    expect(find.text('Тренируйтесь вместе'), findsOneWidget);
    expect(find.text('Анна'), findsOneWidget);
    expect(find.text('Максим'), findsOneWidget);
    expect(find.textContaining('Тренируется сейчас'), findsOneWidget);

    await tester.tap(find.text('Анна'));
    await tester.pumpAndSettle();
    expect(find.text('Прогресс друга'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Расчётный 1ПМ по тренировкам'),
      250,
    );
    expect(find.text('Расчётный 1ПМ по тренировкам'), findsOneWidget);
    expect(find.text('Расчётный 1ПМ, кг'), findsOneWidget);
    final volumeChip = tester.widget<ChoiceChip>(
      find.widgetWithText(ChoiceChip, 'Объём'),
    );
    volumeChip.onSelected!(true);
    await tester.pumpAndSettle();
    expect(find.text('Объём по тренировкам'), findsOneWidget);
    expect(find.text('Объём, кг'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('История друга'), 250);
    expect(find.text('История друга'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('opens an invite directly on Telegram start parameter', (
    tester,
  ) async {
    const telegram = TelegramLaunchData(
      isTelegram: true,
      platform: 'tdesktop',
      version: '10.1',
      isDarkMode: true,
      startParam: 'invite_demo-code',
    );
    await tester.pumpWidget(GymTrainingApp(telegram: telegram));
    await tester.pumpAndSettle();

    expect(find.text('Вас пригласили в друзья'), findsOneWidget);
    expect(find.text('Тренируйтесь вместе'), findsOneWidget);
  });

  testWidgets('animates today when it is a training day', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final overview = TrainingOverview(
      scheduleName: 'Основная программа',
      days: List.generate(
        7,
        (index) => WeekDaySummary(
          label: const ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'][index],
          dayNumber: 28 + index,
          date: DateTime(2026, 9, 28 + index),
          isToday: index == 1,
          state: index == 1 ? TrainingDayState.upcoming : TrainingDayState.rest,
        ),
      ),
      nextTraining: const TrainingDaySummary(
        id: 'today',
        title: 'Тренировка сегодня',
        muscleGroups: ['Спина'],
        exerciseCount: 1,
        estimatedMinutes: 45,
      ),
      daysUntilNextTraining: 0,
      completedThisWeek: 0,
      totalMinutesThisWeek: 0,
      totalSetsThisWeek: 0,
    );
    await tester.pumpWidget(
      GymTrainingApp(
        telegram: const TelegramLaunchData.browser(),
        trainingRepository: _OverviewRepository(overview),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(find.byKey(const ValueKey('today-day-tile')), findsOneWidget);
    expect(find.byKey(const ValueKey('today-training-pulse')), findsOneWidget);
    expect(find.text('Тренировка сегодня'), findsWidgets);
    final pulse = find.byKey(const ValueKey('today-training-pulse'));
    final initialScale = tester
        .widget<Transform>(
          find.descendant(of: pulse, matching: find.byType(Transform)),
        )
        .transform
        .getMaxScaleOnAxis();

    await tester.pump(const Duration(milliseconds: 450));
    final animatedScale = tester
        .widget<Transform>(
          find.descendant(of: pulse, matching: find.byType(Transform)),
        )
        .transform
        .getMaxScaleOnAxis();
    expect(animatedScale, greaterThan(initialScale));
    expect(tester.takeException(), isNull);
  });

  testWidgets('creates a training day with a validated exercise', (
    tester,
  ) async {
    await tester.pumpWidget(
      GymTrainingApp(telegram: const TelegramLaunchData.browser()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Расписание'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Добавить тренировочный день'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Создать день'));
    await tester.tap(find.text('Создать день'));
    await tester.pump();
    expect(find.text('Введите название тренировочного дня'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('training-day-name-field')),
      'Кардио и кор',
    );
    await tester.tap(find.widgetWithText(TextButton, 'Добавить'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const ValueKey('exercise-name-field')),
      'Планка',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Добавить'));
    await tester.pumpAndSettle();
    expect(find.text('Планка'), findsOneWidget);

    await tester.ensureVisible(find.text('Создать день'));
    await tester.tap(find.text('Создать день'));
    await tester.pumpAndSettle();

    expect(find.text('Кардио и кор'), findsOneWidget);
    expect(find.text('1 упражнений · 45 мин'), findsOneWidget);
  });

  testWidgets('deletes an existing training day', (tester) async {
    await tester.pumpWidget(
      GymTrainingApp(telegram: const TelegramLaunchData.browser()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Расписание'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Грудь + трицепс'));
    await tester.pumpAndSettle();

    expect(find.text('Редактировать день'), findsOneWidget);
    await tester.drag(find.byType(ListView).last, const Offset(0, -500));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Удалить тренировочный день'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Удалить'));
    await tester.pumpAndSettle();

    expect(find.text('Грудь + трицепс'), findsNothing);
  });

  testWidgets(
    'renames an exercise without changing its identity or muscle group',
    (tester) async {
      final repository = InMemoryTrainingScheduleRepository();
      await tester.pumpWidget(
        GymTrainingApp(
          telegram: const TelegramLaunchData.browser(),
          scheduleRepository: repository,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Расписание'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Грудь + трицепс'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Переименовать Жим штанги лёжа'));
      await tester.pumpAndSettle();

      expect(find.text('Переименовать упражнение'), findsOneWidget);
      expect(find.text('Группа мышц'), findsNothing);
      expect(find.text('Описание (необязательно)'), findsNothing);
      await tester.enterText(
        find.byKey(const ValueKey('exercise-name-field')),
        'Жим лёжа новым именем',
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Сохранить'));
      await tester.pumpAndSettle();
      final saveDayButton = tester.widget<FilledButton>(
        find.widgetWithText(FilledButton, 'Сохранить изменения'),
      );
      saveDayButton.onPressed!();
      await tester.pumpAndSettle();

      final exercise = (await repository.load()).days.first.exercises.first;
      expect(exercise.id, 'bench-press');
      expect(exercise.name, 'Жим лёжа новым именем');
      expect(exercise.muscleGroup.name, 'chest');
    },
  );

  testWidgets('records a set and shows the completed workout in history', (
    tester,
  ) async {
    final repository = InMemoryWorkoutRepository();
    final app = GymTrainingApp(
      telegram: const TelegramLaunchData.browser(),
      workoutRepository: repository,
    );
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Начать тренировку'));
    await tester.pumpAndSettle();

    expect(find.text('Активная тренировка'), findsOneWidget);
    final active = Provider.of<WorkoutViewModel>(
      tester.element(find.text('Активная тренировка')),
      listen: false,
    ).activeWorkout!;
    expect(find.text(active.exercises.first.name), findsOneWidget);

    await tester.tap(
      find.widgetWithText(OutlinedButton, 'Добавить подход').first,
    );
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('set-repetitions-field')),
      '10',
    );
    await tester.enterText(
      find.byKey(const ValueKey('set-weight-field')),
      '40',
    );
    await tester.tap(find.byKey(const ValueKey('save-set-button')));
    await tester.pumpAndSettle();

    expect(find.text('10 повторений'), findsOneWidget);
    expect(find.text('40 кг'), findsOneWidget);

    final finishButton = find.byKey(const ValueKey('finish-workout-button'));
    await tester.drag(find.byType(ListView), const Offset(0, -500));
    await tester.pumpAndSettle();
    await tester.tap(finishButton);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Сохранить тренировку'));
    await tester.pumpAndSettle();

    expect(find.text('История'), findsWidgets);
    expect(find.text(active.title), findsOneWidget);
    expect(find.textContaining('1 подход'), findsOneWidget);

    await tester.tap(find.text(active.title));
    await tester.pumpAndSettle();
    expect(find.text('1. 10 повторений · 40 кг'), findsOneWidget);

    app.router.config.go('/workout/${active.trainingDayId}');
    await tester.pumpAndSettle();
    expect(find.text('Тренировка уже завершена'), findsOneWidget);
    expect(await repository.loadDraft(), isNull);
  });

  testWidgets('shows and resumes the active workout from home', (tester) async {
    await tester.pumpWidget(
      GymTrainingApp(telegram: const TelegramLaunchData.browser()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Начать тренировку'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Назад'));
    await tester.pumpAndSettle();

    expect(find.text('Активная Тренировка'), findsOneWidget);
    expect(find.text('Продолжить тренировку'), findsOneWidget);
    expect(find.text('В процессе'), findsOneWidget);

    await tester.tap(find.text('Продолжить тренировку'));
    await tester.pumpAndSettle();
    expect(find.text('Активная тренировка'), findsOneWidget);
    expect(find.textContaining('Добавить подход'), findsWidgets);

    await tester.tap(find.byTooltip('Назад'));
    await tester.pumpAndSettle();
  });

  testWidgets('reopening a completed workout does not start a new draft', (
    tester,
  ) async {
    final day = demoTrainingSchedule.days.first;
    final completedAt = DateTime.now();
    final repository = InMemoryWorkoutRepository(
      initialRecords: [
        WorkoutRecord(
          id: 'completed-today',
          trainingDayId: day.id,
          title: day.name,
          startedAt: completedAt.subtract(const Duration(minutes: 45)),
          completedAt: completedAt,
          exercises: const [],
        ),
      ],
    );
    final app = GymTrainingApp(
      telegram: const TelegramLaunchData.browser(),
      workoutRepository: repository,
    );
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();

    app.router.config.go('/workout/${day.id}');
    await tester.pumpAndSettle();

    expect(find.text('Тренировка уже завершена'), findsOneWidget);
    expect(await repository.loadDraft(), isNull);

    await tester.tap(find.text('Начать ещё одну тренировку'));
    await tester.pumpAndSettle();

    expect(find.text('Активная тренировка'), findsOneWidget);
    expect(await repository.loadDraft(), isNotNull);
  });

  testWidgets('shows an error when a workout schedule cannot be loaded', (
    tester,
  ) async {
    final app = GymTrainingApp(
      telegram: const TelegramLaunchData.browser(),
      scheduleRepository: _FailingTrainingScheduleRepository(),
    );
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();

    app.router.config.go('/workout/thursday-pull');
    await tester.pumpAndSettle();

    expect(find.text('Не удалось загрузить расписание'), findsOneWidget);
    expect(find.text('Повторить'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await tester.tap(find.text('Повторить'));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: find.byType(SnackBar),
        matching: find.text('Не удалось загрузить расписание'),
      ),
      findsOneWidget,
    );
  });
}

class _FailingTrainingScheduleRepository implements TrainingScheduleRepository {
  @override
  Future<TrainingSchedule> load() => Future.error(StateError('load failed'));

  @override
  Future<void> save(TrainingSchedule schedule) async {}
}

class _OverviewRepository implements TrainingOverviewRepository {
  _OverviewRepository(this.overview);

  final TrainingOverview overview;

  @override
  Future<TrainingOverview> getOverview() async => overview;
}

class _FailingProgressRepository implements ProgressRepository {
  @override
  Future<ProgressOverview> load(ProgressPeriod period) =>
      Future.error(StateError('load failed'));
}
