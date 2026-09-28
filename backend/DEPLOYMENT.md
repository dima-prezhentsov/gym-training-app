# Backend deployment

Backend поставляется стандартным multi-stage Dockerfile Serverpod и может быть
запущен на любом контейнерном хостинге рядом с PostgreSQL 16.

## Сборка образа

Контекстом сборки должен быть каталог `backend`, а не `backend_server`:

```sh
cd backend
docker build -f backend_server/Dockerfile -t gym-training-backend .
```

Контейнер принимает API-запросы на порту `8080`. Публичный адрес обязан работать
по HTTPS, иначе Telegram WebView заблокирует обращения из Mini App.

## Обязательное окружение

```text
SERVERPOD_RUN_MODE=production
SERVERPOD_SERVER_ROLE=monolith
SERVERPOD_APPLY_MIGRATIONS=true
SERVERPOD_DATABASE_HOST=<postgres-host>
SERVERPOD_DATABASE_PORT=5432
SERVERPOD_DATABASE_NAME=<database-name>
SERVERPOD_DATABASE_USER=<database-user>
SERVERPOD_PASSWORD_database=<database-password>
SERVERPOD_DATABASE_REQUIRE_SSL=true
SERVERPOD_API_SERVER_PUBLIC_HOST=<api-domain-without-scheme>
SERVERPOD_API_SERVER_PUBLIC_PORT=443
SERVERPOD_API_SERVER_PUBLIC_SCHEME=https
TELEGRAM_BOT_TOKEN=<bot-token>
SERVERPOD_PASSWORD_jwtHmacSha512PrivateKey=<long-random-secret>
SERVERPOD_PASSWORD_jwtRefreshTokenHashPepper=<different-long-random-secret>
```

Значения `TELEGRAM_BOT_TOKEN`, database password и JWT secrets должны храниться
в secret storage платформы. Их нельзя добавлять в Docker image или git.

## Связь с GitHub Pages

После первого успешного запуска контейнера и применения миграций:

1. Проверьте доступность API по HTTPS.
2. В GitHub repository variables задайте `BACKEND_URL`, например
   `https://api.gym.example.com/`.
3. Перезапустите workflow `Deploy Flutter web to GitHub Pages`.
4. Откройте Mini App заново и проверьте в профиле статус
   `Аккаунт подключён`.

Serverpod по умолчанию отправляет CORS-заголовки для cross-origin API-запросов.
Если политика будет ужесточена, необходимо оставить разрешённым origin GitHub
Pages и метод `POST`.

Конкретный hosting manifest не добавлен: формат подключения managed PostgreSQL,
health checks и способ задания secrets различаются между Render, Fly.io,
Railway и другими платформами.

## Render + Neon

Для бесплатного Render Web Service используйте следующие настройки:

```text
Language: Docker
Region: Frankfurt
Branch: main
Dockerfile Path: backend/backend_server/Dockerfile
Docker Build Context Directory: backend
Compute: Free
```

Render направляет HTTP-трафик на порт `10000`, поэтому дополнительно задайте:

```text
SERVERPOD_API_SERVER_PORT=10000
SERVERPOD_DATABASE_MAX_CONNECTION_COUNT=3
SERVERPOD_SESSION_CONSOLE_LOG_ENABLED=true
SERVERPOD_SESSION_CONSOLE_LOG_FORMAT=json
```

Для постоянного Web Service используйте pooled Neon host из `DATABASE_URL`.
Для миграций предпочтителен direct host из `DATABASE_URL_UNPOOLED`. На первом
запуске небольшого Free-инстанса допустимо использовать direct host вместе с
`SERVERPOD_APPLY_MIGRATIONS=true`, а после применения миграций заменить host на
pooled-вариант.

Значение `SERVERPOD_API_SERVER_PUBLIC_HOST` должно совпадать с выданным Render
доменом без `https://`, например `gym-training-api.onrender.com`.
