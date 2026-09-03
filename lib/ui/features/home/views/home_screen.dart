import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../domain/models/training_overview.dart';
import '../../../../telegram/telegram_web_app.dart';
import '../view_models/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return SafeArea(
      bottom: false,
      child: switch (viewModel.status) {
        HomeStatus.initial ||
        HomeStatus.loading => const Center(child: CircularProgressIndicator()),
        HomeStatus.failure => _HomeError(
          message: viewModel.errorMessage ?? 'Что-то пошло не так',
          onRetry: viewModel.loadOverview,
        ),
        HomeStatus.ready => _HomeContent(overview: viewModel.overview!),
      },
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.overview});

  final TrainingOverview overview;

  @override
  Widget build(BuildContext context) {
    final telegram = context.read<TelegramLaunchData>();
    final displayName = telegram.userName?.split(' ').first ?? 'спортсмен';

    return CustomScrollView(
      key: const PageStorageKey('home-scroll'),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 120),
          sliver: SliverList.list(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Привет, $displayName',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'До тренировки — 2 дня',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                  const _RoundIcon(icon: Icons.notifications_none_rounded),
                ],
              ),
              const SizedBox(height: 26),
              _WeekStrip(days: overview.days),
              const SizedBox(height: 32),
              const _SectionTitle(title: 'Следующая тренировка'),
              const SizedBox(height: 14),
              _NextTrainingCard(training: overview.nextTraining),
              const SizedBox(height: 32),
              const _SectionTitle(title: 'На этой неделе'),
              const SizedBox(height: 14),
              _WeeklyStats(overview: overview),
              const SizedBox(height: 24),
              Text(
                'Демо-данные · ${overview.scheduleName}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WeekStrip extends StatelessWidget {
  const _WeekStrip({required this.days});

  final List<WeekDaySummary> days;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var index = 0; index < days.length; index++) ...[
          Expanded(child: _DayTile(day: days[index])),
          if (index != days.length - 1) const SizedBox(width: 8),
        ],
      ],
    );
  }
}

class _DayTile extends StatelessWidget {
  const _DayTile({required this.day});

  final WeekDaySummary day;

  @override
  Widget build(BuildContext context) {
    final highlighted = day.state != TrainingDayState.rest;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 68,
      decoration: BoxDecoration(
        color: highlighted ? AppColors.lime : AppColors.surfaceRaised,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day.label,
            style: TextStyle(
              color: highlighted
                  ? AppColors.background
                  : AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${day.dayNumber}',
            style: TextStyle(
              color: highlighted
                  ? AppColors.background
                  : AppColors.textSecondary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _NextTrainingCard extends StatelessWidget {
  const _NextTrainingCard({required this.training});

  final TrainingDaySummary training;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: AppColors.lime,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.fitness_center_rounded,
                    color: AppColors.background,
                  ),
                ),
                const Spacer(),
                Text(
                  '${training.estimatedMinutes} мин',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 26),
            Text(
              training.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 6),
            Text(
              '${training.muscleGroups.join(' · ')}  ·  ${training.exerciseCount} упражнений',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => context.push('/workout/${training.id}'),
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('Начать тренировку'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeeklyStats extends StatelessWidget {
  const _WeeklyStats({required this.overview});

  final TrainingOverview overview;

  @override
  Widget build(BuildContext context) {
    final hours = overview.totalMinutesThisWeek ~/ 60;
    final minutes = overview.totalMinutesThisWeek % 60;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.outline),
        borderRadius: BorderRadius.circular(24),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            _StatItem(
              icon: Icons.check_rounded,
              value: '${overview.completedThisWeek}',
              label: 'тренировки',
            ),
            const VerticalDivider(),
            _StatItem(
              icon: Icons.timer_outlined,
              value: '$hours ч $minutes мин',
              label: 'в зале',
            ),
            const VerticalDivider(),
            _StatItem(
              icon: Icons.repeat_rounded,
              value: '${overview.totalSetsThisWeek}',
              label: 'подходов',
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 6),
        child: Column(
          children: [
            Icon(icon, size: 20, color: AppColors.lime),
            const SizedBox(height: 10),
            Text(value, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 2),
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleLarge);
  }
}

class _RoundIcon extends StatelessWidget {
  const _RoundIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.outline),
      ),
      child: Icon(icon, size: 22),
    );
  }
}

class _HomeError extends StatelessWidget {
  const _HomeError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: const Text('Повторить')),
          ],
        ),
      ),
    );
  }
}
