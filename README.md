# 🎭 Poem of the Damned - Full Database Documentation

## 📊 Діаграми

### Концептуальна схема (Notation by Peter Chen)
![Chen Diagram](diagrams/chen_diagram.png)

### Логічна схема (Crow's Foot Notation)
![Crow Diagram](diagrams/crow_diagram.png)

## 📋 Повний перелік сутностей (20 таблиць)

| Сутність | Категорія | Опис |
|----------|-----------|------|
| **users** | Core | Користувачі системи |
| **client_settings** | Extension | Технічні налаштування (звук, графіка) |
| **achievements** | Reference | Довідник усіх ігрових досягнень |
| **achievement_title_trans** | Translation | Локалізація назв ачівок |
| **achievement_desc_trans** | Translation | Локалізація описів ачівок |
| **user_achievements** | Junction | Журнал отриманих досягнень гравцями |
| **flags** | Reference | Сюжетні змінні (State Flags) |
| **game_scenes** | Core | Сюжетні вузли та локації |
| **choices** | Core | Можливі рішення гравця у сценах |
| **choice_translations** | Translation | Локалізація тексту виборів |
| **choice_effects** | Logic | Вплив вибору на прапорці (Flags) |
| **user_unlocked_choices** | Junction | Історія відкритих гілок сюжету |
| **characters** | Core | Персонажі гри |
| **character_trans** | Translation | Локалізація імен персонажів |
| **description_trans** | Translation | Локалізація описів персонажів |
| **character_sprites** | Extension | Емоційні стани та посилання на асети |
| **dialogues** | Core | Репліки діалогової системи |
| **dialogue_translations** | Translation | Локалізація тексту діалогів |
| **save_slots** | Transactional | Дані точок збереження |
| **save_flags** | Transactional | Зріз стану прапорців у момент збереження |

## 🔗 Повна карта зв'язків

### Система гравця
- `users` 1:1 `client_settings` (Кожен юзер має один конфіг).
- `users` 1:N `user_achievements` & `user_unlocked_choices` (Прогрес юзера).
- `users` 1:N `save_slots` (Слоти збереження).
- `users` M:N `choices` проміжна таблиця `user_unlocked_choices`

### Сюжетна логіка
- `game_scenes` 1:1 `game_scenes` (Самозв'язок: наступна сцена за замовчуванням).
- `game_scenes` 1:N `choices` (Варіанти дій у сцені).
- `game_scenes` 1:N `dialogues` (Контент сцени).
- `choices` 1:N `choice_effects` (Зміни прапорців при виборі).
- `choices` M:1 `flags` (Умова доступності вибору).

### Персонажі та Візуалізація
- `characters` 1:N `character_sprites` (Набір емоцій).
- `characters` 1:N `dialogues` (Хто говорить).
- `character_sprites` 1:N `dialogues` (Яку емоцію показувати при репліці).

### Локалізація (I18n)
- Всі таблиці з суфіксом `_translations` пов'язані 1:N зі своїми основними сутностями (`achievements`, `choices`, `characters`, `dialogues`).

## 🗄️ Нормалізація (3NF)

- **1NF**: Атомарність забезпечена за рахунок винесення всіх локалізованих рядків у окремі таблиці.
- **2NF**: Повна залежність від ключа. Всі таблиці використовують `id` як єдиний ідентифікатор.
- **3NF**: Відсутні транзитивні залежності. Наприклад, спрайти не залежать від сцени напряму, а лише через діалог та персонажа.

## 📝 Архітектурні особливості (SQLite)

- Всі сутності використовують `INTEGER PRIMARY KEY AUTOINCREMENT`.
- Підтримка цілісності через `ON DELETE CASCADE` для всіх таблиць перекладів та асетів.
- Для транзакційних таблиць (`save_slots`) передбачено унікальний індекс на пару `(user_id, slot_number)`.
