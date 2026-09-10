import 'dart:convert';

import 'package:backend_server/src/auth/telegram_init_data_validator.dart';
import 'package:crypto/crypto.dart';
import 'package:test/test.dart';

void main() {
  const botToken = '123456:local-test-token';
  final now = DateTime.utc(2026, 9, 10, 12);

  group('TelegramInitDataValidator', () {
    test('accepts signed fresh launch data and returns its user', () {
      final initData = _signedInitData(
        botToken: botToken,
        authDate: now,
        user: {
          'id': 987654321,
          'first_name': 'Dima',
          'last_name': 'P',
          'username': 'dima_p',
          'language_code': 'ru',
        },
      );

      final user = const TelegramInitDataValidator(
        botToken: botToken,
      ).validate(initData, now: now);

      expect(user.id, 987654321);
      expect(user.fullName, 'Dima P');
      expect(user.username, 'dima_p');
      expect(user.languageCode, 'ru');
    });

    test('rejects data changed after it was signed', () {
      final initData = _signedInitData(
        botToken: botToken,
        authDate: now,
        user: {'id': 1, 'first_name': 'Before'},
      ).replaceFirst('Before', 'After');

      expect(
        () => const TelegramInitDataValidator(
          botToken: botToken,
        ).validate(initData, now: now),
        throwsA(
          isA<TelegramInitDataException>().having(
            (error) => error.failure,
            'failure',
            TelegramInitDataFailure.invalidSignature,
          ),
        ),
      );
    });

    test('rejects otherwise valid data older than the configured limit', () {
      final initData = _signedInitData(
        botToken: botToken,
        authDate: now.subtract(const Duration(hours: 25)),
        user: {'id': 1, 'first_name': 'Dima'},
      );

      expect(
        () => const TelegramInitDataValidator(
          botToken: botToken,
        ).validate(initData, now: now),
        throwsA(
          isA<TelegramInitDataException>().having(
            (error) => error.failure,
            'failure',
            TelegramInitDataFailure.expired,
          ),
        ),
      );
    });

    test('rejects duplicate parameters', () {
      final initData = _signedInitData(
        botToken: botToken,
        authDate: now,
        user: {'id': 1, 'first_name': 'Dima'},
      );

      expect(
        () => const TelegramInitDataValidator(
          botToken: botToken,
        ).validate('$initData&auth_date=1', now: now),
        throwsA(
          isA<TelegramInitDataException>().having(
            (error) => error.failure,
            'failure',
            TelegramInitDataFailure.malformed,
          ),
        ),
      );
    });

    test('rejects a signed payload without a user', () {
      final initData = _signedParameters(
        botToken: botToken,
        parameters: {
          'auth_date': '${now.millisecondsSinceEpoch ~/ 1000}',
          'query_id': 'test-query',
        },
      );

      expect(
        () => const TelegramInitDataValidator(
          botToken: botToken,
        ).validate(initData, now: now),
        throwsA(
          isA<TelegramInitDataException>().having(
            (error) => error.failure,
            'failure',
            TelegramInitDataFailure.malformed,
          ),
        ),
      );
    });
  });
}

String _signedInitData({
  required String botToken,
  required DateTime authDate,
  required Map<String, Object?> user,
}) {
  return _signedParameters(
    botToken: botToken,
    parameters: {
      'auth_date': '${authDate.millisecondsSinceEpoch ~/ 1000}',
      'query_id': 'test-query',
      'user': jsonEncode(user),
    },
  );
}

String _signedParameters({
  required String botToken,
  required Map<String, String> parameters,
}) {
  final sortedEntries = parameters.entries.toList()
    ..sort((left, right) => left.key.compareTo(right.key));
  final dataCheckString = sortedEntries
      .map((entry) => '${entry.key}=${entry.value}')
      .join('\n');
  final secretKey = Hmac(
    sha256,
    utf8.encode('WebAppData'),
  ).convert(utf8.encode(botToken)).bytes;
  final hash = Hmac(
    sha256,
    secretKey,
  ).convert(utf8.encode(dataCheckString)).toString();
  return Uri(
    queryParameters: {
      ...parameters,
      'hash': hash,
    },
  ).query;
}
