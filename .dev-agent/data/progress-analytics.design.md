# Data design: Динамика прогресса

## What already exists

- Источник расписания: `TrainingScheduleRepository.load()`.
- Источник истории: `WorkoutRepository.loadHistory()`.
- История уже привязана к авторизованному пользователю на backend.

## Proposal

Новая вычисляемая `ProgressOverview` содержит статистику периода, стрики, точки по упражнениям, рекорды и количество подходов по группам мышц. Значения строятся общим `ProgressCalculator` и не сохраняются.

## Migration

Не требуется: новые таблицы и поля не добавляются.

## API

Существующие `trainingSchedule.get` и `workoutHistory.list` достаточны. `ServerpodProgressRepository` объединяет их на клиенте. In-memory реализация использует те же интерфейсы и калькулятор.

- BREAKS: empty — API и DTO не меняются; старые клиенты продолжают работать.

## Access

Сохраняется текущая пользовательская область Telegram-сессии; аналитика видит только историю и расписание текущего пользователя.

## Indexes

Не требуются: новых запросов к БД нет.

## Frozen

- FROZEN: `WorkoutRecord.completedAt`, `ExerciseRecord.exerciseId`, `SetRecord.repetitions`, `SetRecord.weightKg` | depended on by: исторический пересчёт аналитики

## Open questions

Нет. Точный исторический snapshot расписания отложен за пределы MVP.
