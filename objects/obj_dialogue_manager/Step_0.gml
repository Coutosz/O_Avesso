if (!dialogue_active) exit;

// Trava o primeiro frame, antes de processar qualquer coisa
if (dialogue_just_opened) {
    dialogue_just_opened = false;
    exit;
}

var _current_page = dialogue_pages[dialogue_page_index];

// Efeito de texto aparecendo letra por letra
if (!dialogue_full_page) {
    dialogue_timer++;
    if (dialogue_timer >= dialogue_text_speed) {
        dialogue_timer = 0;
        dialogue_char_index++;
        dialogue_current_text = string_copy(_current_page, 1, dialogue_char_index);
        
        if (dialogue_char_index >= string_length(_current_page)) {
            dialogue_full_page = true;
        }
    }
}

// Avançar o diálogo (tecla Z)
if (keyboard_check_pressed(ord("Z"))) {
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
        }
    }
}