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
  final Map<ProgressPeriod, ProgressOverview> _overviews = {};
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
    _status = ProgressStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final overviews = await Future.wait(
        ProgressPeriod.values.map(_repository.load),
      );
      if (generation != _loadGeneration) return;
      _overviews
        ..clear()
        ..addEntries(
          ProgressPeriod.values.indexed.map(
            (entry) => MapEntry(entry.$2, overviews[entry.$1]),
          ),
        );
      _selectLoadedOverview();
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
    _selectLoadedOverview();
    notifyListeners();
  }

  void _selectLoadedOverview() {
    _overview = _overviews[_period];
    final exercises = _overview?.exercises ?? const <ExerciseProgress>[];
    if (exercises.isEmpty) {
      _selectedExerciseId = null;
    } else if (!exercises.any(
      (exercise) => exercise.exerciseId == _selectedExerciseId,
    )) {
      _selectedExerciseId = exercises.first.exerciseId;
    }
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
