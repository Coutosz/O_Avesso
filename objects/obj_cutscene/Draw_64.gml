draw_set_font(fnt_main);
var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

// Escurecer a tela (noite, desmaio, etc.)
if (tint_alpha > 0) {
    draw_set_alpha(tint_alpha);
    draw_set_color(tint_col);
    draw_rectangle(0, 0, _gw, _gh, false);
    draw_set_alpha(1);
}

// Clarão
if (flash_alpha > 0) {
    draw_set_alpha(flash_alpha);
    draw_set_color(flash_col);
    draw_rectangle(0, 0, _gw, _gh, false);
    draw_set_alpha(1);
}

// Título grande (fim de ato, horário, etc.)
if (title_alpha > 0) {
    draw_set_alpha(title_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gw, _gh, false);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_transformed(_gw / 2, _gh / 2 - 10, title_text, 2, 2, 0);
    if (title_sub != "") draw_text(_gw / 2, _gh / 2 + 30, title_sub);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_alpha(1);
}

draw_set_color(c_white);
