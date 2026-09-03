import '../../domain/models/workout_record.dart';
import 'workout_repository.dart';

class InMemoryWorkoutRepository implements WorkoutRepository {
  InMemoryWorkoutRepository({List<WorkoutRecord> initialRecords = const []})
    : _records = [...initialRecords];

  final List<WorkoutRecord> _records;

  @override
  Future<List<WorkoutRecord>> loadHistory() async {
    final records = [..._records]
      ..sort((left, right) => right.completedAt.compareTo(left.completedAt));
    return List.unmodifiable(records);
  }

  @override
  Future<void> save(WorkoutRecord record) async {
    _records.add(record);
  }
}
