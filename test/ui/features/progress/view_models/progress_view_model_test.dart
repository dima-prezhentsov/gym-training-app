import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:gym_training_app/data/repositories/progress_repository.dart';
import 'package:gym_training_app/domain/models/progress_overview.dart';
import 'package:gym_training_app/ui/features/progress/view_models/progress_view_model.dart';

void main() {
  test('preloads all periods and switches without a new request', () async {
    final repository = _DeferredProgressRepository();
    final viewModel = ProgressViewModel(repository: repository);

    final initialLoad = viewModel.load();
    await viewModel.selectPeriod(ProgressPeriod.fourWeeks);

    repository.complete(ProgressPeriod.fourWeeks, _overview(workoutCount: 4));
    repository.complete(
      ProgressPeriod.threeMonths,
      _overview(workoutCount: 12),
    );
    repository.complete(ProgressPeriod.allTime, _overview(workoutCount: 20));
    await initialLoad;

    expect(viewModel.period, ProgressPeriod.fourWeeks);
    expect(viewModel.status, ProgressStatus.ready);
    expect(viewModel.overview?.workoutCount, 4);
    await viewModel.selectPeriod(ProgressPeriod.allTime);
    expect(viewModel.overview?.workoutCount, 20);
    expect(repository.requestCount, 3);
  });
}

ProgressOverview _overview({required int workoutCount}) => ProgressOverview(
  currentStreakDays: 0,
  bestStreakDays: 0,
  workoutCount: workoutCount,
  totalMinutes: 0,
  totalSets: 0,
  exercises: const [],
  muscleGroups: const [],
  personalRecords: const [],
);

class _DeferredProgressRepository implements ProgressRepository {
  final _requests = <ProgressPeriod, Completer<ProgressOverview>>{};
  int requestCount = 0;

  @override
  Future<ProgressOverview> load(ProgressPeriod period) {
    requestCount++;
    return (_requests[period] ??= Completer<ProgressOverview>()).future;
  }

  void complete(ProgressPeriod period, ProgressOverview overview) {
    _requests[period]!.complete(overview);
  }
}
