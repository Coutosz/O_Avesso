if (silhueta == -1) exit;
var _w = sprite_get_width(silhueta);
var _h = sprite_get_height(silhueta);
var _rows = (sil_rows > 0) ? sil_rows : _h;
var _left = round(x) - sprite_get_xoffset(silhueta);
var _top = round(y) - sprite_get_yoffset(silhueta) - 4 + round(sin(wob) * 2);   // flutua um pouco
var _sh = (burn > 0) ? irandom_range(-1, 1) * ceil(burn * 2) : 0;

// fumacinha preta subindo
for (var i = 0; i < 4; i++) {
    var _t = (wob * 20 + i * 25) mod 100;
    draw_set_alpha((1 - _t / 100) * 0.7);
    draw_set_color(c_black);
    draw_point(_left + (i * 7 + 3) mod _w, _top - _t * 0.12);
}
draw_set_alpha(1);

var _col = merge_color(c_black, make_color_rgb(255, 120, 30), burn * 0.7);
var _a = 1;
if (dying > 0) { _col = make_color_rgb(255, 210, 110); _a = 1 - dying / 45; }
if (lembrando > 0) { _col = merge_color(c_black, c_white, min(1, lembrando / 50)); }

// o contorno do que ele foi, todo preto
draw_sprite_part_ext(silhueta, 0, 0, 0, _w, _rows, _left + _sh, _top, 1, 1, _col, _a);
// na luz dá pra adivinhar as cores de antes, bem de leve
if (lit && dying == 0) draw_sprite_part_ext(silhueta, 0, 0, 0, _w, _rows, _left + _sh, _top, 1, 1, c_white, 0.14 + lembrando / 120);

// virando poeira
if (dying > 0) {
    draw_set_color(make_color_rgb(255, 215, 120));
    for (var i = 0; i < 18; i++) {
        draw_point(_left + (i * 5) mod _w, _top + _rows - dying * (0.6 + (i mod 4) * 0.3) - (i * 3) mod 9);
    }
    draw_set_color(c_white);
}
