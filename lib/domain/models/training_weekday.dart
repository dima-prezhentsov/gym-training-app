enum TrainingWeekday {
  monday('Понедельник', 'Пн'),
  tuesday('Вторник', 'Вт'),
  wednesday('Среда', 'Ср'),
  thursday('Четверг', 'Чт'),
  friday('Пятница', 'Пт'),
  saturday('Суббота', 'Сб'),
  sunday('Воскресенье', 'Вс');

  const TrainingWeekday(this.label, this.shortLabel);

  final String label;
  final String shortLabel;
}
