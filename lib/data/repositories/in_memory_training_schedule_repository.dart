import '../../domain/models/exercise.dart';
import '../../domain/models/muscle_group.dart';
import '../../domain/models/training_day.dart';
import '../../domain/models/training_schedule.dart';
import '../../domain/models/training_weekday.dart';
import 'training_schedule_repository.dart';

class InMemoryTrainingScheduleRepository implements TrainingScheduleRepository {
  InMemoryTrainingScheduleRepository({TrainingSchedule? initialSchedule})
    : _schedule = initialSchedule ?? _demoSchedule;

  TrainingSchedule _schedule;

  @override
  Future<TrainingSchedule> load() async => _schedule;

  @override
  Future<void> save(TrainingSchedule schedule) async {
    _schedule = schedule;
  }

  static const _demoSchedule = TrainingSchedule(
    id: 'main-schedule',
    name: 'Основная программа',
    days: [
      TrainingDay(
        id: 'monday-push',
        name: 'Грудь + трицепс',
        weekday: TrainingWeekday.monday,
        estimatedDurationMinutes: 45,
        exercises: [
          Exercise(
            id: 'bench-press',
            name: 'Жим штанги лёжа',
            muscleGroup: MuscleGroup.chest,
          ),
          Exercise(
            id: 'triceps-extension',
            name: 'Разгибание рук на блоке',
            muscleGroup: MuscleGroup.triceps,
          ),
        ],
      ),
      TrainingDay(
        id: 'thursday-pull',
        name: 'Спина + бицепс',
        weekday: TrainingWeekday.thursday,
        estimatedDurationMinutes: 50,
        exercises: [
          Exercise(
            id: 'lat-pulldown',
            name: 'Тяга верхнего блока',
            muscleGroup: MuscleGroup.back,
          ),
          Exercise(
            id: 'barbell-curl',
            name: 'Подъём штанги на бицепс',
            muscleGroup: MuscleGroup.biceps,
          ),
        ],
      ),
      TrainingDay(
        id: 'saturday-legs',
        name: 'Ноги + плечи',
        weekday: TrainingWeekday.saturday,
        estimatedDurationMinutes: 60,
        exercises: [
          Exercise(
            id: 'squat',
            name: 'Приседания со штангой',
            muscleGroup: MuscleGroup.quadriceps,
          ),
          Exercise(
            id: 'shoulder-press',
            name: 'Жим гантелей сидя',
            muscleGroup: MuscleGroup.shoulders,
          ),
        ],
      ),
    ],
  );
}
