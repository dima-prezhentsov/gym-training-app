import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/repositories/demo_training_overview_repository.dart';
import '../data/repositories/training_overview_repository.dart';
import '../telegram/telegram_web_app.dart';
import '../ui/features/home/view_models/home_view_model.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class GymTrainingApp extends StatelessWidget {
  GymTrainingApp({
    super.key,
    required this.telegram,
    TrainingOverviewRepository? trainingRepository,
  }) : trainingRepository =
           trainingRepository ?? const DemoTrainingOverviewRepository(),
       router = createAppRouter();

  final TelegramLaunchData telegram;
  final TrainingOverviewRepository trainingRepository;
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
