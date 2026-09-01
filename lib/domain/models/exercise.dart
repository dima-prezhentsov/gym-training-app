import 'muscle_group.dart';

class Exercise {
  const Exercise({
    required this.id,
    required this.name,
    required this.muscleGroup,
    this.description = '',
  });

  final String id;
  final String name;
  final String description;
  final MuscleGroup muscleGroup;

  Exercise copyWith({
    String? name,
    String? description,
    MuscleGroup? muscleGroup,
  }) {
    return Exercise(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      muscleGroup: muscleGroup ?? this.muscleGroup,
    );
  }
}
