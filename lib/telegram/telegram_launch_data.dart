class TelegramLaunchData {
  const TelegramLaunchData({
    required this.isTelegram,
    required this.platform,
    required this.version,
    required this.isDarkMode,
    this.userName,
    this.startParam,
    this.initData = '',
  });

  const TelegramLaunchData.browser()
    : isTelegram = false,
      platform = 'browser',
      version = '—',
      isDarkMode = false,
      userName = null,
      startParam = null,
      initData = '';

  final bool isTelegram;
  final String platform;
  final String version;
  final bool isDarkMode;
  final String? userName;

  /// Untrusted launch parameter; invitation codes are verified by the server.
  final String? startParam;

  /// Raw Telegram launch data. It must only be trusted after server validation.
  final String initData;
}
