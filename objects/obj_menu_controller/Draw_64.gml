scr_visual_title();
draw_set_font(global.fnt_dialog);
if (menu_state == "naming") {
    av_panel(112, 290, 416, 120, true);
    draw_set_halign(fa_center);
    draw_set_color(make_color_rgb(235, 217, 187));
    draw_text(320, 308, global.language == "en" ? "What is your name?" : "Qual é o seu nome?");
    draw_set_color(make_color_rgb(249, 193, 99));
    draw_text(320, 357, player_name_input + ((current_time div 400) mod 2 == 0 ? "_" : ""));
    draw_set_color(make_color_rgb(151, 132, 137));
    draw_text(320, 436, "ENTER");
    draw_set_halign(fa_left);
    exit;
}
// Opções embaixo, sem caixa, na fonte pixel da tela inicial. A chaminha marca a escolhida.
for (var i = 0; i < array_length(menu_options); i++) {
    var _selected = (i == menu_index && menu_enabled[i]);
    var _my = 402 + i * 26;
    var _label = (i == 0) ? (global.language == "en" ? "Continue" : "Continuar") : (global.language == "en" ? "New game" : "Novo jogo");
    var _col = !menu_enabled[i] ? make_color_rgb(78, 68, 86) : (_selected ? make_color_rgb(255, 200, 100) : make_color_rgb(238, 224, 196));
    scr_pixtext(320, _my, _label, _col, 2, fa_center);
    if (_selected) {
        var _fx = 320 - scr_pixtext_width(string_upper(_label), 2) div 2 - 20;
        scr_pix_flame((_fx div 2) * 2, _my - 2 + ((current_time div 250) mod 2) * 2, 2);
    }
}
draw_set_halign(fa_left);
draw_set_color(c_white);
