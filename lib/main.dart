import 'package:flutter/material.dart';

import 'telegram/telegram_web_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final telegram = TelegramWebApp.initialize();
  runApp(GymTrainingApp(telegram: telegram));
}

class GymTrainingApp extends StatelessWidget {
  const GymTrainingApp({super.key, required this.telegram});

  final TelegramLaunchData telegram;

  @override
  Widget build(BuildContext context) {
    final brightness = telegram.isDarkMode ? Brightness.dark : Brightness.light;

    return MaterialApp(
      title: 'Gym Training',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: brightness,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B67F1),
          brightness: brightness,
        ),
        useMaterial3: true,
      ),
      home: TelegramSetupPage(telegram: telegram),
    );
  }
}

class TelegramSetupPage extends StatelessWidget {
  const TelegramSetupPage({super.key, required this.telegram});

  final TelegramLaunchData telegram;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTelegram = telegram.isTelegram;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    isTelegram ? Icons.telegram : Icons.language,
                    size: 72,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Gym Training',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isTelegram
                        ? 'Telegram Mini App подключён'
                        : 'Предпросмотр в обычном браузере',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: isTelegram
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _InfoRow(
                            label: 'Статус',
                            value: isTelegram ? 'В Telegram' : 'Web preview',
                          ),
                          const Divider(height: 28),
                          _InfoRow(
                            label: 'Платформа',
                            value: telegram.platform,
                          ),
                          const Divider(height: 28),
                          _InfoRow(label: 'Bot API', value: telegram.version),
                          if (telegram.userName != null) ...[
                            const Divider(height: 28),
                            _InfoRow(
                              label: 'Пользователь',
                              value: telegram.userName!,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    isTelegram
                        ? 'SDK вызвал ready() и expand(). Можно переходить к разработке интерфейса тренировок.'
                        : 'После публикации откройте этот URL через кнопку Mini App у Telegram-бота.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
