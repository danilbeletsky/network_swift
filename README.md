# network_swift

Учебное iOS-приложение на UIKit: ввод имени, сетевой запрос к [Genderize.io](https://genderize.io/) и вывод предполагаемого пола на экране.

Xcode-проект в репозитории называется **animation**; папка **network_swift** отражает тему — работа с сетью в Swift.

## Возможности

- Поле ввода имени и кнопка «Проверить»
- Запрос к публичному API без ключа
- Разбор JSON в модель `Person`
- Обработка пустого ввода, сетевых ошибок и ответа без тела
- Обновление UI на главном потоке через замыкание из view model

## Архитектура

| Слой | Файл | Роль |
|------|------|------|
| View | `EasyViewController` | Разметка, ввод, кнопка, привязка к view model |
| View model | `EasyViewModel` | Валидация имени, вызов сервиса, текст для экрана |
| Сервис | `GenderService` | `URLSession`, декодирование ответа |
| Модель | `Person` | `Decodable`: имя и пол |
| Ошибки | `NetworkError` | Например, отсутствие данных в ответе |

Стартовый экран задаётся в `SceneDelegate`: корневой `EasyViewController` в `UINavigationController`.

## Требования

- macOS с Xcode
- iOS **26.0** (минимальная версия в настройках проекта)
- Swift **5.0**
- Доступ в интернет на устройстве или симуляторе

## Запуск

1. Откройте `animation.xcodeproj`.
2. Выберите схему **animation** и симулятор или устройство.
3. Соберите и запустите проект (⌘R).
4. Введите имя и нажмите «Проверить».

## API

Запрос:

```http
GET https://api.genderize.io/?name={имя}
```

Пример ответа:

```json
{
  "name": "Alex",
  "gender": "male",
  "probability": 0.99,
  "count": 100000
}
```

В приложении для отображения используются поля `name` и `gender`; `probability` и `count` в модели не разбираются.

## Структура репозитория

```text
network_swift/
├── README.md
├── animation.xcodeproj/
└── animation/
    ├── AppDelegate.swift
    ├── SceneDelegate.swift
    ├── EasyViewController.swift
    ├── EasyViewModel.swift
    ├── GenderService.swift
    ├── Person.swift
    ├── NetworkError.swift
    ├── Info.plist
    ├── Base.lproj/
    └── Assets.xcassets/
```

## Заметки

- Проект без сторонних зависимостей: только UIKit и Foundation.
- В `GenderService.swift` оставлен закомментированный вариант реализации — для сравнения с текущим кодом.
- Имя в запросе не кодируется для URL; для простых латинских имён этого обычно достаточно.
