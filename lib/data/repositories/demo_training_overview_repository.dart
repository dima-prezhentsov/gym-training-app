import '../../domain/models/training_overview.dart';
import 'training_overview_repository.dart';

class DemoTrainingOverviewRepository implements TrainingOverviewRepository {
  const DemoTrainingOverviewRepository();

  @override
  Future<TrainingOverview> getOverview() async {
    return const TrainingOverview(
      scheduleName: 'Основная программа',
      days: [
        WeekDaySummary(
          label: 'Пн',
          dayNumber: 9,
          state: TrainingDayState.completed,
        ),
        WeekDaySummary(
          label: 'Вт',
          dayNumber: 10,
          state: TrainingDayState.completed,
        ),
        WeekDaySummary(
          label: 'Ср',
          dayNumber: 11,
          state: TrainingDayState.rest,
        ),
        WeekDaySummary(
          label: 'Чт',
          dayNumber: 12,
          state: TrainingDayState.upcoming,
        ),
        WeekDaySummary(
          label: 'Пт',
          dayNumber: 13,
          state: TrainingDayState.rest,
        ),
      ],
      nextTraining: TrainingDaySummary(
        id: 'back-and-biceps',
        title: 'Спина + бицепс',
        muscleGroups: ['Спина', 'Бицепс'],
        exerciseCount: 6,
        estimatedMinutes: 50,
      ),
      completedThisWeek: 2,
      totalMinutesThisWeek: 95,
      totalSetsThisWeek: 28,
    );
  }
}
