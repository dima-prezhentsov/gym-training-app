import 'package:flutter/material.dart';

import 'app/app.dart';
import 'data/repositories/serverpod_training_schedule_repository.dart';
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
  runApp(
    GymTrainingApp(
      telegram: telegram,
      backendSession: backendSession,
      scheduleRepository: scheduleRepository,
    ),
  );
}
