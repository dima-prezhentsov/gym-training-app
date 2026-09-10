# Gym Training Mini App

Flutter-приложение для тренировок, подготовленное к запуску как Telegram Mini App.

## Локальный запуск

```sh
flutter pub get
flutter run -d chrome
```

В обычном браузере приложение покажет режим `Web preview`. Данные пользователя и
платформы появляются только при запуске из Telegram.

## Публикация

Workflow `.github/workflows/deploy-pages.yml` проверяет проект, собирает Flutter Web
и публикует `build/web` в GitHub Pages после push в `main`.

1. В GitHub откройте **Settings → Pages**.
2. В **Build and deployment → Source** выберите **GitHub Actions**.
3. Убедитесь, что workflow `Deploy Flutter web to GitHub Pages` завершился успешно.
4. Откройте `https://dima-prezhentsov.github.io/gym-training-app/`.

## Подключение к Telegram

1. Создайте тестового бота через [@BotFather](https://t.me/BotFather), если его ещё нет.
2. Откройте **Bot Settings → Configure Mini App → Enable Mini App**.
3. Укажите URL `https://dima-prezhentsov.github.io/gym-training-app/`.
4. Откройте бота и нажмите **Open App**.

`Telegram.WebApp.initDataUnsafe` используется только для отображения имени.
Авторизация выполняется backend-сервером по исходной строке `initData`; данным из
`initDataUnsafe` сервер не доверяет.

## Backend

Serverpod/PostgreSQL-проект находится в [`backend/`](backend/README.md). Он
запускается независимо от Flutter Web; инструкции локальной разработки и
генерации клиента находятся в backend README.

Адрес API передаётся Flutter Web во время сборки:

```sh
flutter build web --release --dart-define=BACKEND_URL=https://api.example.com/
```

Без `BACKEND_URL` приложение продолжает работать в режиме локального
предпросмотра, но синхронизация отключена. Для GitHub Pages задайте repository
variable `BACKEND_URL` в **Settings → Secrets and variables → Actions → Variables**.
