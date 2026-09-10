# Backend persistence — прогресс

- Часть: 2 из 4 выполнена.
- Следующая: `part-3.md` — постоянное расписание.
- Артефакты: HMAC/freshness-валидатор Telegram `initData`, `telegram_account`, auth endpoint, JWT-сессия, Flutter `BackendSession`, compile-time `BACKEND_URL` и additive migration.
- Проверено: подмена, протухшие и неполные данные отклоняются; повторный вход одного Telegram ID использует того же auth user; Flutter preview работает без backend.
- Изменилось в плане: шаблонные IDP-таблицы сохранены в схеме для безопасной additive migration, но email endpoint и provider не публикуются приложением.
- Не делать снова: phases 1–3 завершены; архитектура и разбивка закреплены в `spec.md`.
