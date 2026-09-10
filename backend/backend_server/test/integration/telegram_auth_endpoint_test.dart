import 'dart:convert';

import 'package:backend_server/src/generated/protocol.dart';
import 'package:crypto/crypto.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  const botToken = '123456:integration-test-token';

  withServerpod('Given Telegram auth endpoint', (sessionBuilder, endpoints) {
    setUp(() async {
      final session = sessionBuilder.build();
      session.passwords['telegramBotToken'] = botToken;
      await session.close();
      AuthServices.set(
        tokenManagerBuilders: [
          JwtConfig(
            algorithm: JwtAlgorithm.hmacSha512(
              SecretKey('integration-test-jwt-private-key'),
            ),
            refreshTokenHashPepper: 'integration-test-refresh-pepper',
          ),
        ],
      );
    });

    test('reuses the same auth user for the same Telegram id', () async {
      final first = await endpoints.telegramAuth.authenticate(
        sessionBuilder,
        _signedInitData(
          botToken: botToken,
          user: {
            'id': 987654321,
            'first_name': 'Dima',
            'username': 'before',
          },
        ),
      );
      final second = await endpoints.telegramAuth.authenticate(
        sessionBuilder,
        _signedInitData(
          botToken: botToken,
          user: {
            'id': 987654321,
            'first_name': 'Dima',
            'username': 'after',
          },
        ),
      );

      expect(second.authUserId, first.authUserId);
      expect(first.authStrategy, 'jwt');

      final session = sessionBuilder.build();
      final accounts = await TelegramAccount.db.find(session);
      await session.close();
      expect(accounts, hasLength(1));
      expect(accounts.single.username, 'after');
    });

    test('rejects launch data with an invalid signature', () async {
      final initData = _signedInitData(
        botToken: botToken,
        user: {'id': 1, 'first_name': 'Before'},
      ).replaceFirst('Before', 'After');

      expect(
        () => endpoints.telegramAuth.authenticate(sessionBuilder, initData),
        throwsA(
          isA<TelegramAuthenticationException>().having(
            (error) => error.reason,
            'reason',
            'invalidSignature',
          ),
        ),
      );
    });
  });
}

String _signedInitData({
  required String botToken,
  required Map<String, Object?> user,
}) {
  final parameters = {
    'auth_date': '${DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000}',
    'query_id': 'integration-test-query',
    'user': jsonEncode(user),
  };
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
