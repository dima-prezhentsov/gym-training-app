import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../ui/core/widgets/app_shell.dart';
import '../../ui/features/home/views/home_screen.dart';
import '../../ui/features/friends/views/friend_detail_screen.dart';
import '../../ui/features/friends/views/friends_screen.dart';
import '../../ui/features/profile/views/profile_screen.dart';
import '../../ui/features/progress/views/progress_screen.dart';
import '../../ui/features/schedule/views/schedule_screen.dart';
import '../../ui/features/workout/views/active_workout_screen.dart';

class AppRouter {
  AppRouter(this.config);

  final GoRouter config;
}

AppRouter createAppRouter({String? startParam}) {
  final launchTarget =
      startParam != null &&
          startParam.startsWith('invite_') &&
          startParam.length > 'invite_'.length
      ? '/friends'
      : '/home';
  return AppRouter(
    GoRouter(
      initialLocation: launchTarget,
      redirect: (context, state) {
        final path = state.uri.path;
        final isTelegramLaunchPath = path.startsWith('/tgWebApp');
        return path == '/' || isTelegramLaunchPath ? launchTarget : null;
      },
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return AppShell(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/home',
                  builder: (context, state) => const HomeScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/schedule',
                  builder: (context, state) => const ScheduleScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/history',
                  builder: (context, state) => ProgressScreen(
                    showHistory:
                        state.uri.queryParameters['section'] == 'history',
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/profile',
                  builder: (context, state) => const ProfileScreen(),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/friends',
          builder: (context, state) => const FriendsScreen(),
          routes: [
            GoRoute(
              path: ':userId',
              builder: (context, state) =>
                  FriendDetailScreen(userId: state.pathParameters['userId']!),
            ),
          ],
        ),
        GoRoute(
          path: '/workout/:dayId',
          builder: (context, state) => ActiveWorkoutScreen(
            trainingDayId: state.pathParameters['dayId']!,
          ),
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Не удалось открыть экран\n${state.uri}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ),
    ),
  );
}
