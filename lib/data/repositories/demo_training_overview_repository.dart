import '../../domain/models/training_overview.dart';
import '../fixtures/demo_training_schedule.dart';
import 'training_overview_builder.dart';
import 'training_overview_repository.dart';

class DemoTrainingOverviewRepository implements TrainingOverviewRepository {
  DemoTrainingOverviewRepository({DateTime Function()? now})
    : _now = now ?? DateTime.now;

  final DateTime Function() _now;

  @override
  Future<TrainingOverview> getOverview() async {
    return buildTrainingOverview(
      schedule: demoTrainingSchedule,
      history: const [],
      now: _now(),
    );
  }
}
