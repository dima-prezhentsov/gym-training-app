import '../../domain/models/workout_record.dart';

abstract interface class WorkoutRepository {
  Future<List<WorkoutRecord>> loadHistory();

  Future<void> save(WorkoutRecord record);
}
