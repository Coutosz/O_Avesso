switch (boot_state) {
    case "logo":
        boot_timer++;
        if (boot_timer >= 120 || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"))) {
            boot_state = "cutscene";
            boot_timer = 0;
        }
        break;
        
    case "cutscene":
        var _current_key = cutscene_pages[cutscene_page_index];
        var _current_text = scr_text(_current_key);
        
        if (!cutscene_full_page) {
            cutscene_timer++;
            if (cutscene_timer >= cutscene_text_speed) {
                cutscene_timer = 0;
                cutscene_char_index++;
                cutscene_current_text = string_copy(_current_text, 1, cutscene_char_index);
                if (cutscene_char_index >= string_length(_current_text)) {
                    cutscene_full_page = true;
                }
            }
        }
        
        if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
            if (!cutscene_full_page) {
                cutscene_current_text = _current_text;
                cutscene_char_index = string_length(_current_text);
                cutscene_full_page = true;
            } else {
                cutscene_page_index++;
                if (cutscene_page_index >= array_length(cutscene_pages)) {
                    boot_state = "title";
                } else {
                    cutscene_char_index = 0;
                    cutscene_current_text = "";
                    cutscene_full_page = false;
                }
            }
        }
        break;
        
    case "title":
        boot_timer++; // só pro piscar do "PRESS ENTER"
        if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"))) {
            boot_state = "language";
        }
        break;
        
    case "language":
        if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right) ||
            keyboard_check_pressed(ord("A")) || keyboard_check_pressed(ord("D"))) {
            language_index = 1 - language_index;
        }
        
        if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
            global.language = (language_index == 0) ? "pt" : "en";
            scr_settings_save();
            
            if (global.seen_instructions) {
                room_goto(rm_menu);
            } else {
                boot_state = "instructions";
            }
        }
        break;
        
    case "instructions":
        if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
            global.seen_instructions = true;
            scr_settings_save();
            room_goto(rm_menu);
        }
        break;
}