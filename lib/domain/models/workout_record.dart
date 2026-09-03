import 'exercise_record.dart';

class WorkoutRecord {
  const WorkoutRecord({
    required this.id,
    required this.trainingDayId,
    required this.title,
    required this.startedAt,
    required this.completedAt,
    required this.exercises,
  });

  final String id;
  final String trainingDayId;
  final String title;
  final DateTime startedAt;
  final DateTime completedAt;
  final List<ExerciseRecord> exercises;

  Duration get duration => completedAt.difference(startedAt);

  int get totalSets => exercises.fold(0, (sum, item) => sum + item.sets.length);
}
