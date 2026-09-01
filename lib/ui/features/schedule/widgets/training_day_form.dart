import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../domain/models/exercise.dart';
import '../../../../domain/models/training_day.dart';
import '../../../../domain/models/training_weekday.dart';
import 'exercise_form_dialog.dart';

class TrainingDayForm extends StatefulWidget {
  const TrainingDayForm({
    super.key,
    this.initialDay,
    required this.onSave,
    this.onDelete,
  });

  final TrainingDay? initialDay;
  final Future<void> Function(TrainingDay day) onSave;
  final Future<void> Function()? onDelete;

  @override
  State<TrainingDayForm> createState() => _TrainingDayFormState();
}

class _TrainingDayFormState extends State<TrainingDayForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _durationController;
  late TrainingWeekday _weekday;
  late List<Exercise> _exercises;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    final day = widget.initialDay;
    _nameController = TextEditingController(text: day?.name);
    _durationController = TextEditingController(
      text: day?.estimatedDurationMinutes.toString() ?? '45',
    );
    _weekday = day?.weekday ?? TrainingWeekday.monday;
    _exercises = [...?day?.exercises];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.initialDay != null;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        12,
        20,
        MediaQuery.viewInsetsOf(context).bottom + 24,
      ),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            Center(
              child: Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              isEditing ? 'Редактировать день' : 'Новый тренировочный день',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 22),
            TextFormField(
              key: const ValueKey('training-day-name-field'),
              controller: _nameController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Название',
                hintText: 'Например, грудь + трицепс',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Введите название тренировочного дня';
                }
                return null;
              },
            ),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: DropdownButtonFormField<TrainingWeekday>(
                    initialValue: _weekday,
                    isExpanded: true,
                    decoration: const InputDecoration(labelText: 'День недели'),
                    items: TrainingWeekday.values
                        .map(
                          (day) => DropdownMenuItem(
                            value: day,
                            child: Text(day.label),
                          ),
                        )
                        .toList(),
                    onChanged: (day) {
                      if (day != null) _weekday = day;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _durationController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Минуты',
                      suffixText: 'мин',
                    ),
                    validator: (value) {
                      final duration = int.tryParse(value ?? '');
                      if (duration == null || duration < 5 || duration > 300) {
                        return 'От 5 до 300';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 26),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Упражнения · ${_exercises.length}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                TextButton.icon(
                  onPressed: _addExercise,
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Добавить'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (_exercises.isEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surfaceRaised,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Добавьте упражнения, которые нужно выполнить в этот день.',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              )
            else
              ..._exercises.indexed.map((entry) {
                final index = entry.$1;
                final exercise = entry.$2;
                return _ExerciseTile(
                  exercise: exercise,
                  onDelete: () => setState(() => _exercises.removeAt(index)),
                );
              }),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _isSubmitting ? null : _submit,
              child: Text(isEditing ? 'Сохранить изменения' : 'Создать день'),
            ),
            if (widget.onDelete != null) ...[
              const SizedBox(height: 10),
              TextButton(
                onPressed: _isSubmitting ? null : _confirmDelete,
                style: TextButton.styleFrom(foregroundColor: AppColors.error),
                child: const Text('Удалить тренировочный день'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _addExercise() async {
    final exercise = await showDialog<Exercise>(
      context: context,
      builder: (_) => const ExerciseFormDialog(),
    );
    if (exercise == null || !mounted) return;
    setState(() => _exercises.add(exercise));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);

    final initialDay = widget.initialDay;
    final day = TrainingDay(
      id:
          initialDay?.id ??
          'training-day-${DateTime.now().microsecondsSinceEpoch}',
      name: _nameController.text.trim(),
      weekday: _weekday,
      estimatedDurationMinutes: int.parse(_durationController.text),
      exercises: List.unmodifiable(_exercises),
    );
    await widget.onSave(day);

    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _confirmDelete() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить тренировочный день?'),
        content: const Text('День и список его упражнений будут удалены.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
    if (shouldDelete != true || !mounted) return;

    setState(() => _isSubmitting = true);
    await widget.onDelete!();
    if (mounted) Navigator.of(context).pop();
  }
}

class _ExerciseTile extends StatelessWidget {
  const _ExerciseTile({required this.exercise, required this.onDelete});

  final Exercise exercise;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceRaised,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 3),
                Text(
                  exercise.muscleGroup.label,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onDelete,
            tooltip: 'Удалить ${exercise.name}',
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
    );
  }
}
