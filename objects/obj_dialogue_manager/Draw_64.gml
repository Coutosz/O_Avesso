if (!dialogue_active) exit;

var _box_x = 40;
var _box_y = 340;
var _box_w = 560;
var _box_h = 100;

draw_set_color(c_black);
draw_rectangle(_box_x, _box_y, _box_x + _box_w, _box_y + _box_h, false);

draw_set_color(c_white);
draw_rectangle(_box_x, _box_y, _box_x + _box_w, _box_y + _box_h, true);

draw_set_color(c_white);
draw_text(_box_x + 20, _box_y + 20, dialogue_current_text);