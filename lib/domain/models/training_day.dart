import 'exercise.dart';
import 'training_weekday.dart';

class TrainingDay {
  const TrainingDay({
    required this.id,
    required this.name,
    required this.weekday,
    required this.estimatedDurationMinutes,
    this.exercises = const [],
  });

  final String id;
  final String name;
  final TrainingWeekday weekday;
  final int estimatedDurationMinutes;
  final List<Exercise> exercises;

  TrainingDay copyWith({
    String? name,
    TrainingWeekday? weekday,
    int? estimatedDurationMinutes,
    List<Exercise>? exercises,
  }) {
    return TrainingDay(
      id: id,
      name: name ?? this.name,
      weekday: weekday ?? this.weekday,
      estimatedDurationMinutes:
          estimatedDurationMinutes ?? this.estimatedDurationMinutes,
      exercises: List.unmodifiable(exercises ?? this.exercises),
    );
  }
}
