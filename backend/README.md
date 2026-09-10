# Gym Training backend

Dart backend на Serverpod и PostgreSQL для Telegram Mini App.

Production checklist: [`DEPLOYMENT.md`](DEPLOYMENT.md).

## Требования

- Dart SDK, совместимый с `backend/pubspec.yaml`;
- Docker с Compose;
- Serverpod CLI `3.4.13`.

## Локальный запуск

Добавьте bot token только в локальный `backend_server/config/passwords.yaml`:

```yaml
development:
  telegramBotToken: '123456:replace-with-real-token'
```

```sh
cd backend/backend_server
docker compose up --build --detach
dart bin/main.dart --apply-migrations
```

API по умолчанию доступен на `http://localhost:8080`, web server — на
`http://localhost:8082`.

Endpoint расписания требует JWT-сессию, полученную через проверенный Telegram
`initData`. Все запросы автоматически ограничены текущим `authUserId`.

Остановка инфраструктуры:

```sh
docker compose stop
```

## Генерация

После изменения файлов protocol или endpoint:

```sh
cd backend/backend_server
serverpod generate
```

Сгенерированные файлы server/client являются частью репозитория.

## Секреты

`backend_server/config/passwords.yaml` не коммитится. Для локальной разработки
он создаётся Serverpod CLI. Production-секреты передаются только окружением или
секрет-хранилищем платформы деплоя. Backend читает bot token из переменной
`TELEGRAM_BOT_TOKEN`.
