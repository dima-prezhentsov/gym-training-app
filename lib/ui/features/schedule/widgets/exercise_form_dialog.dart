import 'package:flutter/material.dart';

import '../../../../domain/models/exercise.dart';
import '../../../../domain/models/muscle_group.dart';

class ExerciseFormDialog extends StatefulWidget {
  const ExerciseFormDialog({super.key});

  @override
  State<ExerciseFormDialog> createState() => _ExerciseFormDialogState();
}

class _ExerciseFormDialogState extends State<ExerciseFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  MuscleGroup _muscleGroup = MuscleGroup.chest;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Новое упражнение'),
      content: SizedBox(
        width: 420,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: const ValueKey('exercise-name-field'),
                  controller: _nameController,
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'Название',
                    hintText: 'Например, жим штанги лёжа',
                  ),
                  validator: _requiredName,
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<MuscleGroup>(
                  initialValue: _muscleGroup,
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'Группа мышц'),
                  items: MuscleGroup.values
                      .map(
                        (group) => DropdownMenuItem(
                          value: group,
                          child: Text(group.label),
                        ),
                      )
                      .toList(),
                  onChanged: (group) {
                    if (group != null) _muscleGroup = group;
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _descriptionController,
                  minLines: 2,
                  maxLines: 4,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'Описание (необязательно)',
                    hintText: 'Техника или важные подсказки',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Добавить')),
      ],
    );
  }

  String? _requiredName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Введите название упражнения';
    }
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.of(context).pop(
      Exercise(
        id: 'exercise-${DateTime.now().microsecondsSinceEpoch}',
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        muscleGroup: _muscleGroup,
      ),
    );
  }
}
