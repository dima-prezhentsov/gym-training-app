# Blueprint: Прогресс

## Placement

Третий пункт нижней навигации получает название «Прогресс». Экран содержит локальный переключатель «Обзор / История» и не добавляет пятый tab.

## States

### Success

Вертикальная лента: период, стрик, сводные показатели, выбор упражнения, график с метрикой, личные рекорды и группы мышц.

### Loading

Центральный индикатор загрузки; переключатель разделов остаётся доступен.

### Partial

- not applicable: расписание и история загружаются одной операцией репозитория.

### Empty

Объяснение, что показатели появятся после завершённой тренировки, и действие перехода к расписанию.

### Error

Ошибка внутри экрана и кнопка «Повторить» с индикатором повторной загрузки.

### Offline

Серверная ошибка отображается общим error state; отдельного offline-кэша пока нет. In-memory режим полностью локален.

### No access

- not applicable: доступ ограничен существующей Telegram-аутентификацией до вызова репозитория.

## Text slots

- SLOT: screen.title | type: label | context: заголовок третьего tab
- SLOT: tab.overview | type: label | context: переключатель раздела
- SLOT: tab.history | type: label | context: переключатель раздела
- SLOT: empty.no-workouts | type: empty-state/created | context: история пуста
- SLOT: error.load | type: error | context: не удалось получить аналитику
- SLOT: retry | type: action | context: повторная загрузка

## Interactive elements

- ELEM: section-switch | role: tab | action: переключает обзор и историю | state: всегда доступен
- ELEM: period-filter | role: segmented-control | action: выбирает 4 недели, 3 месяца или всё время | state: disabled во время загрузки
- ELEM: exercise-picker | role: dropdown | action: выбирает упражнение графика | state: hidden без упражнений
- ELEM: metric-chips | role: radio-group | action: выбирает 1ПМ, вес или объём | state: hidden без упражнения
- ELEM: retry-button | role: button | action: повторяет загрузку | state: показывает progress во время операции

## Boundary data

Ноль тренировок; одно измерение на графике; нулевой вес; несколько тренировок в один день; смена года и часового пояса; упражнение без подходов; очень длинные русские названия мышечных групп.

## Components

`ProgressScreen`, `ProgressOverviewView`, `ProgressChart`, `HistoryScreen(showHeader: false)`, существующие `Card`, `EmptyState`, `AsyncActionButton`.

## Open questions

Нет.
