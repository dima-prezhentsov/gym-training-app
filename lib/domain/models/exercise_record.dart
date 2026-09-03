import 'muscle_group.dart';
import 'set_record.dart';

class ExerciseRecord {
  const ExerciseRecord({
    required this.exerciseId,
    required this.name,
    required this.muscleGroup,
    this.sets = const [],
  });

  final String exerciseId;
  final String name;
  final MuscleGroup muscleGroup;
  final List<SetRecord> sets;

  ExerciseRecord copyWith({List<SetRecord>? sets}) {
    return ExerciseRecord(
      exerciseId: exerciseId,
      name: name,
      muscleGroup: muscleGroup,
      sets: List.unmodifiable(sets ?? this.sets),
    );
  }
}
