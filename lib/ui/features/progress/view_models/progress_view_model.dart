import 'package:flutter/foundation.dart';

import '../../../../data/repositories/progress_repository.dart';
import '../../../../domain/models/progress_overview.dart';

enum ProgressStatus { initial, loading, ready, failure }

class ProgressViewModel extends ChangeNotifier {
  ProgressViewModel({required ProgressRepository repository})
    : _repository = repository;

  final ProgressRepository _repository;

  ProgressStatus _status = ProgressStatus.initial;
  ProgressPeriod _period = ProgressPeriod.threeMonths;
  ExerciseProgressMetric _metric = ExerciseProgressMetric.estimatedMax;
  ProgressOverview? _overview;
  String? _selectedExerciseId;
  String? _errorMessage;
  var _loadGeneration = 0;

  ProgressStatus get status => _status;
  ProgressPeriod get period => _period;
  ExerciseProgressMetric get metric => _metric;
  ProgressOverview? get overview => _overview;
  String? get selectedExerciseId => _selectedExerciseId;
  String? get errorMessage => _errorMessage;

  ExerciseProgress? get selectedExercise {
    final exercises = _overview?.exercises ?? const [];
    if (exercises.isEmpty) return null;
    return exercises.firstWhere(
      (exercise) => exercise.exerciseId == _selectedExerciseId,
      orElse: () => exercises.first,
    );
  }

  Future<void> load() async {
    final generation = ++_loadGeneration;
    final requestedPeriod = _period;
    _status = ProgressStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final overview = await _repository.load(requestedPeriod);
      if (generation != _loadGeneration) return;
      _overview = overview;
      final exercises = _overview!.exercises;
      if (exercises.isEmpty) {
        _selectedExerciseId = null;
      } else if (!exercises.any(
        (exercise) => exercise.exerciseId == _selectedExerciseId,
      )) {
        _selectedExerciseId = exercises.first.exerciseId;
      }
      _status = ProgressStatus.ready;
    } on Object {
      if (generation != _loadGeneration) return;
      _status = ProgressStatus.failure;
      _errorMessage = 'Не удалось загрузить статистику';
    }
    notifyListeners();
  }

  Future<void> selectPeriod(ProgressPeriod period) async {
    if (_period == period) return;
    _period = period;
    await load();
  }

  void selectExercise(String? exerciseId) {
    if (exerciseId == null || _selectedExerciseId == exerciseId) return;
    _selectedExerciseId = exerciseId;
    notifyListeners();
  }

  void selectMetric(ExerciseProgressMetric metric) {
    if (_metric == metric) return;
    _metric = metric;
    notifyListeners();
  }
}
