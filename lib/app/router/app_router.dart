import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../ui/core/widgets/app_shell.dart';
import '../../ui/features/history/views/history_screen.dart';
import '../../ui/features/home/views/home_screen.dart';
import '../../ui/features/profile/views/profile_screen.dart';
import '../../ui/features/schedule/views/schedule_screen.dart';

class AppRouter {
  AppRouter(this.config);

  final GoRouter config;
}

AppRouter createAppRouter() {
  return AppRouter(
    GoRouter(
      initialLocation: '/home',
      redirect: (context, state) {
        final path = state.uri.path;
        final isTelegramLaunchPath = path.startsWith('/tgWebApp');
        return path == '/' || isTelegramLaunchPath ? '/home' : null;
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
                  builder: (context, state) => const HistoryScreen(),
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
