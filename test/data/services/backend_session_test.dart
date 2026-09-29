import 'dart:async';

import 'package:backend_client/backend_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_training_app/data/services/backend_session.dart';
import 'package:gym_training_app/telegram/telegram_launch_data.dart';

void main() {
  const telegram = TelegramLaunchData(
    isTelegram: true,
    platform: 'ios',
    version: '9.0',
    isDarkMode: true,
    initData: 'query_id=test',
  );

  test('retries authentication after a failed initialization', () async {
    var attempts = 0;
    final session = BackendSession.test((_) async {
      attempts += 1;
      if (attempts == 1) throw StateError('temporary failure');
      return true;
    });

    await session.initialize(telegram);
    expect(session.status, BackendSessionStatus.failed);

    await session.retry(telegram);

    expect(attempts, 2);
    expect(session.status, BackendSessionStatus.authenticated);
    expect(session.error, isNull);
  });

  test('recognizes temporary backend failures without hiding other errors', () {
    expect(
      isTemporaryBackendFailure(const ServerpodClientException('busy', 503)),
      isTrue,
    );
    expect(
      isTemporaryBackendFailure(const ServerpodClientException('gateway', 502)),
      isTrue,
    );
    expect(
      isTemporaryBackendFailure(const ServerpodClientException('offline', -1)),
      isTrue,
    );
    expect(isTemporaryBackendFailure(TimeoutException('timeout')), isTrue);
    expect(
      isTemporaryBackendFailure(
        const ServerpodClientException('unauthorized', 401),
      ),
      isFalse,
    );
    expect(
      isTemporaryBackendFailure(const ServerpodClientException('bug', 500)),
      isFalse,
    );
  });

  test(
    'retry probes an authenticated backend before dismissing outage',
    () async {
      var probes = 0;
      final session = BackendSession.test(
        (_) async => true,
        availabilityProbe: () async {
          probes++;
          if (probes == 1) {
            throw const ServerpodClientException('busy', 503);
          }
        },
      );
      await session.initialize(telegram);
      session.reportRequestFailure(const ServerpodClientException('busy', 503));

      expect(await session.retryUnavailable(telegram), isFalse);
      expect(session.isServerUnavailable, isTrue);
      expect(await session.retryUnavailable(telegram), isTrue);
      expect(session.isServerUnavailable, isFalse);
      expect(probes, 2);
    },
  );

  test('does not start another authentication while one is running', () async {
    var attempts = 0;
    final result = Completer<bool>();
    final session = BackendSession.test((_) {
      attempts += 1;
      return result.future;
    });

    final initialization = session.initialize(telegram);
    final retry = session.retry(telegram);

    expect(attempts, 1);
    result.complete(true);
    await Future.wait([initialization, retry]);
    expect(session.status, BackendSessionStatus.authenticated);
  });

  test(
    'does not authenticate again when the session is already active',
    () async {
      var attempts = 0;
      final session = BackendSession.test((_) async {
        attempts += 1;
        return true;
      });

      await session.initialize(telegram);
      final authenticated = await session.ensureAuthenticated(telegram);

      expect(authenticated, isTrue);
      expect(attempts, 1);
    },
  );

  test('restores authentication only after a failed session', () async {
    var attempts = 0;
    final session = BackendSession.test((_) async {
      attempts += 1;
      if (attempts == 1) throw StateError('temporary failure');
      return true;
    });

    await session.initialize(telegram);
    final authenticated = await session.ensureAuthenticated(telegram);

    expect(authenticated, isTrue);
    expect(attempts, 2);
  });

  test(
    'authenticates a Telegram launch without restoring the stored session',
    () async {
      var restoreAttempts = 0;
      var authenticatedInitData = '';
      var authenticated = false;
      final session = BackendSession.testClient(
        restoreSession: () async {
          restoreAttempts += 1;
          throw TimeoutException('Stored session refresh timed out');
        },
        authenticateTelegram: (initData) async {
          authenticatedInitData = initData;
          authenticated = true;
        },
        isAuthenticated: () => authenticated,
      );

      await session.initialize(telegram);

      expect(restoreAttempts, 0);
      expect(authenticatedInitData, telegram.initData);
      expect(session.status, BackendSessionStatus.authenticated);
    },
  );

  test('restores the stored session for a browser launch', () async {
    var restoreAttempts = 0;
    var telegramAuthAttempts = 0;
    var authenticated = false;
    final session = BackendSession.testClient(
      restoreSession: () async {
        restoreAttempts += 1;
        authenticated = true;
      },
      authenticateTelegram: (_) async {
        telegramAuthAttempts += 1;
      },
      isAuthenticated: () => authenticated,
    );

    await session.initialize(const TelegramLaunchData.browser());

    expect(restoreAttempts, 1);
    expect(telegramAuthAttempts, 0);
    expect(session.status, BackendSessionStatus.authenticated);
  });
}
