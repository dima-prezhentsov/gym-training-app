import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import 'progress_service.dart';

class ProgressEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<ProgressOverviewDto> get(
    Session session, {
    required String period,
    required int utcOffsetMinutes,
  }) => ProgressService.forUser(
    session,
    session.authenticated!.authUserId,
    period: period,
    utcOffsetMinutes: utcOffsetMinutes,
  );
}
