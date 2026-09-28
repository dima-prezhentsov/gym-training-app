import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../data/services/backend_session.dart';
import '../../../../telegram/telegram_web_app.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final telegram = context.watch<TelegramLaunchData>();
    final backend = context.watch<BackendSession>();

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 120),
        children: [
          Text('Профиль', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 30),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: AppColors.lime,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: AppColors.background,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          telegram.userName ?? 'Гостевой предпросмотр',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          telegram.isTelegram
                              ? 'Telegram подключён'
                              : 'Откройте приложение через Telegram',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _ProfileRow(label: 'Платформа', value: telegram.platform),
          const Divider(),
          _ProfileRow(label: 'Bot API', value: telegram.version),
          const Divider(),
          const _ProfileRow(label: 'Единицы веса', value: 'Килограммы'),
          const Divider(),
          _ProfileRow(label: 'Синхронизация', value: _backendStatus(backend)),
          const SizedBox(height: 28),
          Text(
            _backendHint(backend),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (backend.status == BackendSessionStatus.failed) ...[
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => backend.retry(telegram),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Повторить подключение'),
            ),
          ],
        ],
      ),
    );
  }

  String _backendStatus(BackendSession backend) {
    return switch (backend.status) {
      BackendSessionStatus.disabled => 'Не настроена',
      BackendSessionStatus.connecting => 'Подключение…',
      BackendSessionStatus.authenticated => 'Аккаунт подключён',
      BackendSessionStatus.failed => 'Ошибка подключения',
    };
  }

  String _backendHint(BackendSession backend) {
    return switch (backend.status) {
      BackendSessionStatus.disabled =>
        'Для синхронизации соберите приложение с адресом backend.',
      BackendSessionStatus.connecting => 'Проверяем запуск через Telegram…',
      BackendSessionStatus.authenticated =>
        'Telegram-аккаунт подтверждён сервером. Данные готовы к синхронизации.',
      BackendSessionStatus.failed =>
        'Не удалось подтвердить Telegram-аккаунт. Повторите подключение.',
    };
  }
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
