import 'package:backend_client/backend_client.dart' as api;

String friendErrorMessage(Object error, {required String fallback}) {
  if (error is! api.FriendAccessException) return fallback;
  return switch (error.reason) {
    'invalidInvite' => 'Неверный код приглашения',
    'expiredInvite' => 'Срок действия приглашения истёк',
    'selfInvite' => 'Нельзя отправить запрос самому себе',
    'notIncomingRequest' => 'Запрос уже обработан',
    'notFriends' => 'Вы больше не в друзьях',
    'statsPrivate' => 'Друг закрыл доступ к статистике',
    'historyPrivate' => 'Друг закрыл доступ к истории',
    _ => fallback,
  };
}
