if (!dialogue_active) exit;

// Trava o primeiro frame, antes de processar qualquer coisa
if (dialogue_just_opened) {
    dialogue_just_opened = false;
    exit;
}

var _current_page = dialogue_pages[dialogue_page_index].txt;
var _is_last = (dialogue_page_index >= array_length(dialogue_pages) - 1);
var _confirm = scr_key_confirm();

// Efeito de texto aparecendo letra por letra.
// Pontuação segura o texto um pouquinho, pra fala respirar.
if (!dialogue_full_page) {
    dialogue_timer -= 1;
    if (dialogue_timer <= 0) {
        dialogue_char_index++;
        dialogue_current_text = string_copy(_current_page, 1, dialogue_char_index);
        dialogue_timer = dialogue_text_speed;

        var _c = string_char_at(_current_page, dialogue_char_index);
        if (_c != " " && dialogue_char_index mod 2 == 1) scr_voice_blip(dialogue_pages[dialogue_page_index].spk);
        if (_c == "." || _c == "!" || _c == "?") dialogue_timer = dialogue_text_speed * 5;
        else if (_c == ",") dialogue_timer = dialogue_text_speed * 3;

        if (dialogue_char_index >= string_length(_current_page)) {
            dialogue_full_page = true;
        }
    }
}

// Escolhas: aparecem quando a última página termina
if (_is_last && dialogue_full_page && array_length(choice_options) > 0) {
    if (!choice_active) {
        choice_active = true;
        exit; // não deixa o mesmo Z que completou o texto escolher
    }

    var _n = array_length(choice_options);
    if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")) ||
        keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
        choice_index = (choice_index - 1 + _n) mod _n;
    }
    if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D")) ||
        keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
        choice_index = (choice_index + 1) mod _n;
    }

    if (_confirm) {
        global.choice = choice_index;
        dialogue_active = false;
        choice_active = false;
        choice_options = [];
        with (obj_player) { interact_cooldown = 10; }
    }
    exit;
}

// X completa a página de uma vez
if (keyboard_check_pressed(ord("X")) && !dialogue_full_page) {
    dialogue_current_text = _current_page;
    dialogue_char_index = string_length(_current_page);
    dialogue_full_page = true;
    exit;
}

// Avançar o diálogo (Z)
if (_confirm) {
    if (!dialogue_full_page) {
        dialogue_current_text = _current_page;
        dialogue_char_index = string_length(_current_page);
        dialogue_full_page = true;
    } else {
        dialogue_page_index++;
        if (dialogue_page_index >= array_length(dialogue_pages)) {
            dialogue_active = false;
            with (obj_player) { interact_cooldown = 10; }
        } else {
            dialogue_char_index = 0;
            dialogue_current_text = "";
            dialogue_full_page = false;
            dialogue_timer = 0;
        }
    }
}
