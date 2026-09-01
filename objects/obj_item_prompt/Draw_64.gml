draw_set_font(fnt_main)
if (!prompt_active) exit;

var _box_x = 160;
var _box_y = 340;
var _box_w = 320;
var _box_h = 80;

draw_set_color(c_black);
draw_rectangle(_box_x, _box_y, _box_x + _box_w, _box_y + _box_h, false);
draw_set_color(c_white);
draw_rectangle(_box_x, _box_y, _box_x + _box_w, _box_y + _box_h, true);

draw_text(_box_x + 20, _box_y + 15, prompt_text);

draw_set_color(prompt_index == 0 ? c_yellow : c_white);
draw_text(_box_x + 20, _box_y + 45, "Sim");

draw_set_color(prompt_index == 1 ? c_yellow : c_white);
draw_text(_box_x + 100, _box_y + 45, "Não");