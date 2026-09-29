import '../../domain/models/progress_overview.dart';

abstract interface class ProgressRepository {
  Future<ProgressOverview> load(ProgressPeriod period);
}
