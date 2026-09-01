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

`Telegram.WebApp.initDataUnsafe` используется только для тестового отображения имени.
В будущем авторизацию нужно строить на серверной проверке исходной строки `initData` —
данным из `initDataUnsafe` доверять нельзя.
