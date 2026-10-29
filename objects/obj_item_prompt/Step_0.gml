if (!prompt_active) exit;

if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")) ||
    keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))) {
    prompt_index = 1 - prompt_index; 
}

if (keyboard_check_pressed(ord("Z"))) {
    if (prompt_index == 0 && instance_exists(prompt_target_item)) {
        if (scr_inventory_add(prompt_target_item.item_name)) {
            instance_destroy(prompt_target_item);
        }
       
    }
    
    prompt_active = false;
    prompt_target_item = noone;
}