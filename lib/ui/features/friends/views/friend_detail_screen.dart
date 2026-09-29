import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../data/repositories/friend_error_message.dart';
import '../../../../data/repositories/friends_repository.dart';
import '../../../../domain/models/friend_connection.dart';
import '../../../../domain/models/progress_overview.dart';
import '../../../../domain/models/workout_record.dart';
import '../../../core/utils/app_error_feedback.dart';

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

  Future<void> _setSharing({bool? stats, bool? history}) async {
    final friend = _friend;
    if (friend == null || _busy) return;
    setState(() => _busy = true);
    try {
      final updated = await context.read<FriendsRepository>().setSharing(
        friend.userId,
        stats: stats ?? friend.sharesStats,
        history: history ?? friend.sharesHistory,
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
                          _ExerciseChart(
                            progress: progress,
                            selectedId: _selectedExerciseId,
                            onSelect: (id) =>
                                setState(() => _selectedExerciseId = id),
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
                          for (final record in history)
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
                            )
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

class _ExerciseChart extends StatelessWidget {
  const _ExerciseChart({
    required this.progress,
    required this.selectedId,
    required this.onSelect,
  });
  final ProgressOverview progress;
  final String? selectedId;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final exercise = progress.exercises.firstWhere(
      (item) => item.exerciseId == selectedId,
      orElse: () => progress.exercises.first,
    );
    final spots = [
      for (final (index, point) in exercise.points.indexed)
        FlSpot(index.toDouble(), point.maxWeightKg),
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Рабочий вес', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            DropdownButton<String>(
              value: exercise.exerciseId,
              isExpanded: true,
              items: [
                for (final item in progress.exercises)
                  DropdownMenuItem(
                    value: item.exerciseId,
                    child: Text(item.name),
                  ),
              ],
              onChanged: (value) {
                if (value != null) onSelect(value);
              },
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 180,
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: spots.length <= 1 ? 1 : (spots.length - 1).toDouble(),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: spots.length <= 5
                            ? 1
                            : (spots.length / 4).ceilToDouble(),
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 ||
                              index >= exercise.points.length ||
                              value != index) {
                            return const SizedBox.shrink();
                          }
                          final date = exercise.points[index].date;
                          return Text(
                            '${date.day}.${date.month}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.textSecondary,
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 42,
                        getTitlesWidget: (value, meta) => Text(
                          '${value.toInt()} кг',
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: false,
                      color: AppColors.lime,
                      barWidth: 3,
                      dotData: const FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Дата тренировки → · максимальный рабочий вес, кг',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
