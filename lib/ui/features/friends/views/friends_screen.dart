import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../data/repositories/friend_error_message.dart';
import '../../../../data/repositories/friends_repository.dart';
import '../../../../domain/models/friend_connection.dart';
import '../../../../telegram/telegram_launch_data.dart';
import '../../../core/utils/app_error_feedback.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  List<FriendConnection>? _connections;
  String? _error;
  bool _busy = false;
  bool _inviteRedeemed = false;

  String? get _launchCode {
    if (_inviteRedeemed) return null;
    final param = context.read<TelegramLaunchData>().startParam;
    return param != null && param.startsWith('invite_')
        ? param.substring('invite_'.length)
        : null;
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(_load);
  }

  Future<void> _load() async {
    if (mounted) setState(() => _error = null);
    try {
      if (!await ensureBackendReady(context)) {
        if (mounted) setState(() => _error = 'Нет подключения к аккаунту');
        return;
      }
      if (!mounted) return;
      final connections = await context.read<FriendsRepository>().list();
      if (mounted) setState(() => _connections = connections);
    } on Object {
      if (mounted) setState(() => _error = 'Не удалось загрузить друзей');
    }
  }

  Future<void> _action(Future<void> Function() operation) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      if (!await ensureBackendReady(context) || !mounted) return;
      await operation();
      await _load();
    } on Object catch (error) {
      if (mounted) {
        showAppErrorSnackBar(
          context,
          friendErrorMessage(error, fallback: 'Не удалось выполнить действие'),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _shareInvite() async {
    await _action(() async {
      final invite = await context.read<FriendsRepository>().createInvite();
      const appLink = String.fromEnvironment('TELEGRAM_MINI_APP_LINK');
      if (appLink.isEmpty) {
        await Clipboard.setData(ClipboardData(text: invite.code));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Код приглашения скопирован')),
          );
        }
        return;
      }
      final uri = Uri.parse(appLink);
      final link = uri
          .replace(
            queryParameters: {
              ...uri.queryParameters,
              'startapp': 'invite_${invite.code}',
            },
          )
          .toString();
      await Clipboard.setData(ClipboardData(text: link));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ссылка-приглашение скопирована')),
        );
      }
    });
  }

  Future<void> _enterCode() async {
    final controller = TextEditingController();
    final code = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Код приглашения'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Вставьте код'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Отправить запрос'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (code == null || code.isEmpty) return;
    await _action(() async {
      await context.read<FriendsRepository>().redeemInvite(code);
    });
  }

  @override
  Widget build(BuildContext context) {
    final connections = _connections;
    final incoming =
        connections?.where((friend) => friend.isIncoming).toList() ?? [];
    final accepted =
        connections?.where((friend) => friend.isAccepted).toList() ?? [];
    final outgoing =
        connections
            ?.where((friend) => !friend.isAccepted && !friend.isIncoming)
            .toList() ??
        [];
    return Scaffold(
      appBar: AppBar(title: const Text('Друзья')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 36),
              children: [
                Text(
                  'Тренируйтесь вместе',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Приглашайте друзей и сами решайте, кому видны ваши результаты.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                if (_launchCode case final code?)
                  Card(
                    color: AppColors.surfaceRaised,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Вас пригласили в друзья'),
                          const SizedBox(height: 10),
                          FilledButton(
                            onPressed: _busy
                                ? null
                                : () => _action(() async {
                                    await context
                                        .read<FriendsRepository>()
                                        .redeemInvite(code);
                                    if (mounted) {
                                      setState(() => _inviteRedeemed = true);
                                    }
                                  }),
                            child: const Text('Отправить запрос'),
                          ),
                        ],
                      ),
                    ),
                  ),
                FilledButton.icon(
                  onPressed: _busy ? null : _shareInvite,
                  icon: const Icon(Icons.link_rounded),
                  label: const Text('Скопировать приглашение'),
                ),
                TextButton.icon(
                  onPressed: _busy ? null : _enterCode,
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Ввести код приглашения'),
                ),
                const SizedBox(height: 20),
                if (_error != null) ...[
                  Text(
                    _error!,
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                  TextButton(onPressed: _load, child: const Text('Повторить')),
                ] else if (connections == null)
                  const Center(child: CircularProgressIndicator())
                else ...[
                  if (incoming.isNotEmpty) ...[
                    const _SectionTitle('Запросы'),
                    for (final friend in incoming)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(friend.displayName),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  FilledButton(
                                    onPressed: _busy
                                        ? null
                                        : () => _action(() async {
                                            await context
                                                .read<FriendsRepository>()
                                                .accept(friend.userId);
                                          }),
                                    child: const Text('Принять'),
                                  ),
                                  TextButton(
                                    onPressed: _busy
                                        ? null
                                        : () => _action(() async {
                                            await context
                                                .read<FriendsRepository>()
                                                .decline(friend.userId);
                                          }),
                                    child: const Text('Отклонить'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 18),
                  ],
                  const _SectionTitle('Мои друзья'),
                  if (accepted.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Пока нет друзей. Отправьте приглашение.'),
                    ),
                  for (final friend in accepted)
                    Card(
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: AppColors.lime,
                          child: Icon(
                            Icons.person_rounded,
                            color: AppColors.background,
                          ),
                        ),
                        title: Text(friend.displayName),
                        subtitle: Text(
                          friend.username == null
                              ? 'Управление доступом и прогресс'
                              : '@${friend.username}',
                        ),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () async {
                          await context.push('/friends/${friend.userId}');
                          if (mounted) await _load();
                        },
                      ),
                    ),
                  if (outgoing.isNotEmpty) ...[
                    const SizedBox(height: 18),
                    const _SectionTitle('Ожидают ответа'),
                    for (final friend in outgoing)
                      Card(
                        child: ListTile(
                          title: Text(friend.displayName),
                          subtitle: const Text('Запрос отправлен'),
                          trailing: IconButton(
                            tooltip: 'Отменить запрос',
                            onPressed: _busy
                                ? null
                                : () => _action(() async {
                                    await context
                                        .read<FriendsRepository>()
                                        .remove(friend.userId);
                                  }),
                            icon: const Icon(Icons.close_rounded),
                          ),
                        ),
                      ),
                  ],
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(title, style: Theme.of(context).textTheme.titleLarge),
  );
}
