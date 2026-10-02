import 'package:backend_client/backend_client.dart' as api;

import '../../domain/models/active_workout.dart';
import '../../domain/models/exercise_record.dart';
import '../../domain/models/muscle_group.dart';
import '../../domain/models/set_record.dart';
import '../../domain/models/workout_record.dart';
import '../services/backend_session.dart';
import 'workout_repository.dart';

class ServerpodWorkoutRepository implements WorkoutRepository {
  ServerpodWorkoutRepository(this._session);

  final BackendSession _session;

  @override
  Future<List<WorkoutRecord>> loadHistory() async {
    final client = await _authenticatedClient();
    final records = await client.workoutHistory.list();
    return records.map(workoutRecordFromDto).toList(growable: false);
  }

  @override
  Future<ActiveWorkout?> loadDraft() async {
    final client = await _authenticatedClient();
    final dto = await client.workoutHistory.loadDraft();
    if (dto == null) return null;
    return ActiveWorkout(
      trainingDayId: dto.trainingDayId,
      title: dto.title,
      startedAt: dto.startedAt.toLocal(),
      exercises: workoutRecordFromDto(dto).exercises,
    );
  }

  @override
  Future<void> saveDraft(ActiveWorkout workout) async {
    final client = await _authenticatedClient();
    await client.workoutHistory.saveDraft(
      workoutRecordToDto(
        WorkoutRecord(
          id: 'workout-${workout.startedAt.microsecondsSinceEpoch}',
          trainingDayId: workout.trainingDayId,
          title: workout.title,
          startedAt: workout.startedAt,
          completedAt: workout.startedAt,
          exercises: workout.exercises,
        ),
      ),
    );
  }

  @override
  Future<void> touchDraft() async {
    final client = await _authenticatedClient();
    await client.workoutHistory.touchDraft();
  }

  @override
  Future<void> save(WorkoutRecord record) async {
    final client = await _authenticatedClient();
    await client.workoutHistory.save(workoutRecordToDto(record));
  }

  Future<api.Client> _authenticatedClient() async {
    await _session.ready;
    final client = _session.client;
    if (client == null || !_session.isAuthenticated) {
      throw StateError('Backend session is not authenticated');
    }
    return client;
  }
}

api.WorkoutRecordDto workoutRecordToDto(WorkoutRecord record) {
  return api.WorkoutRecordDto(
    id: record.id,
    trainingDayId: record.trainingDayId,
    title: record.title,
    startedAt: record.startedAt.toUtc(),
    completedAt: record.completedAt.toUtc(),
    exercises: record.exercises
        .map(
          (exercise) => api.ExerciseRecordDto(
            exerciseId: exercise.exerciseId,
            name: exercise.name,
            muscleGroup: exercise.muscleGroup.name,
            sets: exercise.sets
                .map(
                  (set) => api.SetRecordDto(
                    id: set.id,
                    repetitions: set.repetitions,
                    weightKg: set.weightKg,
                  ),
                )
                .toList(),
          ),
        )
        .toList(),
  );
}

WorkoutRecord workoutRecordFromDto(api.WorkoutRecordDto record) {
  return WorkoutRecord(
    id: record.id,
    trainingDayId: record.trainingDayId,
    title: record.title,
    startedAt: record.startedAt.toLocal(),
    completedAt: record.completedAt.toLocal(),
    exercises: record.exercises
        .map(
          (exercise) => ExerciseRecord(
            exerciseId: exercise.exerciseId,
            name: exercise.name,
            muscleGroup: MuscleGroup.values.byName(exercise.muscleGroup),
            sets: exercise.sets
                .map(
                  (set) => SetRecord(
                    id: set.id,
                    repetitions: set.repetitions,
                    weightKg: set.weightKg,
                  ),
                )
                .toList(),
          ),
        )
        .toList(),
  );
}
