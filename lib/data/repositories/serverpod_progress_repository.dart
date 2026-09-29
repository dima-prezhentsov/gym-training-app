import 'package:backend_client/backend_client.dart' as api;

import '../../domain/models/muscle_group.dart';
import '../../domain/models/progress_overview.dart';
import '../services/backend_session.dart';
import 'progress_repository.dart';

class ServerpodProgressRepository implements ProgressRepository {
  ServerpodProgressRepository(this._session);

  final BackendSession _session;

  @override
  Future<ProgressOverview> load(ProgressPeriod period) async {
    await _session.ready;
    final client = _session.client;
    if (client == null || !_session.isAuthenticated) {
      throw StateError('Backend session is not authenticated');
    }
    final dto = await client.progress.get(
      period: period.name,
      utcOffsetMinutes: DateTime.now().timeZoneOffset.inMinutes,
    );
    return progressOverviewFromDto(dto);
  }
}

ProgressOverview progressOverviewFromDto(api.ProgressOverviewDto dto) =>
    ProgressOverview(
      currentStreakDays: dto.currentStreakDays,
      bestStreakDays: dto.bestStreakDays,
      workoutCount: dto.workoutCount,
      totalMinutes: dto.totalMinutes,
      totalSets: dto.totalSets,
      exercises: dto.exercises
          .map(
            (exercise) => ExerciseProgress(
              exerciseId: exercise.exerciseId,
              name: exercise.name,
              points: exercise.points
                  .map(
                    (point) => ExerciseProgressPoint(
                      date: point.date.toLocal(),
                      estimatedMaxKg: point.estimatedMaxKg,
                      maxWeightKg: point.maxWeightKg,
                      volumeKg: point.volumeKg,
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
      muscleGroups: dto.muscleGroups
          .map(
            (group) => MuscleGroupProgress(
              group: MuscleGroup.values.byName(group.group),
              setCount: group.setCount,
            ),
          )
          .toList(),
      personalRecords: dto.personalRecords
          .map(
            (record) => PersonalRecord(
              exerciseId: record.exerciseId,
              exerciseName: record.exerciseName,
              weightKg: record.weightKg,
              repetitions: record.repetitions,
              estimatedMaxKg: record.estimatedMaxKg,
              achievedAt: record.achievedAt.toLocal(),
            ),
          )
          .toList(),
    );
