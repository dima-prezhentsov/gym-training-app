import '../../domain/models/training_overview.dart';

abstract interface class TrainingOverviewRepository {
  Future<TrainingOverview> getOverview();
}
