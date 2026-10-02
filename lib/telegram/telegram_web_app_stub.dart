import 'telegram_launch_data.dart';

TelegramLaunchData initializeTelegramWebApp() {
  return const TelegramLaunchData.browser();
}

bool shareLinkInTelegram(String link) => false;
