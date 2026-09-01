import '../../domain/models/training_schedule.dart';

abstract interface class TrainingScheduleRepository {
  Future<TrainingSchedule> load();

  Future<void> save(TrainingSchedule schedule);
}
