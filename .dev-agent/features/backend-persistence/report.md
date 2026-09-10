# Backend persistence для Telegram Mini App

## Зачем

Расписание и история тренировок должны переживать перезапуск Mini App и быть
доступны только подтверждённому Telegram-пользователю.

## Что появилось

Добавлен Dart backend на Serverpod/PostgreSQL, серверная проверка Telegram
`initData`, JWT-сессии и owner-only API расписания и истории. Flutter Web при
наличии `BACKEND_URL` использует Serverpod repositories, а обычный browser
preview сохраняет in-memory данные.

## Как спроектировали

Bot token остаётся только на сервере. Telegram ID связывается с UUID auth user;
расписание и каждая завершённая тренировка имеют явный `authUserId`. Между API
DTO и существующими Flutter domain models стоят отдельные mapping-функции.

## Связанность

| Что | Результат |
|---|---|
| Telegram bridge | Передаёт raw `initData`; display identity остаётся недоверенной |
| Startup | Auth запускается до запросов API repositories |
| Расписание | Сохраняется целым aggregate schedule/day/exercise |
| История | Сохраняется целым aggregate workout/exercise/set |
| Активная тренировка | По плану остаётся локальной до завершения |
| Главный overview | Пока demo; новый пользователь получает совместимое стартовое расписание |
| GitHub Pages | Принимает repository variable `BACKEND_URL` |
| Backend deploy | Есть Docker/secret checklist, provider manifest не выбран |

## Как проверяли

- Telegram validator: валидная подпись, подмена, expiry, дубли параметров и
  отсутствие user.
- Auth integration: повторный Telegram ID получает тот же auth user.
- Schedule integration: round-trip, validation, delete и изоляция двух users.
- History integration: полный workout round-trip, idempotent save и изоляция.
- Flutter mapping и весь существующий widget/view-model suite.
- `dart analyze`, `dart test`, `flutter analyze`, `flutter test`, release Web
  build.

На финальном прогоне: backend 15/15, Flutter 17/17, оба анализатора без
замечаний, Web release build успешен.

## Результат ревью

Блокирующих проблем безопасности и корректности не найдено. Все endpoint-ы с
пользовательскими данными требуют login и берут owner ID из серверной сессии,
а не из request DTO. Секреты отсутствуют во Flutter bundle и git.

## Что осталось

- Выбрать контейнерный хостинг и managed PostgreSQL, затем реально развернуть
  backend и задать secrets.
- Проверить полный сценарий на физическом телефоне после production deploy.
- Добавить pagination/batched loading истории: текущая реализация читает всю
  историю и использует вложенные запросы, что приемлемо для MVP, но не для
  большого объёма данных.
- Усилить защиту от редкой гонки двух одновременных первых login/save запросов
  обработкой unique-conflict/retry.
- Аналитика роста и восстановление незавершённой тренировки остаются за рамками.
