import 'exercise_record.dart';

class ActiveWorkout {
  const ActiveWorkout({
    required this.trainingDayId,
    required this.title,
    required this.startedAt,
    required this.exercises,
  });

  final String trainingDayId;
  final String title;
  final DateTime startedAt;
  final List<ExerciseRecord> exercises;

  int get totalSets => exercises.fold(0, (sum, item) => sum + item.sets.length);

  ActiveWorkout copyWith({List<ExerciseRecord>? exercises}) {
    return ActiveWorkout(
      trainingDayId: trainingDayId,
      title: title,
      startedAt: startedAt,
      exercises: List.unmodifiable(exercises ?? this.exercises),
    );
  }
}
