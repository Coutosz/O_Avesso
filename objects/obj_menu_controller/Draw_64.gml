if (menu_state == "naming") {
    draw_set_color(c_black);
    draw_rectangle(120, 180, 520, 260, false);
    draw_set_color(c_white);
    draw_rectangle(120, 180, 520, 260, true);
    
    draw_text(140, 200, "Qual é o seu nome?");
    draw_text(140, 225, player_name_input + "_");
    exit;
}

var _start_x = 260;
var _start_y = 200;
var _spacing = 40;

for (var i = 0; i < array_length(menu_options); i++) {
    var _y = _start_y + (i * _spacing);
    
    if (!menu_enabled[i]) {
        draw_set_color(c_gray); // opção desabilitada
    } else if (i == menu_index) {
        draw_set_color(c_yellow); // opção selecionada
    } else {
        draw_set_color(c_white); // opção normal
    }
    
    draw_text(_start_x, _y, menu_options[i]);
}