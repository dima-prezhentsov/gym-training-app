import '../../domain/models/training_overview.dart';
import 'training_overview_builder.dart';
import 'training_overview_repository.dart';
import 'training_schedule_repository.dart';
import 'workout_repository.dart';

class ServerpodTrainingOverviewRepository
    implements TrainingOverviewRepository {
  ServerpodTrainingOverviewRepository({
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
  Future<TrainingOverview> getOverview() async {
    final schedule = await _scheduleRepository.load();
    final history = await _workoutRepository.loadHistory();
    return buildTrainingOverview(
      schedule: schedule,
      history: history,
      now: _now(),
    );
  }
}
