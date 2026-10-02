import '../../domain/models/active_workout.dart';
import '../../domain/models/workout_record.dart';

abstract interface class WorkoutRepository {
  Future<List<WorkoutRecord>> loadHistory();

  Future<ActiveWorkout?> loadDraft();

  Future<void> saveDraft(ActiveWorkout workout);

  Future<void> touchDraft();

  Future<void> save(WorkoutRecord record);
}
