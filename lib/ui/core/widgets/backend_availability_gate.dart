import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/theme/app_colors.dart';
import '../../../data/services/backend_session.dart';
import '../../../telegram/telegram_launch_data.dart';
import '../../features/home/view_models/home_view_model.dart';
import '../../features/progress/view_models/progress_view_model.dart';
import '../../features/schedule/view_models/schedule_view_model.dart';
import '../../features/workout/view_models/workout_view_model.dart';

class BackendAvailabilityGate extends StatelessWidget {
  const BackendAvailabilityGate({super.key, required this.child});

  final Widget child;

  Future<bool> _retry(BuildContext context) async {
    final session = context.read<BackendSession>();
    final telegram = context.read<TelegramLaunchData>();

    if (!await session.retryUnavailable(telegram) || !context.mounted) {
      return false;
    }
    final home = context.read<HomeViewModel>();
    final schedule = context.read<ScheduleViewModel>();
    final workout = context.read<WorkoutViewModel>();
    final progress = context.read<ProgressViewModel>();
    await Future.wait([
      if (home.status != HomeStatus.loading) home.loadOverview(),
      if (!schedule.isLoading) schedule.load(),
      if (workout.historyStatus != WorkoutHistoryStatus.loading)
        workout.loadHistory(),
      if (progress.status != ProgressStatus.loading) progress.load(),
    ]);
    return !session.isServerUnavailable;
  }

  @override
  Widget build(BuildContext context) {
    final unavailable = context.select<BackendSession, bool>(
      (session) => session.isServerUnavailable,
    );
    return Stack(
      children: [
        TickerMode(
          enabled: !unavailable,
          child: Offstage(offstage: unavailable, child: child),
        ),
        if (unavailable)
          Positioned.fill(
            child: BackendMaintenanceScreen(onRetry: () => _retry(context)),
          ),
      ],
    );
  }
}

class BackendMaintenanceScreen extends StatefulWidget {
  const BackendMaintenanceScreen({super.key, required this.onRetry});

  final Future<bool> Function() onRetry;

  @override
  State<BackendMaintenanceScreen> createState() =>
      _BackendMaintenanceScreenState();
}

class _BackendMaintenanceScreenState extends State<BackendMaintenanceScreen> {
  bool _retrying = false;
  bool _retryFailed = false;

  Future<void> _retry() async {
    if (_retrying) return;
    setState(() {
      _retrying = true;
      _retryFailed = false;
    });
    var restored = false;
    try {
      restored = await widget.onRetry();
    } on Object {
      restored = false;
    }
    if (!mounted) return;
    setState(() {
      _retrying = false;
      _retryFailed = !restored;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const _ServerUpdateIllustration(),
                  const SizedBox(height: 36),
                  Text(
                    'Приложение обновляется',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Сервер временно недоступен. Подождите немного и попробуйте снова.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: 220,
                    child: FilledButton.icon(
                      onPressed: _retrying ? null : _retry,
                      icon: _retrying
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.background,
                              ),
                            )
                          : const Icon(Icons.refresh_rounded),
                      label: Text(_retrying ? 'Проверяем…' : 'Повторить'),
                    ),
                  ),
                  if (_retryFailed) ...[
                    const SizedBox(height: 14),
                    Text(
                      'Сервер пока недоступен. Попробуйте ещё раз позже.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A small vector illustration in the existing dark/lime design language.
class _ServerUpdateIllustration extends StatelessWidget {
  const _ServerUpdateIllustration();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Сервер обновляется',
      child: SizedBox(
        width: 252,
        height: 196,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 188,
              height: 188,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface,
              ),
            ),
            Container(
              width: 178,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surfaceRaised,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: AppColors.outline, width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x443E4700),
                    blurRadius: 28,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _ServerUnit(active: true),
                  SizedBox(height: 10),
                  _ServerUnit(active: false),
                  SizedBox(height: 10),
                  _ServerUnit(active: false),
                ],
              ),
            ),
            Positioned(
              right: 17,
              bottom: 10,
              child: Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: AppColors.lime,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.sync_rounded,
                  size: 34,
                  color: AppColors.background,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServerUnit extends StatelessWidget {
  const _ServerUnit({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.outline),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active ? AppColors.lime : AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 62,
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.outline,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ],
      ),
    );
  }
}
