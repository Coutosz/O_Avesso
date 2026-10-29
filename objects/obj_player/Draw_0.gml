if (invuln > 0 && (invuln div 4) mod 2 == 0) exit;
if (room == rm_menu || room == rm_boot) exit;
av_shadow(x, y, 7);
draw_sprite_ext(sprite_index, image_index, round(x), round(y), image_xscale, image_yscale, 0, image_blend, image_alpha);
