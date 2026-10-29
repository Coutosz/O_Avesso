if (sprite_index == -1) exit;
var _floaty = (who == "faisca" || who == "ani");
var _oy = _floaty ? round(sin(bob) * 2) - 4 : 0;
av_shadow(x, y, _floaty ? 5 : min(9, sprite_width / 3));
draw_sprite_ext(sprite_index, image_index, round(x), round(y + _oy), image_xscale, image_yscale, 0, image_blend, image_alpha);
