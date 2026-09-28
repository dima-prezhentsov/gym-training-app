import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/services/backend_session.dart';
import '../../../telegram/telegram_launch_data.dart';

void showAppErrorSnackBar(BuildContext context, String message) {
  final messenger = ScaffoldMessenger.of(context);
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            const Icon(Icons.error_outline_rounded),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
}

Future<bool> ensureBackendReady(BuildContext context) async {
  final backend = context.read<BackendSession>();
  final telegram = context.read<TelegramLaunchData>();
  if (!telegram.isTelegram || !backend.isConfigured) return true;

  final authenticated = await backend.ensureAuthenticated(telegram);
  if (!context.mounted) return false;
  if (!authenticated) {
    showAppErrorSnackBar(context, 'Не удалось подтвердить Telegram-аккаунт');
  }
  return authenticated;
}

Future<void> retryWithErrorFeedback(
  BuildContext context, {
  required Future<void> Function() operation,
  required String? Function() errorMessage,
  required String fallbackMessage,
}) async {
  if (!await ensureBackendReady(context) || !context.mounted) return;

  try {
    await operation();
  } on Object {
    if (context.mounted) showAppErrorSnackBar(context, fallbackMessage);
    return;
  }

  if (!context.mounted) return;
  final message = errorMessage();
  if (message != null) showAppErrorSnackBar(context, message);
}
