switch (boot_state) {
    case "logo":
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_text(display_get_gui_width() / 2, display_get_gui_height() / 2, "O AVESSO");
        draw_set_halign(fa_left);
        break;
        
    case "cutscene":
        draw_set_color(c_white);
        draw_text_ext(60, 200, cutscene_current_text, -1, 520);
        break;
        
    case "title":
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_text(display_get_gui_width() / 2, display_get_gui_height() / 2 - 20, "O AVESSO");
        if ((boot_timer div 30) mod 2 == 0) {
            draw_text(display_get_gui_width() / 2, display_get_gui_height() / 2 + 40, "PRESS ENTER");
        }
        draw_set_halign(fa_left);
        break;
        
    case "language":
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_text(display_get_gui_width() / 2, 180, "Escolha o idioma / Choose language");
        draw_set_color(language_index == 0 ? c_yellow : c_white);
        draw_text(display_get_gui_width() / 2 - 60, 220, "Português");
        draw_set_color(language_index == 1 ? c_yellow : c_white);
        draw_text(display_get_gui_width() / 2 + 60, 220, "English");
        draw_set_halign(fa_left);
        break;
        
    case "instructions":
        draw_set_color(c_white);
        draw_text(60, 100, scr_text("instructions_title"));
        draw_text(60, 140, scr_text("instructions_z"));
        draw_text(60, 160, scr_text("instructions_x"));
        draw_text(60, 180, scr_text("instructions_c"));
        draw_text(60, 200, scr_text("instructions_f4"));
        draw_text(60, 220, scr_text("instructions_esc"));
        draw_text(60, 260, scr_text("instructions_continue"));
        break;
}