import 'package:flutter/foundation.dart';

import '../../../../data/repositories/workout_repository.dart';
import '../../../../domain/models/active_workout.dart';
import '../../../../domain/models/exercise_record.dart';
import '../../../../domain/models/set_record.dart';
import '../../../../domain/models/training_day.dart';
import '../../../../domain/models/workout_record.dart';

enum WorkoutHistoryStatus { initial, loading, ready, failure }

class WorkoutViewModel extends ChangeNotifier {
  WorkoutViewModel({required WorkoutRepository repository})
    : _repository = repository;

  final WorkoutRepository _repository;

  WorkoutHistoryStatus _historyStatus = WorkoutHistoryStatus.initial;
  List<WorkoutRecord> _history = const [];
  ActiveWorkout? _activeWorkout;
  String? _errorMessage;

  WorkoutHistoryStatus get historyStatus => _historyStatus;
  List<WorkoutRecord> get history => _history;
  ActiveWorkout? get activeWorkout => _activeWorkout;
  String? get errorMessage => _errorMessage;

  Future<void> loadHistory() async {
    _historyStatus = WorkoutHistoryStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _history = await _repository.loadHistory();
      _historyStatus = WorkoutHistoryStatus.ready;
    } on Object {
      _historyStatus = WorkoutHistoryStatus.failure;
      _errorMessage = 'Не удалось загрузить историю';
    }
    notifyListeners();
  }

  void startWorkout(TrainingDay day, {DateTime? startedAt}) {
    if (_activeWorkout != null) return;

    _activeWorkout = ActiveWorkout(
      trainingDayId: day.id,
      title: day.name,
      startedAt: startedAt ?? DateTime.now(),
      exercises: List.unmodifiable(
        day.exercises.map(
          (exercise) => ExerciseRecord(
            exerciseId: exercise.id,
            name: exercise.name,
            muscleGroup: exercise.muscleGroup,
          ),
        ),
      ),
    );
    notifyListeners();
  }

  void addSet({
    required String exerciseId,
    required int repetitions,
    required double weightKg,
  }) {
    final active = _activeWorkout;
    if (active == null || repetitions <= 0 || weightKg < 0) return;
    if (!active.exercises.any(
      (exercise) => exercise.exerciseId == exerciseId,
    )) {
      return;
    }

    final exercises = active.exercises.map((exercise) {
      if (exercise.exerciseId != exerciseId) return exercise;
      return exercise.copyWith(
        sets: [
          ...exercise.sets,
          SetRecord(
            id: 'set-${DateTime.now().microsecondsSinceEpoch}',
            repetitions: repetitions,
            weightKg: weightKg,
          ),
        ],
      );
    }).toList();
    _activeWorkout = active.copyWith(exercises: exercises);
    notifyListeners();
  }

  void deleteSet({required String exerciseId, required String setId}) {
    final active = _activeWorkout;
    if (active == null) return;
    if (!active.exercises.any(
      (exercise) =>
          exercise.exerciseId == exerciseId &&
          exercise.sets.any((set) => set.id == setId),
    )) {
      return;
    }

    final exercises = active.exercises.map((exercise) {
      if (exercise.exerciseId != exerciseId) return exercise;
      return exercise.copyWith(
        sets: exercise.sets.where((set) => set.id != setId).toList(),
      );
    }).toList();
    _activeWorkout = active.copyWith(exercises: exercises);
    notifyListeners();
  }

  Future<WorkoutRecord?> finishWorkout({DateTime? completedAt}) async {
    final active = _activeWorkout;
    if (active == null || active.totalSets == 0) return null;

    final completionTime = completedAt ?? DateTime.now();
    final record = WorkoutRecord(
      id: 'workout-${completionTime.microsecondsSinceEpoch}',
      trainingDayId: active.trainingDayId,
      title: active.title,
      startedAt: active.startedAt,
      completedAt: completionTime,
      exercises: List.unmodifiable(active.exercises),
    );

    _errorMessage = null;
    try {
      await _repository.save(record);
      final history = [record, ..._history]
        ..sort((left, right) => right.completedAt.compareTo(left.completedAt));
      _history = List.unmodifiable(history);
      _historyStatus = WorkoutHistoryStatus.ready;
      _activeWorkout = null;
      notifyListeners();
      return record;
    } on Object {
      _errorMessage = 'Не удалось сохранить тренировку';
      notifyListeners();
      return null;
    }
  }
}
