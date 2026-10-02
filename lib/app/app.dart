import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/fixtures/demo_workout_history.dart';
import '../data/repositories/friends_repository.dart';
import '../data/repositories/in_memory_friends_repository.dart';
import '../data/repositories/in_memory_progress_repository.dart';
import '../data/repositories/in_memory_training_schedule_repository.dart';
import '../data/repositories/in_memory_training_overview_repository.dart';
import '../data/repositories/in_memory_workout_repository.dart';
import '../data/repositories/progress_repository.dart';
import '../data/repositories/training_schedule_repository.dart';
import '../data/repositories/training_overview_repository.dart';
import '../data/repositories/workout_repository.dart';
import '../data/services/backend_session.dart';
import '../telegram/telegram_web_app.dart';
import '../ui/core/widgets/backend_availability_gate.dart';
import '../ui/features/home/view_models/home_view_model.dart';
import '../ui/features/progress/view_models/progress_view_model.dart';
import '../ui/features/schedule/view_models/schedule_view_model.dart';
import '../ui/features/workout/view_models/workout_view_model.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class GymTrainingApp extends StatelessWidget {
  factory GymTrainingApp({
    Key? key,
    required TelegramLaunchData telegram,
    TrainingOverviewRepository? trainingRepository,
    TrainingScheduleRepository? scheduleRepository,
    WorkoutRepository? workoutRepository,
    ProgressRepository? progressRepository,
    FriendsRepository? friendsRepository,
    BackendSession? backendSession,
  }) {
    final effectiveSchedule =
        scheduleRepository ?? InMemoryTrainingScheduleRepository();
    final effectiveWorkout =
        workoutRepository ??
        InMemoryWorkoutRepository(initialRecords: buildDemoWorkoutHistory());
    return GymTrainingApp._(
      key: key,
      telegram: telegram,
      trainingRepository:
          trainingRepository ??
          InMemoryTrainingOverviewRepository(
            scheduleRepository: effectiveSchedule,
            workoutRepository: effectiveWorkout,
          ),
      scheduleRepository: effectiveSchedule,
      workoutRepository: effectiveWorkout,
      progressRepository:
          progressRepository ??
          InMemoryProgressRepository(
            scheduleRepository: effectiveSchedule,
            workoutRepository: effectiveWorkout,
          ),
      friendsRepository: friendsRepository ?? InMemoryFriendsRepository(),
      backendSession: backendSession ?? BackendSession.fromEnvironment(),
    );
  }

  GymTrainingApp._({
    super.key,
    required this.telegram,
    required this.trainingRepository,
    required this.scheduleRepository,
    required this.workoutRepository,
    required this.progressRepository,
    required this.friendsRepository,
    required this.backendSession,
  }) : router = createAppRouter(startParam: telegram.startParam);

  final TelegramLaunchData telegram;
  final TrainingOverviewRepository trainingRepository;
  final TrainingScheduleRepository scheduleRepository;
  final WorkoutRepository workoutRepository;
  final ProgressRepository progressRepository;
  final FriendsRepository friendsRepository;
  final BackendSession backendSession;
  final AppRouter router;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TelegramLaunchData>.value(value: telegram),
        Provider<FriendsRepository>.value(value: friendsRepository),
        ChangeNotifierProvider<BackendSession>.value(
          value: backendSession..initialize(telegram),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              HomeViewModel(repository: trainingRepository)..loadOverview(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              ScheduleViewModel(repository: scheduleRepository)..load(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              WorkoutViewModel(repository: workoutRepository)..initialize(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              ProgressViewModel(repository: progressRepository)..load(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Gym Training',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        routerConfig: router.config,
        builder: (context, child) =>
            BackendAvailabilityGate(child: child ?? const SizedBox.shrink()),
      ),
    );
  }
}
