import '../../domain/models/progress_overview.dart';
import 'progress_calculator.dart';
import 'progress_repository.dart';
import 'training_schedule_repository.dart';
import 'workout_repository.dart';

class ServerpodProgressRepository implements ProgressRepository {
  ServerpodProgressRepository({
    required TrainingScheduleRepository scheduleRepository,
    required WorkoutRepository workoutRepository,
    DateTime Function()? now,
  }) : _scheduleRepository = scheduleRepository,
       _workoutRepository = workoutRepository,
       _now = now ?? DateTime.now;

  final TrainingScheduleRepository _scheduleRepository;
  final WorkoutRepository _workoutRepository;
  final DateTime Function() _now;

  @override
  Future<ProgressOverview> load(ProgressPeriod period) async {
    final scheduleFuture = _scheduleRepository.load();
    final historyFuture = _workoutRepository.loadHistory();
    final schedule = await scheduleFuture;
    final history = await historyFuture;
    return calculateProgressOverview(
      schedule: schedule,
      history: history,
      period: period,
      now: _now(),
    );
  }
}
