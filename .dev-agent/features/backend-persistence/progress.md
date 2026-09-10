# Backend persistence — прогресс

- Часть: 1 из 4 выполнена.
- Следующая: `part-2.md` — Telegram auth.
- Артефакты: `backend/backend_server`, `backend/backend_client`, Docker Compose, начальная Serverpod migration, README и `spec.md`.
- Проверено: Serverpod generate успешно; `dart analyze` без замечаний; `docker compose config` валиден; базовый integration test прошёл (1/1).
- Изменилось в плане: стандартный Serverpod 3.4.13 scaffold уже включает auth-core/JWT и его migration; часть 2 расширит этот механизм Telegram-провайдером вместо создания параллельной системы сессий.
- Не делать снова: phases 1–3 завершены; архитектура и разбивка закреплены в `spec.md`.
