import 'dart:convert';

import 'package:crypto/crypto.dart';

/// A Telegram user read from cryptographically verified Mini App launch data.
class VerifiedTelegramUser {
  const VerifiedTelegramUser({
    required this.id,
    required this.firstName,
    this.lastName,
    this.username,
    this.languageCode,
  });

  final int id;
  final String firstName;
  final String? lastName;
  final String? username;
  final String? languageCode;

  String get fullName => [
    firstName,
    lastName,
  ].whereType<String>().where((part) => part.isNotEmpty).join(' ');
}

enum TelegramInitDataFailure {
  malformed,
  invalidSignature,
  expired,
}

class TelegramInitDataException implements Exception {
  const TelegramInitDataException(this.failure);

  final TelegramInitDataFailure failure;
}

/// Validates Telegram Mini App `initData` according to Telegram's HMAC scheme.
class TelegramInitDataValidator {
  const TelegramInitDataValidator({
    required this.botToken,
    this.maxAge = const Duration(hours: 24),
    this.allowedClockSkew = const Duration(seconds: 30),
  });

  final String botToken;
  final Duration maxAge;
  final Duration allowedClockSkew;

  VerifiedTelegramUser validate(
    String initData, {
    DateTime? now,
  }) {
    final parameters = _parseParameters(initData);
    final receivedHash = parameters.remove('hash');
    if (receivedHash == null ||
        !RegExp(r'^[0-9a-fA-F]{64}$').hasMatch(receivedHash)) {
      throw const TelegramInitDataException(TelegramInitDataFailure.malformed);
    }

    final dataCheckString =
        (parameters.entries.toList()
              ..sort((left, right) => left.key.compareTo(right.key)))
            .map((entry) => '${entry.key}=${entry.value}')
            .join('\n');
    final secretKey = Hmac(
      sha256,
      utf8.encode('WebAppData'),
    ).convert(utf8.encode(botToken)).bytes;
    final expectedHash = Hmac(
      sha256,
      secretKey,
    ).convert(utf8.encode(dataCheckString)).toString();
    if (!_constantTimeEquals(receivedHash.toLowerCase(), expectedHash)) {
      throw const TelegramInitDataException(
        TelegramInitDataFailure.invalidSignature,
      );
    }

    _validateAge(parameters['auth_date'], now ?? DateTime.now().toUtc());
    return _parseUser(parameters['user']);
  }

  Map<String, String> _parseParameters(String initData) {
    if (initData.isEmpty) {
      throw const TelegramInitDataException(TelegramInitDataFailure.malformed);
    }

    try {
      final allParameters = Uri(query: initData).queryParametersAll;
      if (allParameters.values.any((values) => values.length != 1)) {
        throw const TelegramInitDataException(
          TelegramInitDataFailure.malformed,
        );
      }
      return {
        for (final entry in allParameters.entries)
          entry.key: entry.value.single,
      };
    } on TelegramInitDataException {
      rethrow;
    } on Object {
      throw const TelegramInitDataException(TelegramInitDataFailure.malformed);
    }
  }

  void _validateAge(String? authDateValue, DateTime now) {
    final authDateSeconds = int.tryParse(authDateValue ?? '');
    if (authDateSeconds == null) {
      throw const TelegramInitDataException(TelegramInitDataFailure.malformed);
    }

    final authDate = DateTime.fromMillisecondsSinceEpoch(
      authDateSeconds * Duration.millisecondsPerSecond,
      isUtc: true,
    );
    if (authDate.isAfter(now.add(allowedClockSkew)) ||
        now.difference(authDate) > maxAge) {
      throw const TelegramInitDataException(TelegramInitDataFailure.expired);
    }
  }

  VerifiedTelegramUser _parseUser(String? userValue) {
    if (userValue == null) {
      throw const TelegramInitDataException(TelegramInitDataFailure.malformed);
    }

    try {
      final user = jsonDecode(userValue);
      if (user is! Map<String, dynamic>) {
        throw const TelegramInitDataException(
          TelegramInitDataFailure.malformed,
        );
      }
      final id = user['id'];
      final firstName = user['first_name'];
      if (id is! int || firstName is! String || firstName.isEmpty) {
        throw const TelegramInitDataException(
          TelegramInitDataFailure.malformed,
        );
      }
      return VerifiedTelegramUser(
        id: id,
        firstName: firstName,
        lastName: _optionalString(user['last_name']),
        username: _optionalString(user['username']),
        languageCode: _optionalString(user['language_code']),
      );
    } on TelegramInitDataException {
      rethrow;
    } on Object {
      throw const TelegramInitDataException(TelegramInitDataFailure.malformed);
    }
  }

  String? _optionalString(Object? value) => value is String ? value : null;

  bool _constantTimeEquals(String left, String right) {
    if (left.length != right.length) return false;
    var difference = 0;
    for (var index = 0; index < left.length; index++) {
      difference |= left.codeUnitAt(index) ^ right.codeUnitAt(index);
    }
    return difference == 0;
  }
}
