class TelegramLaunchData {
  const TelegramLaunchData({
    required this.isTelegram,
    required this.platform,
    required this.version,
    required this.isDarkMode,
    this.userName,
  });

  const TelegramLaunchData.browser()
    : isTelegram = false,
      platform = 'browser',
      version = '—',
      isDarkMode = false,
      userName = null;

  final bool isTelegram;
  final String platform;
  final String version;
  final bool isDarkMode;
  final String? userName;
}
