import 'training_day.dart';

class TrainingSchedule {
  const TrainingSchedule({
    required this.id,
    required this.name,
    this.days = const [],
  });

  final String id;
  final String name;
  final List<TrainingDay> days;

  TrainingSchedule copyWith({String? name, List<TrainingDay>? days}) {
    return TrainingSchedule(
      id: id,
      name: name ?? this.name,
      days: List.unmodifiable(days ?? this.days),
    );
  }
}
