import 'package:backend_client/backend_client.dart';
import 'package:flutter/foundation.dart';
import 'package:serverpod_auth_core_flutter/serverpod_auth_core_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import '../../telegram/telegram_launch_data.dart';

enum BackendSessionStatus { disabled, connecting, authenticated, failed }

/// Owns the Serverpod client and authenticates Telegram Mini App launches.
class BackendSession extends ChangeNotifier {
  BackendSession._(this.client);

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
  BackendSessionStatus _status = BackendSessionStatus.disabled;
  Object? _error;
  Future<void>? _initialization;

  BackendSessionStatus get status => _status;
  Object? get error => _error;
  bool get isAuthenticated => _status == BackendSessionStatus.authenticated;

  Future<void> initialize(TelegramLaunchData telegram) {
    return _initialization ??= _initialize(telegram);
  }

  Future<void> _initialize(TelegramLaunchData telegram) async {
    final client = this.client;
    if (client == null) return;

    _status = BackendSessionStatus.connecting;
    notifyListeners();
    try {
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
      _status = client.auth.isAuthenticated
          ? BackendSessionStatus.authenticated
          : BackendSessionStatus.disabled;
      _error = null;
    } on Object catch (error) {
      _status = BackendSessionStatus.failed;
      _error = error;
    }
    notifyListeners();
  }
}
