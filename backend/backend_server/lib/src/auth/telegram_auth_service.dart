import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import 'telegram_init_data_validator.dart';

class TelegramAuthService {
  static const authenticationMethod = 'telegram';

  Future<AuthSuccess> authenticate(
    Session session,
    String initData, {
    int? utcOffsetMinutes,
  }) async {
    if (utcOffsetMinutes != null &&
        (utcOffsetMinutes < -720 || utcOffsetMinutes > 840)) {
      throw TelegramAuthenticationException(reason: 'invalidTimeZone');
    }
    final botToken = session.passwords['telegramBotToken'];
    if (botToken == null || botToken.isEmpty) {
      session.log(
        'TELEGRAM_BOT_TOKEN is not configured',
        level: LogLevel.error,
      );
      throw TelegramAuthenticationException(reason: 'configuration');
    }

    final VerifiedTelegramUser telegramUser;
    try {
      telegramUser = TelegramInitDataValidator(
        botToken: botToken,
      ).validate(initData);
    } on TelegramInitDataException catch (error) {
      throw TelegramAuthenticationException(reason: error.failure.name);
    }

    return DatabaseUtil.runInTransactionOrSavepoint(
      session.db,
      null,
      (transaction) async {
        var account = await TelegramAccount.db.findFirstRow(
          session,
          where: (table) => table.telegramUserId.equals(telegramUser.id),
          transaction: transaction,
        );

        if (account == null) {
          final authUser = await AuthServices.instance.authUsers.create(
            session,
            transaction: transaction,
          );
          await AuthServices.instance.userProfiles.createUserProfile(
            session,
            authUser.id,
            UserProfileData(
              userName: telegramUser.username,
              fullName: telegramUser.fullName,
            ),
            transaction: transaction,
          );
          account = await TelegramAccount.db.insertRow(
            session,
            TelegramAccount(
              telegramUserId: telegramUser.id,
              firstName: telegramUser.firstName,
              lastName: telegramUser.lastName,
              username: telegramUser.username,
              languageCode: telegramUser.languageCode,
              utcOffsetMinutes: utcOffsetMinutes,
              authUserId: authUser.id,
            ),
            transaction: transaction,
          );
        } else {
          account = await TelegramAccount.db.updateRow(
            session,
            account.copyWith(
              firstName: telegramUser.firstName,
              lastName: telegramUser.lastName,
              username: telegramUser.username,
              languageCode: telegramUser.languageCode,
              utcOffsetMinutes: utcOffsetMinutes ?? account.utcOffsetMinutes,
              updatedAt: DateTime.now().toUtc(),
            ),
            transaction: transaction,
          );
        }

        return AuthServices.instance.tokenManager.issueToken(
          session,
          authUserId: account.authUserId,
          method: authenticationMethod,
          transaction: transaction,
        );
      },
    );
  }
}
