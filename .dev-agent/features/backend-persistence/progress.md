# Backend persistence — прогресс

- Часть: 3 из 4 выполнена.
- Следующая: `part-4.md` — постоянная история и deploy backend.
- Артефакты: PostgreSQL-модели schedule/day/exercise, owner-only endpoint, generated client contract, Flutter Serverpod repository и mapping, стартовое расписание нового пользователя.
- Проверено: aggregate round-trip, server validation, изоляция и удаление данных двух auth users; Flutter domain/API mapping; существующий in-memory preview сохранён.
- Изменилось в плане: при первом входе API repository сохраняет общий demo schedule вместо пустого, пока главный overview остаётся demo; это сохраняет рабочей кнопку старта тренировки.
- Не делать снова: phases 1–3 завершены; архитектура и разбивка закреплены в `spec.md`.
