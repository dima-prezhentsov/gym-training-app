import 'package:flutter/foundation.dart';

import '../../../../data/repositories/training_schedule_repository.dart';
import '../../../../domain/models/training_day.dart';
import '../../../../domain/models/training_schedule.dart';

class ScheduleViewModel extends ChangeNotifier {
  ScheduleViewModel({required TrainingScheduleRepository repository})
    : _repository = repository;

  final TrainingScheduleRepository _repository;

  TrainingSchedule? _schedule;
  bool _isLoading = false;
  String? _errorMessage;

  TrainingSchedule? get schedule => _schedule;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> load() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _schedule = await _repository.load();
    } on Object {
      _errorMessage = 'Не удалось загрузить расписание';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveDay(TrainingDay day) async {
    final current = _schedule;
    if (current == null) return;

    final days = [...current.days];
    final existingIndex = days.indexWhere((item) => item.id == day.id);
    if (existingIndex == -1) {
      days.add(day);
    } else {
      days[existingIndex] = day;
    }
    days.sort(
      (left, right) => left.weekday.index.compareTo(right.weekday.index),
    );

    await _persist(current.copyWith(days: days));
  }

  Future<void> deleteDay(String dayId) async {
    final current = _schedule;
    if (current == null) return;

    await _persist(
      current.copyWith(
        days: current.days.where((day) => day.id != dayId).toList(),
      ),
    );
  }

  Future<void> _persist(TrainingSchedule schedule) async {
    _errorMessage = null;
    try {
      await _repository.save(schedule);
      _schedule = schedule;
    } on Object {
      _errorMessage = 'Не удалось сохранить изменения';
    }
    notifyListeners();
  }
}
