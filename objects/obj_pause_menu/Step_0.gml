if (room == rm_menu) exit;

if (keyboard_check_pressed(ord("C")) && !obj_dialogue_manager.dialogue_active && !obj_item_prompt.prompt_active) {
    pause_active = !pause_active;
}

if (!pause_active) exit;

if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
    pause_tab = (pause_tab - 1 + array_length(pause_tab_names)) mod array_length(pause_tab_names);
}
if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
    pause_tab = (pause_tab + 1) mod array_length(pause_tab_names);
}