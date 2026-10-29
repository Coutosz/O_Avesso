// Navegação (pula opções desabilitadas)
if (menu_state == "naming") {
    keyboard_string = string_copy(keyboard_string, 1, 12); // limita a 12 caracteres
    player_name_input = keyboard_string;
    
    if (keyboard_check_pressed(vk_backspace)) {
        player_name_input = string_delete(player_name_input, string_length(player_name_input), 1);
        keyboard_string = player_name_input;
    }
    
    if (keyboard_check_pressed(vk_enter) && string_length(player_name_input) > 0) {
        global.player_name = player_name_input;
        global.gold = 0;
        global.lvl = 1;
        global.hp = global.hp_max;
        global.sanity = 0; // Gratidão começa vazia e sobe com as escolhas
        global.inventory = array_create(8, "");
        global.flags = {};
        global.party = [];
        
        keyboard_string = "";
        menu_state = "select";
        scr_fade_to_room(rm_casa_quarto, 130, 132); // começa o Prólogo no quarto
    }
    exit;
}
if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
    do {
        menu_index = (menu_index + 1) mod array_length(menu_options);
    } until (menu_enabled[menu_index]);
}

if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
    do {
        menu_index = (menu_index - 1 + array_length(menu_options)) mod array_length(menu_options);
    } until (menu_enabled[menu_index]);
}

// Confirmar
if (keyboard_check_pressed(ord("Z"))) {
    if (menu_enabled[menu_index]) {
        switch (menu_options[menu_index]) {
   case "New Game":
    keyboard_string = "";
    player_name_input = "";
    menu_state = "naming";
    break;
				
				room_goto(Inicio); 
                break;
            case "Continue":
    scr_game_load();
    break;
        }
    }
}