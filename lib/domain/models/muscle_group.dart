enum MuscleGroup {
  chest('Грудь'),
  back('Спина'),
  shoulders('Плечи'),
  biceps('Бицепс'),
  triceps('Трицепс'),
  quadriceps('Квадрицепс'),
  hamstrings('Задняя поверхность бедра'),
  glutes('Ягодицы'),
  calves('Голень'),
  core('Кор'),
  fullBody('Всё тело');

  const MuscleGroup(this.label);

  final String label;
}
