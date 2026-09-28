import 'package:backend_client/backend_client.dart';
import 'package:flutter/foundation.dart';
import 'package:serverpod_auth_core_flutter/serverpod_auth_core_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import '../../telegram/telegram_launch_data.dart';

enum BackendSessionStatus { disabled, connecting, authenticated, failed }

typedef BackendAuthenticator =
    Future<bool> Function(TelegramLaunchData telegram);

/// Owns the Serverpod client and authenticates Telegram Mini App launches.
class BackendSession extends ChangeNotifier {
  BackendSession._(this.client) : _authenticator = null;

  @visibleForTesting
  BackendSession.test(BackendAuthenticator authenticator)
    : client = null,
      _authenticator = authenticator;

  factory BackendSession.fromEnvironment() {
    const configuredUrl = String.fromEnvironment('BACKEND_URL');
    if (configuredUrl.isEmpty) return BackendSession._(null);

    final serverUrl = configuredUrl.endsWith('/')
        ? configuredUrl
        : '$configuredUrl/';
    final client = Client(serverUrl)
      ..connectivityMonitor = FlutterConnectivityMonitor()
      ..authSessionManager = FlutterAuthSessionManager();
    return BackendSession._(client);
  }

  final Client? client;
  final BackendAuthenticator? _authenticator;
  BackendSessionStatus _status = BackendSessionStatus.disabled;
  Object? _error;
  Future<void>? _initialization;

  BackendSessionStatus get status => _status;
  Object? get error => _error;
  bool get isAuthenticated => _status == BackendSessionStatus.authenticated;
  Future<void> get ready => _initialization ?? Future.value();

  Future<void> initialize(TelegramLaunchData telegram) {
    return _initialization ??= _initialize(telegram);
  }

  Future<void> retry(TelegramLaunchData telegram) {
    if (_status == BackendSessionStatus.connecting) return ready;
    _initialization = null;
    return initialize(telegram);
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
      _error = null;
    } on Object catch (error) {
      _status = BackendSessionStatus.failed;
      _error = error;
    }
    notifyListeners();
  }

  Future<bool> _authenticate(Client client, TelegramLaunchData telegram) async {
    await client.auth.initialize();
    if (telegram.isTelegram) {
      if (telegram.initData.isEmpty) {
        throw StateError('Telegram initData is empty');
      }
      final authSuccess = await client.telegramAuth.authenticate(
        telegram.initData,
      );
      await client.auth.updateSignedInUser(authSuccess);
    }
    return client.auth.isAuthenticated;
  }
}
