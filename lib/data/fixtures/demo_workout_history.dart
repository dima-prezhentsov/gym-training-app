import '../../domain/models/exercise_record.dart';
import '../../domain/models/muscle_group.dart';
import '../../domain/models/set_record.dart';
import '../../domain/models/workout_record.dart';

List<WorkoutRecord> buildDemoWorkoutHistory({DateTime? now}) {
  final current = (now ?? DateTime.now()).toLocal();
  final today = DateTime(current.year, current.month, current.day);
  final weekStart = today.subtract(Duration(days: today.weekday - 1));
  final records = <WorkoutRecord>[];

  for (var weeksAgo = 7; weeksAgo >= 0; weeksAgo--) {
    final progression = 7 - weeksAgo;
    final monday = weekStart.subtract(Duration(days: weeksAgo * 7));
    final thursday = monday.add(const Duration(days: 3));
    final saturday = monday.add(const Duration(days: 5));

    if (!monday.isAfter(today)) {
      records.add(_pushWorkout(monday, progression));
    }
    if (!thursday.isAfter(today) && weeksAgo != 3) {
      records.add(_pullWorkout(thursday, progression));
    }
    if (!saturday.isAfter(today)) {
      records.add(_legsWorkout(saturday, progression));
    }
  }

  records.sort((left, right) => right.completedAt.compareTo(left.completedAt));
  return List.unmodifiable(records);
}

WorkoutRecord _pushWorkout(DateTime date, int progression) {
  return _workout(
    date: date,
    id: 'demo-push-${_dateId(date)}',
    trainingDayId: 'monday-push',
    title: 'Грудь + трицепс',
    durationMinutes: 46 + progression,
    exercises: [
      _exercise(
        id: 'bench-press',
        name: 'Жим штанги лёжа',
        group: MuscleGroup.chest,
        weights: [
          55 + progression * 2.5,
          55 + progression * 2.5,
          50 + progression * 2.5,
        ],
        repetitions: const [10, 8, 10],
      ),
      _exercise(
        id: 'triceps-extension',
        name: 'Разгибание рук на блоке',
        group: MuscleGroup.triceps,
        weights: [20.0 + progression, 20.0 + progression, 18.0 + progression],
        repetitions: const [12, 10, 12],
      ),
    ],
  );
}

WorkoutRecord _pullWorkout(DateTime date, int progression) {
  return _workout(
    date: date,
    id: 'demo-pull-${_dateId(date)}',
    trainingDayId: 'thursday-pull',
    title: 'Спина + бицепс',
    durationMinutes: 50 + progression,
    exercises: [
      _exercise(
        id: 'lat-pulldown',
        name: 'Тяга верхнего блока',
        group: MuscleGroup.back,
        weights: [
          45 + progression * 2,
          45 + progression * 2,
          42 + progression * 2,
        ],
        repetitions: const [10, 9, 11],
      ),
      _exercise(
        id: 'barbell-curl',
        name: 'Подъём штанги на бицепс',
        group: MuscleGroup.biceps,
        weights: [20.0 + progression, 20.0 + progression, 18.0 + progression],
        repetitions: const [10, 8, 12],
      ),
    ],
  );
}

WorkoutRecord _legsWorkout(DateTime date, int progression) {
  return _workout(
    date: date,
    id: 'demo-legs-${_dateId(date)}',
    trainingDayId: 'saturday-legs',
    title: 'Ноги + плечи',
    durationMinutes: 58 + progression,
    exercises: [
      _exercise(
        id: 'squat',
        name: 'Приседания со штангой',
        group: MuscleGroup.quadriceps,
        weights: [
          70 + progression * 4,
          70 + progression * 4,
          65 + progression * 4,
        ],
        repetitions: const [8, 7, 10],
      ),
      _exercise(
        id: 'shoulder-press',
        name: 'Жим гантелей сидя',
        group: MuscleGroup.shoulders,
        weights: [16.0 + progression, 16.0 + progression, 14.0 + progression],
        repetitions: const [10, 9, 12],
      ),
    ],
  );
}

WorkoutRecord _workout({
  required DateTime date,
  required String id,
  required String trainingDayId,
  required String title,
  required int durationMinutes,
  required List<ExerciseRecord> exercises,
}) {
  final startedAt = DateTime(date.year, date.month, date.day, 18, 30);
  return WorkoutRecord(
    id: id,
    trainingDayId: trainingDayId,
    title: title,
    startedAt: startedAt,
    completedAt: startedAt.add(Duration(minutes: durationMinutes)),
    exercises: exercises,
  );
}

ExerciseRecord _exercise({
  required String id,
  required String name,
  required MuscleGroup group,
  required List<double> weights,
  required List<int> repetitions,
}) {
  return ExerciseRecord(
    exerciseId: id,
    name: name,
    muscleGroup: group,
    sets: List.generate(
      weights.length,
      (index) => SetRecord(
        id: '$id-${weights[index]}-${repetitions[index]}-$index',
        repetitions: repetitions[index],
        weightKg: weights[index],
      ),
    ),
  );
}

String _dateId(DateTime date) =>
    '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
