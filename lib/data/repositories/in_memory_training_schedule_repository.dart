import '../../domain/models/training_schedule.dart';
import '../fixtures/demo_training_schedule.dart';
import 'training_schedule_repository.dart';

class InMemoryTrainingScheduleRepository implements TrainingScheduleRepository {
  InMemoryTrainingScheduleRepository({TrainingSchedule? initialSchedule})
    : _schedule = initialSchedule ?? demoTrainingSchedule;

  TrainingSchedule _schedule;

  @override
  Future<TrainingSchedule> load() async => _schedule;

  @override
  Future<void> save(TrainingSchedule schedule) async {
    _schedule = schedule;
  }
}
