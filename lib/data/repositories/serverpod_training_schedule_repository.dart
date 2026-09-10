import 'package:backend_client/backend_client.dart' as api;

import '../../domain/models/exercise.dart';
import '../../domain/models/muscle_group.dart';
import '../../domain/models/training_day.dart';
import '../../domain/models/training_schedule.dart';
import '../../domain/models/training_weekday.dart';
import '../fixtures/demo_training_schedule.dart';
import '../services/backend_session.dart';
import 'training_schedule_repository.dart';

class ServerpodTrainingScheduleRepository
    implements TrainingScheduleRepository {
  ServerpodTrainingScheduleRepository(this._session);

  final BackendSession _session;

  @override
  Future<TrainingSchedule> load() async {
    final client = await _authenticatedClient();
    final stored = await client.trainingSchedule.get();
    if (stored != null) return trainingScheduleFromDto(stored);

    final created = await client.trainingSchedule.save(
      trainingScheduleToDto(demoTrainingSchedule),
    );
    return trainingScheduleFromDto(created);
  }

  @override
  Future<void> save(TrainingSchedule schedule) async {
    final client = await _authenticatedClient();
    await client.trainingSchedule.save(trainingScheduleToDto(schedule));
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

api.TrainingScheduleDto trainingScheduleToDto(TrainingSchedule schedule) {
  return api.TrainingScheduleDto(
    id: schedule.id,
    name: schedule.name,
    days: schedule.days
        .map(
          (day) => api.TrainingDayDto(
            id: day.id,
            name: day.name,
            weekday: day.weekday.index,
            estimatedDurationMinutes: day.estimatedDurationMinutes,
            exercises: day.exercises
                .map(
                  (exercise) => api.ExerciseDto(
                    id: exercise.id,
                    name: exercise.name,
                    description: exercise.description,
                    muscleGroup: exercise.muscleGroup.name,
                  ),
                )
                .toList(),
          ),
        )
        .toList(),
  );
}

TrainingSchedule trainingScheduleFromDto(api.TrainingScheduleDto schedule) {
  return TrainingSchedule(
    id: schedule.id,
    name: schedule.name,
    days: schedule.days
        .map(
          (day) => TrainingDay(
            id: day.id,
            name: day.name,
            weekday: TrainingWeekday.values[day.weekday],
            estimatedDurationMinutes: day.estimatedDurationMinutes,
            exercises: day.exercises
                .map(
                  (exercise) => Exercise(
                    id: exercise.id,
                    name: exercise.name,
                    description: exercise.description,
                    muscleGroup: MuscleGroup.values.byName(
                      exercise.muscleGroup,
                    ),
                  ),
                )
                .toList(),
          ),
        )
        .toList(),
  );
}
