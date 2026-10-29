if (sprite_index == -1) exit;
if (event == "p_desenho") { av_drawing(round(x), round(y)); exit; }
if (sprite_index != spr_calendario && sprite_index != spr_varal_luz && sprite_index != spr_porta) {
    av_shadow(x, y, min(18, sprite_width * 0.38));
}
draw_sprite_ext(sprite_index, image_index, round(x), round(y), image_xscale, image_yscale, 0, image_blend, image_alpha);
if (variable_instance_exists(id, "visual_decor") && visual_decor && sprite_index == spr_mesa) {
    av_rect(x - 12, y - 43, x + 12, y - 26, make_color_rgb(164, 109, 56));
    av_drawing(x, y - 26);
    av_rect(x + 14, y - 40, x + 20, y - 35, make_color_rgb(126, 145, 124));
}
