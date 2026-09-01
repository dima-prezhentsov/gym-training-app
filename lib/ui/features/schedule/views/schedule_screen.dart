import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/theme/app_colors.dart';
import '../../home/view_models/home_view_model.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final overview = context.watch<HomeViewModel>().overview;

    return SafeArea(
      bottom: false,
      child: ListView(
        key: const PageStorageKey('schedule-scroll'),
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 120),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Расписание',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              IconButton.filled(
                onPressed: () => _comingSoon(context),
                tooltip: 'Создать расписание',
                icon: const Icon(Icons.add_rounded),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            overview?.scheduleName ?? 'Основная программа',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 28),
          const _ScheduleDayCard(
            day: 'Понедельник',
            title: 'Грудь + трицепс',
            details: '5 упражнений · 45 мин',
            completed: true,
          ),
          const SizedBox(height: 12),
          const _ScheduleDayCard(
            day: 'Четверг',
            title: 'Спина + бицепс',
            details: '6 упражнений · 50 мин',
            highlighted: true,
          ),
          const SizedBox(height: 12),
          const _ScheduleDayCard(
            day: 'Суббота',
            title: 'Ноги + плечи',
            details: '7 упражнений · 60 мин',
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () => _comingSoon(context),
            icon: const Icon(Icons.add_rounded),
            label: const Text('Добавить тренировочный день'),
          ),
          const SizedBox(height: 16),
          Text(
            'Редактирование расписания будет подключено к backend на следующем этапе.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  void _comingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Редактор расписания — следующий этап')),
    );
  }
}

class _ScheduleDayCard extends StatelessWidget {
  const _ScheduleDayCard({
    required this.day,
    required this.title,
    required this.details,
    this.completed = false,
    this.highlighted = false,
  });

  final String day;
  final String title;
  final String details;
  final bool completed;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: highlighted ? AppColors.lime : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: highlighted ? AppColors.lime : AppColors.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                completed ? Icons.check_rounded : Icons.fitness_center_rounded,
                color: highlighted
                    ? AppColors.background
                    : AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(day, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 3),
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 5),
                  Text(details, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
