import 'package:flutter/foundation.dart';

import '../../../../data/repositories/training_overview_repository.dart';
import '../../../../domain/models/training_overview.dart';

enum HomeStatus { initial, loading, ready, failure }

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required TrainingOverviewRepository repository})
    : _repository = repository;

  final TrainingOverviewRepository _repository;

  HomeStatus _status = HomeStatus.initial;
  TrainingOverview? _overview;
  String? _errorMessage;

  HomeStatus get status => _status;
  TrainingOverview? get overview => _overview;
  String? get errorMessage => _errorMessage;

  Future<void> loadOverview() async {
    _status = HomeStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _overview = await _repository.getOverview();
      _status = HomeStatus.ready;
    } catch (_) {
      _status = HomeStatus.failure;
      _errorMessage = 'Не удалось загрузить расписание';
    }
    notifyListeners();
  }
}
