import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../data/repositories/friend_error_message.dart';
import '../../../../data/repositories/friends_repository.dart';
import '../../../../domain/models/friend_connection.dart';
import '../../../../domain/models/progress_overview.dart';
import '../../../../domain/models/workout_record.dart';
import '../../../core/utils/app_error_feedback.dart';
import '../../../core/widgets/exercise_progress_chart_card.dart';

class FriendDetailScreen extends StatefulWidget {
  const FriendDetailScreen({super.key, required this.userId});

  final String userId;

  @override
  State<FriendDetailScreen> createState() => _FriendDetailScreenState();
}

class _FriendDetailScreenState extends State<FriendDetailScreen> {
  FriendConnection? _friend;
  ProgressOverview? _progress;
  List<WorkoutRecord>? _history;
  String? _error;
  bool _loading = true;
  bool _busy = false;
  String? _selectedExerciseId;
  ExerciseProgressMetric _selectedMetric = ExerciseProgressMetric.estimatedMax;

  @override
  void initState() {
    super.initState();
    Future.microtask(_load);
  }

  Future<void> _load() async {
    if (mounted) {
      setState(() {
        _loading = true;
        _error = null;
      });
    }
    try {
      if (!await ensureBackendReady(context)) {
        if (mounted) setState(() => _error = 'Нет подключения к аккаунту');
        return;
      }
      if (!mounted) return;
      final repository = context.read<FriendsRepository>();
      final friends = await repository.list();
      final friend = friends
          .where((item) => item.userId == widget.userId)
          .firstOrNull;
      if (friend == null || !friend.isAccepted) {
        throw StateError('Friend not found');
      }
      final progress = friend.canViewStats
          ? await repository.loadProgress(
              friend.userId,
              ProgressPeriod.threeMonths,
            )
          : null;
      final history = friend.canViewHistory
          ? await repository.loadHistory(friend.userId)
          : null;
      if (mounted) {
        setState(() {
          _friend = friend;
          _progress = progress;
          _history = history;
          _selectedExerciseId = progress?.exercises.firstOrNull?.exerciseId;
        });
      }
    } on Object catch (error) {
      if (mounted) {
        setState(
          () => _error = friendErrorMessage(
            error,
            fallback: 'Не удалось загрузить профиль друга',
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _setSharing({bool? stats, bool? history, bool? activity}) async {
    final friend = _friend;
    if (friend == null || _busy) return;
    setState(() => _busy = true);
    try {
      final updated = await context.read<FriendsRepository>().setSharing(
        friend.userId,
        stats: stats ?? friend.sharesStats,
        history: history ?? friend.sharesHistory,
        activity: activity ?? friend.sharesActivity,
      );
      if (mounted) setState(() => _friend = updated);
    } on Object {
      if (mounted) showAppErrorSnackBar(context, 'Не удалось изменить доступ');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _remove() async {
    final friend = _friend;
    if (friend == null || _busy) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить друга?'),
        content: const Text('Доступ к вашим данным будет закрыт сразу.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    if (!mounted) return;
    final repository = context.read<FriendsRepository>();
    setState(() => _busy = true);
    try {
      await repository.remove(friend.userId);
      if (mounted) context.pop();
    } on Object {
      if (mounted) showAppErrorSnackBar(context, 'Не удалось удалить друга');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final friend = _friend;
    return Scaffold(
      appBar: AppBar(title: Text(friend?.displayName ?? 'Друг')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_error!),
                        TextButton(
                          onPressed: _load,
                          child: const Text('Повторить'),
                        ),
                      ],
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 36),
                    children: [
                      Text(
                        friend!.displayName,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      if (friend.username case final username?)
                        Text(
                          '@$username',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      const SizedBox(height: 28),
                      Text(
                        'Доступ к моим данным',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Card(
                        child: Column(
                          children: [
                            SwitchListTile(
                              title: const Text('Статистика'),
                              subtitle: const Text('Стрик, графики и рекорды'),
                              value: friend.sharesStats,
                              onChanged: _busy
                                  ? null
                                  : (value) => _setSharing(stats: value),
                            ),
                            const Divider(),
                            SwitchListTile(
                              title: const Text('История тренировок'),
                              subtitle: const Text(
                                'Упражнения, подходы и веса',
                              ),
                              value: friend.sharesHistory,
                              onChanged: _busy
                                  ? null
                                  : (value) => _setSharing(history: value),
                            ),
                            const Divider(),
                            SwitchListTile(
                              title: const Text('Статус тренировки'),
                              subtitle: const Text(
                                'Показывать другу, тренируетесь ли вы сейчас',
                              ),
                              value: friend.sharesActivity,
                              onChanged: _busy
                                  ? null
                                  : (value) => _setSharing(activity: value),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Прогресс друга',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      if (_progress case final progress?) ...[
                        Row(
                          children: [
                            Expanded(
                              child: _MetricCard(
                                title: 'Стрик',
                                value: '${progress.currentStreakDays} дн.',
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _MetricCard(
                                title: 'Тренировок · 3 мес.',
                                value: '${progress.workoutCount}',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _MetricCard(
                                title: 'Подходов',
                                value: '${progress.totalSets}',
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _MetricCard(
                                title: 'Время',
                                value: '${progress.totalMinutes} мин',
                              ),
                            ),
                          ],
                        ),
                        if (progress.exercises.isNotEmpty) ...[
                          const SizedBox(height: 20),
                          ExerciseProgressChartCard(
                            exercises: progress.exercises,
                            exercise: progress.exercises.firstWhere(
                              (item) => item.exerciseId == _selectedExerciseId,
                              orElse: () => progress.exercises.first,
                            ),
                            metric: _selectedMetric,
                            onSelectExercise: (id) =>
                                setState(() => _selectedExerciseId = id),
                            onSelectMetric: (metric) =>
                                setState(() => _selectedMetric = metric),
                          ),
                        ],
                      ] else
                        const Card(
                          child: Padding(
                            padding: EdgeInsets.all(18),
                            child: Text('Друг пока не открыл вам статистику.'),
                          ),
                        ),
                      const SizedBox(height: 30),
                      Text(
                        'История друга',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      if (_history case final history?)
                        if (history.isEmpty)
                          const Text('Тренировок пока нет')
                        else
                          for (final (index, record) in history.indexed) ...[
                            if (index > 0) const SizedBox(height: 10),
                            Card(
                              child: ExpansionTile(
                                title: Text(record.title),
                                subtitle: Text(
                                  '${record.completedAt.day}.${record.completedAt.month}.${record.completedAt.year} · ${record.duration.inMinutes} мин',
                                ),
                                children: [
                                  for (final exercise in record.exercises)
                                    ListTile(
                                      title: Text(exercise.name),
                                      subtitle: Text(
                                        exercise.sets
                                            .map(
                                              (set) =>
                                                  '${set.weightKg} кг × ${set.repetitions}',
                                            )
                                            .join('  ·  '),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ]
                      else
                        const Card(
                          child: Padding(
                            padding: EdgeInsets.all(18),
                            child: Text(
                              'Друг пока не открыл вам историю тренировок.',
                            ),
                          ),
                        ),
                      const SizedBox(height: 24),
                      TextButton.icon(
                        onPressed: _busy ? null : _remove,
                        icon: const Icon(Icons.person_remove_outlined),
                        label: const Text('Удалить из друзей'),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 8),
          Text(value, style: Theme.of(context).textTheme.headlineMedium),
        ],
      ),
    ),
  );
}
