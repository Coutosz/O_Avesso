// Os olhos aparecem por cima do escuro: no breu, é só isso que se vê
if (silhueta == -1 || dying > 0 || lembrando > 0) exit;
if (blink < 0) exit;
var _rows = (sil_rows > 0) ? sil_rows : sprite_get_height(silhueta);
var _cx = round(x);
var _ey = round(y) - sprite_get_yoffset(silhueta) - 4 + round(sin(wob) * 2) + round(_rows * 0.42);
draw_set_color(make_color_rgb(255, 244, 200));
draw_rectangle(_cx - 3, _ey, _cx - 3, _ey + 1, false);
draw_rectangle(_cx + 2, _ey, _cx + 2, _ey + 1, false);
draw_set_color(c_white);
