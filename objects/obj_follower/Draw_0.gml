if (sprite_index == -1) exit;
var _floaty = (who == "faisca" || who == "ani");
var _oy = _floaty ? round(sin(bob) * 2) - 4 : 0;
av_shadow(x, y, _floaty ? 5 : min(9, sprite_width / 3));

if (who != "faisca") {
    draw_sprite_ext(sprite_index, image_index, round(x), round(y + _oy), image_xscale, image_yscale, 0, image_blend, image_alpha);
    exit;
}

// A Faísca mostra o que sente no tamanho e na cor
var _s = 1;
var _col = c_white;
if (brilhando) _s = 1.15 + sin(current_time / 60) * 0.03;
if (cansada > 0) { _s = 0.7; _col = make_color_rgb(255, 170, 120); }
if (medo > 0) { _s = min(_s, 0.82); _col = make_color_rgb(230, 120, 80); }
if (distante > 0) _col = merge_color(_col, make_color_rgb(150, 170, 255), 0.35);

// carinho: pulinho e rodopio (vira de um lado pro outro)
var _xs = 1;
if (pet_t > 0) {
    _oy -= round(abs(sin(pet_t / 6)) * 5);
    _xs = (pet_t div 6) mod 2 == 0 ? 1 : -1;
}

draw_sprite_ext(sprite_index, image_index, round(x), round(y + _oy), _xs * _s, _s, 0, _col, 1);

// faisquinhas (carinho ou brilhando forte)
if (pet_t > 0 || brilhando) {
    draw_set_color(make_color_rgb(255, 220, 120));
    for (var i = 0; i < 5; i++) {
        var _t = (current_time / 8 + i * 37) mod 60;
        draw_point(round(x) + ((i * 11) mod 21) - 10, round(y + _oy) - 12 - _t * 0.4);
    }
    draw_set_color(c_white);
}

// quanto ela ainda aguenta brilhar (só aparece quando não tá cheia)
if (energia < 99 && scr_room_is_dark()) {
    var _bx = round(x) - 7, _by = round(y + _oy) - sprite_height - 6;
    draw_set_color(c_black);
    draw_rectangle(_bx - 1, _by - 1, _bx + 14, _by + 1, false);
    draw_set_color(cansada > 0 ? make_color_rgb(140, 80, 60) : make_color_rgb(255, 196, 80));
    if (energia > 0) draw_rectangle(_bx, _by, _bx + round(13 * energia / 100), _by, false);
    draw_set_color(c_white);
}
