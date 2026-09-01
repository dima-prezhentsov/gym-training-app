import 'telegram_launch_data.dart';
import 'telegram_web_app_stub.dart'
    if (dart.library.js_interop) 'telegram_web_app_web.dart'
    as implementation;

export 'telegram_launch_data.dart';

abstract final class TelegramWebApp {
  static TelegramLaunchData initialize() {
    return implementation.initializeTelegramWebApp();
  }
}
