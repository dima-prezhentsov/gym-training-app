import 'package:flutter/material.dart';

import 'app/app.dart';
import 'data/repositories/serverpod_progress_repository.dart';
import 'data/repositories/serverpod_training_schedule_repository.dart';
import 'data/repositories/serverpod_training_overview_repository.dart';
import 'data/repositories/serverpod_workout_repository.dart';
import 'data/services/backend_session.dart';
import 'telegram/telegram_web_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final telegram = TelegramWebApp.initialize();
  final backendSession = BackendSession.fromEnvironment();
  backendSession.initialize(telegram);
  final scheduleRepository =
      telegram.isTelegram && backendSession.client != null
      ? ServerpodTrainingScheduleRepository(backendSession)
      : null;
  final workoutRepository = telegram.isTelegram && backendSession.client != null
      ? ServerpodWorkoutRepository(backendSession)
      : null;
  final trainingRepository =
      scheduleRepository != null && workoutRepository != null
      ? ServerpodTrainingOverviewRepository(
          scheduleRepository: scheduleRepository,
          workoutRepository: workoutRepository,
        )
      : null;
  final progressRepository =
      scheduleRepository != null && workoutRepository != null
      ? ServerpodProgressRepository(
          scheduleRepository: scheduleRepository,
          workoutRepository: workoutRepository,
        )
      : null;
  runApp(
    GymTrainingApp(
      telegram: telegram,
      backendSession: backendSession,
      trainingRepository: trainingRepository,
      scheduleRepository: scheduleRepository,
      workoutRepository: workoutRepository,
      progressRepository: progressRepository,
    ),
  );
}
