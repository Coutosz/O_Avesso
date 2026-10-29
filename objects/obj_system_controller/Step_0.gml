if (keyboard_check_pressed(vk_f4)) {
    global.fullscreen_enabled = !global.fullscreen_enabled;
    window_set_fullscreen(global.fullscreen_enabled);
    if (!global.fullscreen_enabled) window_center();
    scr_settings_save();
}

if (keyboard_check(vk_escape)) {
    esc_hold_timer += 1;
    if (esc_hold_timer >= 120) { 
        game_end();
    }
} else {
    esc_hold_timer = 0;
}