import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/repositories/demo_training_overview_repository.dart';
import '../data/repositories/in_memory_training_schedule_repository.dart';
import '../data/repositories/training_schedule_repository.dart';
import '../data/repositories/training_overview_repository.dart';
import '../telegram/telegram_web_app.dart';
import '../ui/features/home/view_models/home_view_model.dart';
import '../ui/features/schedule/view_models/schedule_view_model.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class GymTrainingApp extends StatelessWidget {
  GymTrainingApp({
    super.key,
    required this.telegram,
    TrainingOverviewRepository? trainingRepository,
    TrainingScheduleRepository? scheduleRepository,
  }) : trainingRepository =
           trainingRepository ?? const DemoTrainingOverviewRepository(),
       scheduleRepository =
           scheduleRepository ?? InMemoryTrainingScheduleRepository(),
       router = createAppRouter();

  final TelegramLaunchData telegram;
  final TrainingOverviewRepository trainingRepository;
  final TrainingScheduleRepository scheduleRepository;
  final AppRouter router;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TelegramLaunchData>.value(value: telegram),
        ChangeNotifierProvider(
          create: (_) =>
              HomeViewModel(repository: trainingRepository)..loadOverview(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              ScheduleViewModel(repository: scheduleRepository)..load(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Gym Training',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        routerConfig: router.config,
      ),
    );
  }
}
