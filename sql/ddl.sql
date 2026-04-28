-- DDL SCRIPT --

PRAGMA foreign_keys = ON;

-- 1. Таблиця: client_settings
-- НФ: 3НФ
-- ТИП: Статично-динамічний довідник Змінюється рідко, лише користувачем у мейн меню.
CREATE TABLE client_settings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    screen_resolution TEXT NOT NULL,
    game_language TEXT NOT NULL,
    music_volume REAL NOT NULL CHECK (music_volume >= 0.0 AND music_volume <= 1.0),
    sound_volume REAL NOT NULL CHECK (sound_volume >= 0.0 AND sound_volume <= 1.0),
    text_speed REAL NOT NULL,
    auto_forward_time REAL NOT NULL,
    is_fullscreen BOOLEAN NOT NULL
);

-- 2. Таблиця: users
-- НФ: 3НФ.
-- ТИП: Стрижнева таблиця Основа системи, на яку посилаються сейви та досягнення.
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    client_settings_id INTEGER UNIQUE NOT NULL,
    FOREIGN KEY (client_settings_id) REFERENCES client_settings(id) ON DELETE CASCADE
);

-- 3. Таблиця: achievements
-- НФ: 3НФ.
-- ТИП: Статичний довідник. Список досягнень фіксований розрабом
CREATE TABLE achievements (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT UNIQUE NOT NULL,
    description TEXT,
    icon_path TEXT NOT NULL,
    is_hidden BOOLEAN NOT NULL
);

-- 4. Таблиця: achievement_title_translations
-- НФ: 3НФ Складений ключ achievement_id + locale.
-- ТИП: Статичний довідник. Локалізація контенту, що не змінюється під час гри.
CREATE TABLE achievement_title_translations (
    achievement_id INTEGER NOT NULL,
    locale TEXT NOT NULL,
    translated_achievement_title TEXT NOT NULL,
    PRIMARY KEY (achievement_id, locale),
    FOREIGN KEY (achievement_id) REFERENCES achievements(id) ON DELETE CASCADE
);

-- 5. Таблиця: achievement_description_translations
-- НФ: 3НФ.
-- ТИП: Статичний довідник.
CREATE TABLE achievement_description_translations (
    achievement_id INTEGER NOT NULL,
    locale TEXT NOT NULL,
    translated_achievement_description TEXT NOT NULL,
    PRIMARY KEY (achievement_id, locale),
    FOREIGN KEY (achievement_id) REFERENCES achievements(id) ON DELETE CASCADE
);

-- 6. Таблиця: user_achievements
-- НФ: 3НФ.
-- ТИП: Таблиця-зв'язка. Розв'язує зв'язок M:N між користувачем та ачівками.
CREATE TABLE user_achievements (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    achievement_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (achievement_id) REFERENCES achievements(id) ON DELETE CASCADE,
    UNIQUE (user_id, achievement_id)
);

-- 7. Таблиця: flags
-- НФ: 3НФ.
-- ТИП: Статично-динамічний довідник. Визначає перелік сюжетних змінних.
CREATE TABLE flags (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL,
    description TEXT
);

-- 8. Таблиця: game_scenes
-- НФ: 3НФ.
-- ТИП: Стрижнева таблиця. 
CREATE TABLE game_scenes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT UNIQUE NOT NULL,
    background_path TEXT NOT NULL,
    soundtrack_path TEXT,
    ambient_path TEXT,
    transition_type TEXT,
    next_scene_id INTEGER,
    FOREIGN KEY (next_scene_id) REFERENCES game_scenes(id) ON DELETE SET NULL
);

-- 9. Таблиця: choices
-- НФ: 3НФ.
-- ТИП: Стрижнева таблиця. Сюжетні розгалуження, що активно використовуються логікою гри.
CREATE TABLE choices (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    choice_text TEXT NOT NULL,
    order_index INTEGER NOT NULL CHECK (order_index >= 1),
    required_flag_value TEXT,
    required_flag_id INTEGER,
    game_scene_id INTEGER NOT NULL,
    next_game_scene_id INTEGER,
    FOREIGN KEY (required_flag_id) REFERENCES flags(id) ON DELETE SET NULL,
    FOREIGN KEY (game_scene_id) REFERENCES game_scenes(id) ON DELETE CASCADE,
    FOREIGN KEY (next_game_scene_id) REFERENCES game_scenes(id) ON DELETE SET NULL
);

-- 10. Таблиця: choice_translations
-- НФ: 3НФ.
-- ТИП: Статичний довідник. Переклади текстів виборів.
CREATE TABLE choice_translations (
    choice_id INTEGER NOT NULL,
    locale TEXT NOT NULL,
    translated_text TEXT NOT NULL,
    PRIMARY KEY (choice_id, locale),
    FOREIGN KEY (choice_id) REFERENCES choices(id) ON DELETE CASCADE
);

-- 11. Таблиця: choice_effects
-- НФ: 3НФ.
-- ТИП: Таблиця-зв'язка з атрибутами. Поєднує вибір та прапорець, вказуючи нове значення.
CREATE TABLE choice_effects (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    new_value TEXT NOT NULL,
    choice_id INTEGER NOT NULL,
    flag_id INTEGER NOT NULL,
    FOREIGN KEY (choice_id) REFERENCES choices(id) ON DELETE CASCADE,
    FOREIGN KEY (flag_id) REFERENCES flags(id) ON DELETE CASCADE
);

-- 12. Таблиця: user_unlocked_choices
-- НФ: 3НФ.
-- ТИП: Таблиці-зв язки. Фіксує пройдений шлях користувача (M:N).
CREATE TABLE user_unlocked_choices (
    user_id INTEGER NOT NULL,
    choice_id INTEGER NOT NULL,
    PRIMARY KEY (user_id, choice_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (choice_id) REFERENCES choices(id) ON DELETE CASCADE
);

-- 13. Таблиця: characters
-- НФ: 3НФ.
-- ТИП: Стрижнева таблиця.
CREATE TABLE characters (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL,
    description TEXT
);

-- 14. Таблиця: character_translations
-- НФ: 3НФ. 
-- ТИП: Статичний довідник.
CREATE TABLE character_translations (
    character_id INTEGER NOT NULL,
    locale TEXT NOT NULL,
    translated_name TEXT NOT NULL,
    PRIMARY KEY (character_id, locale),
    FOREIGN KEY (character_id) REFERENCES characters(id) ON DELETE CASCADE
);

-- 15. Таблиця: description_translations
-- НФ: 3НФ. 
-- ТИП: Статичний довідник.
CREATE TABLE description_translations (
    character_id INTEGER NOT NULL,
    locale TEXT NOT NULL,
    translated_description TEXT NOT NULL,
    PRIMARY KEY (character_id, locale),
    FOREIGN KEY (character_id) REFERENCES characters(id) ON DELETE CASCADE
);

-- 16. Таблиця: character_sprites
-- НФ: 3НФ.
-- ТИП: Стрижнева таблиця. Спрайти, що розширюють дані персонажа
CREATE TABLE character_sprites (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    emotion TEXT NOT NULL,
    sprite_path TEXT NOT NULL,
    character_id INTEGER NOT NULL,
    FOREIGN KEY (character_id) REFERENCES characters(id) ON DELETE CASCADE,
    UNIQUE (character_id, emotion)
);

-- 17. Таблиця: dialogues
-- НФ: 3НФ.
-- ТИП: Стрижнева таблиця. Основний контент гри, що посилається на сцени та спрайти.
CREATE TABLE dialogues (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    default_text TEXT NOT NULL,
    music_path TEXT,
    ambient_path TEXT,
    order_index INTEGER NOT NULL CHECK (order_index >= 1),
    sprite_position TEXT,
    game_scene_id INTEGER NOT NULL,
    character_id INTEGER,
    character_sprite_id INTEGER,
    FOREIGN KEY (game_scene_id) REFERENCES game_scenes(id) ON DELETE CASCADE,
    FOREIGN KEY (character_id) REFERENCES characters(id) ON DELETE SET NULL,
    FOREIGN KEY (character_sprite_id) REFERENCES character_sprites(id) ON DELETE SET NULL
);

-- 18. Таблиця: dialogue_translations
-- НФ: 3НФ.
-- ТИП: Тип 1 Статичний довідник.
CREATE TABLE dialogue_translations (
    dialogue_id INTEGER NOT NULL,
    locale TEXT NOT NULL,
    translated_text TEXT NOT NULL,
    PRIMARY KEY (dialogue_id, locale),
    FOREIGN KEY (dialogue_id) REFERENCES dialogues(id) ON DELETE CASCADE
);

-- 19. Таблиця: save_slots
-- НФ: 3НФ.
-- ТИП: Транзакційна / Подієва таблиця. Фіксує стан гри у певний момент часу.
CREATE TABLE save_slots (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    slot_number INTEGER NOT NULL CHECK (slot_number >= 1),
    screenshot_path TEXT NOT NULL DEFAULT 'assets/ui/default_save_placeholder.png',
    play_time_seconds INTEGER NOT NULL DEFAULT 0,
    user_id INTEGER NOT NULL,
    dialogue_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (dialogue_id) REFERENCES dialogues(id) ON DELETE CASCADE,
    UNIQUE (user_id, slot_number)
);

-- 20. Таблиця: save_flags
-- НФ: 3НФ.
-- ТИП: Транзакційна. Зберігає "зріз" значень прапорців для конкретного сейву.
CREATE TABLE save_flags (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    value TEXT NOT NULL,
    save_slot_id INTEGER NOT NULL,
    flag_id INTEGER NOT NULL,
    FOREIGN KEY (save_slot_id) REFERENCES save_slots(id) ON DELETE CASCADE,
    FOREIGN KEY (flag_id) REFERENCES flags(id) ON DELETE CASCADE,
    UNIQUE (save_slot_id, flag_id)
);