import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import 'telegram_auth_service.dart';

class TelegramAuthEndpoint extends Endpoint {
  final TelegramAuthService _service = TelegramAuthService();

  Future<AuthSuccess> authenticate(Session session, String initData) {
    return _service.authenticate(session, initData);
  }
}
