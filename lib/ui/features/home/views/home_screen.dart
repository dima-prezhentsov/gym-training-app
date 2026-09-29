import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../domain/models/active_workout.dart';
import '../../../../domain/models/training_overview.dart';
import '../../../../telegram/telegram_web_app.dart';
import '../../../core/utils/app_error_feedback.dart';
import '../../../core/widgets/async_action_button.dart';
import '../../workout/view_models/workout_view_model.dart';
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
          onRetry: () => retryWithErrorFeedback(
            context,
            operation: viewModel.loadOverview,
            errorMessage: () => viewModel.errorMessage,
            fallbackMessage: 'Не удалось загрузить данные',
          ),
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
    final activeWorkout = context.watch<WorkoutViewModel>().activeWorkout;
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
                          _trainingCountdown(overview.daysUntilNextTraining),
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
              _SectionTitle(
                title: activeWorkout == null
                    ? 'Следующая тренировка'
                    : 'Активная Тренировка',
              ),
              const SizedBox(height: 14),
              _NextTrainingCard(
                training: overview.nextTraining,
                activeWorkout: activeWorkout,
              ),
              const SizedBox(height: 32),
              const _SectionTitle(title: 'На этой неделе'),
              const SizedBox(height: 14),
              _WeeklyStats(overview: overview),
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
  Widget build(BuildContext context) => _AnimatedDayTile(day: day);
}

class _AnimatedDayTile extends StatefulWidget {
  const _AnimatedDayTile({required this.day});

  final WeekDaySummary day;

  @override
  State<_AnimatedDayTile> createState() => _AnimatedDayTileState();
}

class _AnimatedDayTileState extends State<_AnimatedDayTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulse;

  bool get _isTodayTraining => widget.day.isToday && widget.day.hasTraining;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _pulse = Tween<double>(
      begin: 1,
      end: 1.055,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncAnimation();
  }

  @override
  void didUpdateWidget(covariant _AnimatedDayTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncAnimation();
  }

  void _syncAnimation() {
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    if (_isTodayTraining && !disableAnimations) {
      if (!_controller.isAnimating) _controller.repeat(reverse: true);
    } else {
      _controller
        ..stop()
        ..value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final day = widget.day;
    final highlighted = day.hasTraining;
    final today = day.isToday;
    final tile = AnimatedContainer(
      key: today ? const ValueKey('today-day-tile') : null,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      height: 68,
      decoration: BoxDecoration(
        color: highlighted ? AppColors.lime : AppColors.surfaceRaised,
        borderRadius: BorderRadius.circular(16),
        border: today
            ? Border.all(
                color: highlighted ? AppColors.textPrimary : AppColors.lime,
                width: 2,
              )
            : null,
        boxShadow: _isTodayTraining
            ? [
                BoxShadow(
                  color: AppColors.lime.withValues(alpha: 0.28),
                  blurRadius: 14,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day.label,
            style: TextStyle(
              color: highlighted
                  ? AppColors.background
                  : today
                  ? AppColors.lime
                  : AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${day.dayNumber}',
            style: TextStyle(
              color: highlighted
                  ? AppColors.background
                  : today
                  ? AppColors.textPrimary
                  : AppColors.textSecondary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );

    return Semantics(
      label: [
        day.label,
        day.dayNumber,
        if (today) 'сегодня',
        if (day.hasTraining) 'тренировочный день',
      ].join(', '),
      child: AnimatedBuilder(
        key: _isTodayTraining ? const ValueKey('today-training-pulse') : null,
        animation: _controller,
        child: tile,
        builder: (context, child) => Transform.scale(
          scale: _isTodayTraining ? _pulse.value : 1,
          child: child,
        ),
      ),
    );
  }
}

class _NextTrainingCard extends StatelessWidget {
  const _NextTrainingCard({
    required this.training,
    required this.activeWorkout,
  });

  final TrainingDaySummary? training;
  final ActiveWorkout? activeWorkout;

  @override
  Widget build(BuildContext context) {
    final active = activeWorkout;
    final training = this.training;
    if (active == null && training == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Добавьте тренировочный день',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'После этого здесь появится ближайшая тренировка.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => context.go('/schedule'),
                  child: const Text('Настроить расписание'),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final title = active?.title ?? training!.title;
    final exerciseCount = active?.exercises.length ?? training!.exerciseCount;
    final muscleGroups = active == null
        ? training!.muscleGroups
        : active.exercises
              .map((exercise) => exercise.muscleGroup.label)
              .toSet()
              .toList();

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
                  active == null
                      ? '${training!.estimatedMinutes} мин'
                      : 'В процессе',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 26),
            Text(title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 6),
            Text(
              '${muscleGroups.join(' · ')}  ·  $exerciseCount упражнений',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => context.push(
                  '/workout/${active?.trainingDayId ?? training!.id}',
                ),
                icon: const Icon(Icons.play_arrow_rounded),
                label: Text(
                  active == null
                      ? 'Начать тренировку'
                      : 'Продолжить тренировку',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _trainingCountdown(int? daysUntil) {
  return switch (daysUntil) {
    null => 'Расписание не настроено',
    0 => 'Тренировка сегодня',
    1 => 'До тренировки — 1 день',
    >= 2 && <= 4 => 'До тренировки — $daysUntil дня',
    _ => 'До тренировки — $daysUntil дней',
  };
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
  final Future<void> Function() onRetry;

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
            AsyncActionButton(label: 'Повторить', onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}
