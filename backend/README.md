# Gym Training backend

Dart backend на Serverpod и PostgreSQL для Telegram Mini App.

## Требования

- Dart SDK, совместимый с `backend/pubspec.yaml`;
- Docker с Compose;
- Serverpod CLI `3.4.13`.

## Локальный запуск

```sh
cd backend/backend_server
docker compose up --build --detach
dart bin/main.dart --apply-migrations
```

API по умолчанию доступен на `http://localhost:8080`, web server — на
`http://localhost:8082`.

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
он создаётся Serverpod CLI. Production-секреты, включая bot token Telegram,
передаются только окружением или секрет-хранилищем платформы деплоя.
