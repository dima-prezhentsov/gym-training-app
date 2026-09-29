import 'dart:async';

import 'package:backend_client/backend_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_training_app/app/app.dart';
import 'package:gym_training_app/data/services/backend_session.dart';
import 'package:gym_training_app/telegram/telegram_launch_data.dart';
import 'package:gym_training_app/ui/core/widgets/backend_availability_gate.dart';

void main() {
  testWidgets('shows update screen and retries without launching app again', (
    tester,
  ) async {
    final probe = Completer<void>();
    final session = BackendSession.test(
      (_) async => true,
      availabilityProbe: () => probe.future,
    );
    await tester.pumpWidget(
      GymTrainingApp(
        telegram: const TelegramLaunchData.browser(),
        backendSession: session,
      ),
    );
    await tester.pumpAndSettle();

    session.reportRequestFailure(
      const ServerpodClientException('Service unavailable', 503),
    );
    await tester.pumpAndSettle();
    expect(find.text('Приложение обновляется'), findsOneWidget);
    expect(find.text('Повторить'), findsOneWidget);
    expect(find.byIcon(Icons.sync_rounded), findsOneWidget);

    await tester.tap(find.text('Повторить'));
    await tester.pump();
    expect(find.text('Проверяем…'), findsOneWidget);
    probe.complete();
    await tester.pumpAndSettle();
    expect(find.text('Приложение обновляется'), findsNothing);
    expect(find.text('Следующая тренировка'), findsOneWidget);
  });

  testWidgets('keeps the update screen when retry still fails', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: BackendMaintenanceScreen(onRetry: () async => false)),
    );

    await tester.tap(find.text('Повторить'));
    await tester.pumpAndSettle();

    expect(find.text('Приложение обновляется'), findsOneWidget);
    expect(
      find.text('Сервер пока недоступен. Попробуйте ещё раз позже.'),
      findsOneWidget,
    );
    expect(find.text('Повторить'), findsOneWidget);
  });

  testWidgets('recovers when authentication initially receives 503', (
    tester,
  ) async {
    var attempts = 0;
    final session = BackendSession.test((_) async {
      attempts++;
      if (attempts == 1) {
        throw const ServerpodClientException('Service unavailable', 503);
      }
      return true;
    });
    await tester.pumpWidget(
      GymTrainingApp(
        telegram: const TelegramLaunchData(
          isTelegram: true,
          platform: 'ios',
          version: '10.0',
          isDarkMode: true,
          initData: 'test-init-data',
        ),
        backendSession: session,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Приложение обновляется'), findsOneWidget);
    await tester.tap(find.text('Повторить'));
    await tester.pumpAndSettle();

    expect(attempts, 2);
    expect(find.text('Приложение обновляется'), findsNothing);
    expect(find.text('Следующая тренировка'), findsOneWidget);
  });
}
