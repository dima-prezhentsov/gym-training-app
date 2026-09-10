class TelegramLaunchData {
  const TelegramLaunchData({
    required this.isTelegram,
    required this.platform,
    required this.version,
    required this.isDarkMode,
    this.userName,
    this.initData = '',
  });

  const TelegramLaunchData.browser()
    : isTelegram = false,
      platform = 'browser',
      version = '—',
      isDarkMode = false,
      userName = null,
      initData = '';

  final bool isTelegram;
  final String platform;
  final String version;
  final bool isDarkMode;
  final String? userName;

  /// Raw Telegram launch data. It must only be trusted after server validation.
  final String initData;
}
