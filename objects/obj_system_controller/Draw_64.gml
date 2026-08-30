if (keyboard_check(vk_escape) && esc_hold_timer > 0) {
    var _seconds_left = ceil((120 - esc_hold_timer) / 60);
    
    draw_set_color(c_white);
    draw_set_halign(fa_right);
    draw_text(display_get_gui_width() - 10, 10, "Fechando jogo " + string(_seconds_left) + "...");
    draw_set_halign(fa_left); // reseta o alinhamento, senão bagunça qualquer outro texto desenhado depois desse
}