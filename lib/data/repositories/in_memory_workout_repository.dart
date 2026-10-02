import '../../domain/models/active_workout.dart';
import '../../domain/models/workout_record.dart';
import 'workout_repository.dart';

class InMemoryWorkoutRepository implements WorkoutRepository {
  InMemoryWorkoutRepository({List<WorkoutRecord> initialRecords = const []})
    : _records = [...initialRecords];

  final List<WorkoutRecord> _records;
  ActiveWorkout? _draft;

  @override
  Future<ActiveWorkout?> loadDraft() async => _draft;

  @override
  Future<void> saveDraft(ActiveWorkout workout) async {
    _draft = workout;
  }

  @override
  Future<void> touchDraft() async {}

  @override
  Future<List<WorkoutRecord>> loadHistory() async {
    final records = [..._records]
      ..sort((left, right) => right.completedAt.compareTo(left.completedAt));
    return List.unmodifiable(records);
  }

  @override
  Future<void> save(WorkoutRecord record) async {
    _records.removeWhere((item) => item.id == record.id);
    _records.add(record);
    if (_draft?.startedAt == record.startedAt) _draft = null;
  }
}
