-- USER AND SETTINGS
INSERT INTO client_settings (screen_resolution, game_language, music_volume, sound_volume, text_speed, auto_forward_time, is_fullscreen)
VALUES ('FULL_HD', 'UK', 0.8, 1.0, 0.5, 0.3, 1);
VALUES ('FULL_HD', 'UK', 0.8, 1.0, 0.5, 0.3, 1);
VALUES ('FULL_HD', 'UK', 0.8, 1.0, 0.5, 0.3, 1);

INSERT INTO users (username, email, password_hash, client_settings_id, created_at, updated_at)
VALUES ('Daniel', 'daniel@college.edu', 'hashed_pass_123', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
VALUES ('Vanya', 'vanya@gmail.com', 'hashed_pass_12356', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
VALUES ('Olexander', 'olexander@gmail.com', 'hashed_pass_15819', 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Flags
INSERT INTO flags (name, description) 
VALUES ('has_flashlight', 'Does user find flashlight');

-- SaveSlot
INSERT INTO save_slots (slot_number, screenshot_path, play_time_seconds, user_id, dialogue_id)
VALUES (1, 'SAVE_1', 3600, 1, 2);

-- SaveFlags
INSERT INTO save_flags (value, save_slot_id, flag_id)
VALUES ('true', 1, 1);


INSERT INTO game_scenes (id, next_scene_id, title, background_path, soundtrack_path, created_at, updated_at)
VALUES (1, 2, 'street', 'STREET_DAY', 'RAINDROP_AND_PUDDLES', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO game_scenes (id, next_scene_id, title, background_path, soundtrack_path, created_at, updated_at)
VALUES (2, 3, 'class', 'CLASS_DAY', 'OST', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO game_scenes (id, next_scene_id, title, background_path, soundtrack_path, ambient_path, created_at, updated_at)
VALUES (3, 4, 'class_haruka', 'CLASS_DAY', 'OST', 'FADE_OUT',CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO game_scenes (id, next_scene_id, title, background_path, soundtrack_path, ambient_path,created_at, updated_at)
VALUES (4, 5, 'rooftop', 'ROOFTOP_DAY', 'OST', 'FADE_OUT',CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO game_scenes (id, next_scene_id, title, background_path, soundtrack_path, created_at, updated_at)
VALUES (5, 6, 'class_eve', 'CLASS_EVE', 'OST', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO game_scenes (id, next_scene_id, title, background_path, soundtrack_path, created_at, updated_at)
VALUES (6, 7, 'street_eve', 'STREET_EVE', 'RAINDROP_AND_PUDDLES', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO game_scenes (id, title, background_path, created_at, updated_at)
VALUES (7, 'room_night', 'ROOM_NIGHT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- CHARACTERS
INSERT INTO characters (id, name, created_at, updated_at) VALUES 
(1, 'Haruka', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO characters (id, name, created_at, updated_at) VALUES 
(2, 'Aya', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO characters (id, name, created_at, updated_at) VALUES 
(3, 'Mio', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- CHARACTERS EMOTIONS(Sprites)
INSERT INTO character_sprites (id, emotion, sprite_path, character_id, created_at, updated_at)
VALUES (1, 'laugh', 'HARUKA_LAUGH', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO character_sprites (id, emotion, sprite_path, character_id, created_at, updated_at)
VALUES (2, 'dirty', 'HARUKA_DIRTY', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO character_sprites (id, emotion, sprite_path, character_id, created_at, updated_at)
VALUES (3, 'happy', 'AYA_HAPPY', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO character_sprites (id, emotion, sprite_path, character_id, created_at, updated_at)
VALUES (4, 'normal', 'AYA_NORMAL', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO character_sprites (id, emotion, sprite_path, character_id, created_at, updated_at)
VALUES (5, 'cat_smile', 'MIO_CAT_SMILE', 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO character_sprites (id, emotion, sprite_path, character_id, created_at, updated_at)
VALUES (6, 'normal', 'MIO_NORMAL', 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO character_sprites (id, emotion, sprite_path, character_id, created_at, updated_at)
VALUES (7, 'curious', 'AYA_CURIOUS', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO character_sprites (id, emotion, sprite_path, character_id, created_at, updated_at)
VALUES (8, 'smile', 'HARUKA_SMILE', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO character_sprites (id, emotion, sprite_path, character_id, created_at, updated_at)
VALUES (9, 'annoyed', 'HARUKA_ANNOYED', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- DIALOGUES(Scene 1)
INSERT INTO dialogues (id, order_index, default_text, game_scene_id, created_at, updated_at) VALUES
(1, 1, 'The spring breeze pleasantly cools the face.', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO dialogues (id, order_index, default_text, game_scene_id, created_at, updated_at) VALUES
(2, 2, 'New school year. Penultimate grade...', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO dialogues (id, order_index, default_text, game_scene_id, created_at, updated_at) VALUES
(3, 3, 'It would seem that this path to school has already been studied so well that I could walk it with my eyes closed.', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO dialogues (id, order_index, default_text, game_scene_id, created_at, updated_at) VALUES
(4, 4, 'But today everything feels a little different, I don`t know why, maybe I`m sick?', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO dialogues (id, order_index, default_text, game_scene_id, created_at, updated_at) VALUES
(5, 5, 'I hope there will be good people in the new class. Maybe even some of my former classmates?', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO dialogues (id, order_index, default_text, game_scene_id, created_at, updated_at) VALUES
(6, 6, 'Although... "classmates" is a big word. Rather, they are people whose names I remember and whom I sometimes greeted in the corridors. I never had any real friends..', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO dialogues (id, order_index, default_text, game_scene_id, created_at, updated_at) VALUES
(7, 7, 'Okay, stop beating yourself up. It`s just another year. No need to complicate things.', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT 
    u.username AS "Гравець",
    ss.slot_number AS "Слот",
    s.title || ' -> ' || d.default_text AS "Остання активність (Сцена -> Репліка)",
    (ss.play_time_seconds / 60) || ' хв' AS "Награно часу"
FROM save_slots ss
JOIN users u ON ss.user_id = u.id
JOIN dialogues d ON ss.dialogue_id = d.id
JOIN game_scenes s ON d.game_scene_id = s.id
ORDER BY ss.slot_number;