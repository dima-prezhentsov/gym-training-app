import 'dart:async';

import 'package:backend_client/backend_client.dart';
import 'package:flutter/foundation.dart';
import 'package:serverpod_auth_core_flutter/serverpod_auth_core_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import '../../telegram/telegram_launch_data.dart';

enum BackendSessionStatus { disabled, connecting, authenticated, failed }

typedef BackendAuthenticator =
    Future<bool> Function(TelegramLaunchData telegram);
typedef BackendSessionRestorer = Future<void> Function();
typedef TelegramSessionAuthenticator = Future<void> Function(String initData);
typedef BackendAuthenticationState = bool Function();

/// Owns the Serverpod client and authenticates Telegram Mini App launches.
class BackendSession extends ChangeNotifier {
  BackendSession._(this.client)
    : _authenticator = null,
      _availabilityProbe = null;

  @visibleForTesting
  BackendSession.test(
    BackendAuthenticator authenticator, {
    Future<void> Function()? availabilityProbe,
  }) : client = null,
       _authenticator = authenticator,
       _availabilityProbe = availabilityProbe;

  @visibleForTesting
  BackendSession.testClient({
    required BackendSessionRestorer restoreSession,
    required TelegramSessionAuthenticator authenticateTelegram,
    required BackendAuthenticationState isAuthenticated,
  }) : client = null,
       _availabilityProbe = null,
       _authenticator = ((telegram) => _authenticateWithClient(
         telegram: telegram,
         restoreSession: restoreSession,
         authenticateTelegram: authenticateTelegram,
         isAuthenticated: isAuthenticated,
       ));

  factory BackendSession.fromEnvironment() {
    const configuredUrl = String.fromEnvironment('BACKEND_URL');
    if (configuredUrl.isEmpty) return BackendSession._(null);

    final serverUrl = configuredUrl.endsWith('/')
        ? configuredUrl
        : '$configuredUrl/';
    late final BackendSession session;
    final client =
        Client(
            serverUrl,
            onFailedCall: (_, error, _) => session.reportRequestFailure(error),
          )
          ..connectivityMonitor = FlutterConnectivityMonitor()
          ..authSessionManager = FlutterAuthSessionManager();
    session = BackendSession._(client);
    return session;
  }

  final Client? client;
  final BackendAuthenticator? _authenticator;
  final Future<void> Function()? _availabilityProbe;
  BackendSessionStatus _status = BackendSessionStatus.disabled;
  bool _isServerUnavailable = false;
  Object? _error;
  Future<void>? _initialization;

  BackendSessionStatus get status => _status;
  bool get isServerUnavailable => _isServerUnavailable;
  Object? get error => _error;
  bool get isAuthenticated => _status == BackendSessionStatus.authenticated;
  bool get isConfigured => client != null || _authenticator != null;
  Future<void> get ready => _initialization ?? Future.value();

  Future<void> initialize(TelegramLaunchData telegram) {
    return _initialization ??= _initialize(telegram);
  }

  Future<void> retry(TelegramLaunchData telegram) {
    if (_status == BackendSessionStatus.connecting) return ready;
    _initialization = null;
    return initialize(telegram);
  }

  Future<bool> ensureAuthenticated(TelegramLaunchData telegram) async {
    if (isAuthenticated) return true;
    if (!isConfigured) return false;

    if (_status == BackendSessionStatus.connecting) {
      await ready;
      return isAuthenticated;
    }

    await retry(telegram);
    return isAuthenticated;
  }

  /// Called for every Serverpod request, including calls whose errors are
  /// swallowed by a view model and shown as local page failures.
  void reportRequestFailure(Object error) {
    if (!isTemporaryBackendFailure(error) || _isServerUnavailable) return;
    _isServerUnavailable = true;
    notifyListeners();
  }

  void reportRequestSuccess() {
    if (!_isServerUnavailable) return;
    _isServerUnavailable = false;
    notifyListeners();
  }

  /// Rechecks the backend even if the current auth token is still valid.
  Future<bool> retryUnavailable(TelegramLaunchData telegram) async {
    if (!isAuthenticated) {
      await retry(telegram);
      if (!isAuthenticated) return false;
    }
    if (!_isServerUnavailable) return true;
    try {
      if (client case final activeClient?) {
        await activeClient.greeting.hello('health');
      } else if (_availabilityProbe case final probe?) {
        await probe();
      } else {
        await retry(telegram);
      }
      if (isAuthenticated) reportRequestSuccess();
    } on Object catch (error) {
      reportRequestFailure(error);
      return false;
    }
    return isAuthenticated && !_isServerUnavailable;
  }

  Future<void> _initialize(TelegramLaunchData telegram) async {
    final client = this.client;
    final authenticator = _authenticator;
    if (client == null && authenticator == null) return;

    _status = BackendSessionStatus.connecting;
    notifyListeners();
    try {
      final isAuthenticated = authenticator != null
          ? await authenticator(telegram)
          : await _authenticate(client!, telegram);
      _status = isAuthenticated
          ? BackendSessionStatus.authenticated
          : BackendSessionStatus.disabled;
      if (isAuthenticated) reportRequestSuccess();
      _error = null;
    } on Object catch (error) {
      reportRequestFailure(error);
      _status = BackendSessionStatus.failed;
      _error = error;
    }
    notifyListeners();
  }

  Future<bool> _authenticate(Client client, TelegramLaunchData telegram) async {
    return _authenticateWithClient(
      telegram: telegram,
      restoreSession: () async {
        await client.auth.initialize();
      },
      authenticateTelegram: (initData) async {
        final authSuccess = await client.telegramAuth.authenticate(
          initData,
          utcOffsetMinutes: DateTime.now().timeZoneOffset.inMinutes,
        );
        await client.auth.updateSignedInUser(authSuccess);
      },
      isAuthenticated: () => client.auth.isAuthenticated,
    );
  }
}

bool isTemporaryBackendFailure(Object error) =>
    error is TimeoutException ||
    error is ServerpodClientException &&
        const {-1, 502, 503, 504}.contains(error.statusCode);

Future<bool> _authenticateWithClient({
  required TelegramLaunchData telegram,
  required BackendSessionRestorer restoreSession,
  required TelegramSessionAuthenticator authenticateTelegram,
  required BackendAuthenticationState isAuthenticated,
}) async {
  if (telegram.isTelegram) {
    if (telegram.initData.isEmpty) {
      throw StateError('Telegram initData is empty');
    }
    await authenticateTelegram(telegram.initData);
  } else {
    await restoreSession();
  }
  return isAuthenticated();
}
