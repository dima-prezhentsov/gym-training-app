import 'dart:js_interop';

import 'telegram_launch_data.dart';

@JS('Telegram.WebApp')
external TelegramWebAppJs? get _telegramWebApp;

extension type TelegramWebAppJs(JSObject _) implements JSObject {
  external String get initData;
  external String get platform;
  external String get version;
  external String get colorScheme;
  external TelegramInitDataJs get initDataUnsafe;
  external void ready();
  external void expand();
  external bool isVersionAtLeast(String version);
  external void disableVerticalSwipes();
  external void openTelegramLink(String url);
}

extension type TelegramInitDataJs(JSObject _) implements JSObject {
  external TelegramUserJs? get user;
  @JS('start_param')
  external String? get startParam;
}

extension type TelegramUserJs(JSObject _) implements JSObject {
  @JS('first_name')
  external String get firstName;

  @JS('last_name')
  external String? get lastName;

  external String? get username;
}

TelegramLaunchData initializeTelegramWebApp() {
  final app = _telegramWebApp;
  if (app == null || app.initData.isEmpty) {
    return const TelegramLaunchData.browser();
  }

  app.ready();
  app.expand();
  if (app.isVersionAtLeast('7.7')) {
    app.disableVerticalSwipes();
  }

  final user = app.initDataUnsafe.user;
  return TelegramLaunchData(
    isTelegram: true,
    platform: app.platform,
    version: app.version,
    isDarkMode: app.colorScheme == 'dark',
    userName: user == null ? null : _displayName(user),
    startParam:
        app.initDataUnsafe.startParam ??
        Uri.splitQueryString(app.initData)['start_param'],
    initData: app.initData,
  );
}

String _displayName(TelegramUserJs user) {
  final parts = [
    user.firstName,
    user.lastName,
  ].whereType<String>().where((part) => part.isNotEmpty).join(' ');
  final username = user.username;
  return username == null || username.isEmpty ? parts : '$parts (@$username)';
}

bool shareLinkInTelegram(String link) {
  final app = _telegramWebApp;
  if (app == null || app.initData.isEmpty) return false;
  final shareUrl = Uri.https('t.me', '/share/url', {
    'url': link,
    'text': 'Присоединяйся ко мне в LiftLog',
  });
  app.openTelegramLink(shareUrl.toString());
  return true;
}
