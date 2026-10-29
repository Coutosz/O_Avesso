// Varanda: fio de luzinha pendurado (antes do escuro, pras lâmpadas furarem ele)
if (room_name == "rm_a1_varanda") scr_visual_varanda_luzes();

// Poeira dourada flutuando (salas do Avesso)
if (style.dust) {
    var _t = current_time / 1000;
    for (var i = 0; i < 28; i++) {
        var _px = (i * 97 + sin(_t * 0.5 + i) * 20) mod room_width;
        var _py = (i * 53 - _t * 6 * (1 + (i mod 3))) mod room_height;
        if (_py < 0) _py += room_height;
        draw_set_alpha(0.25 + 0.25 * sin(_t * 2 + i));
        draw_set_color(make_color_rgb(255, 215, 120));
        draw_point(_px, _py);
        if (i mod 4 == 0) draw_point(_px + 1, _py);
    }
    draw_set_alpha(1);
}

// Luzes da sala: { x, y, r, col, a } (ver scr_room_lights no scr_ato1)
var _lights = scr_room_lights(room_name);
var _pulse = 0.92 + 0.08 * sin(current_time / 420);

// No escuro do Avesso, a Faísca é a luz (ver scr_luz).
// Sozinha, a protagonista só enxerga um pouquinho em volta dela.
if (style.dark > 0) {
    var _f = scr_faisca();
    var _fl = 1 + 0.04 * sin(current_time / 90) + 0.03 * sin(current_time / 37);
    if (_f != noone) {
        array_push(_lights, { x: _f.x, y: _f.y - 8, r: _f.light_r * _fl, col: make_color_rgb(255, 170, 70), a: 1 });
    }
    // a Faísca ainda solta (cutscene): uma luzinha pequena
    with (obj_char) if (who == "faisca") array_push(_lights, { x: x, y: y - 10, r: 26 * _fl, col: make_color_rgb(255, 170, 70), a: 1 });
    if (style.dark >= 0.8 && instance_exists(obj_player)) {
        if (_f == noone) array_push(_lights, { x: obj_player.x, y: obj_player.y - 14, r: 34 + sin(current_time / 700) * 2, col: c_black, a: 0.8 });
        else array_push(_lights, { x: obj_player.x, y: obj_player.y - 14, r: 22, col: c_black, a: 0.7 });
    }
}

// Escuro (noite): uma camada escura com "furos" onde tem luz
if (style.dark > 0) {
    if (!surface_exists(light_surf)) light_surf = surface_create(room_width, room_height);
    surface_set_target(light_surf);
    draw_clear_alpha(style.dark_col, style.dark);
    gpu_set_blendmode(bm_subtract);
    for (var i = 0; i < array_length(_lights); i++) {
        var _l = _lights[i];
        draw_sprite_ext(spr_luz, 0, _l.x, _l.y, _l.r / 64, _l.r / 64, 0, c_white, _l.a * _pulse);
    }
    gpu_set_blendmode(bm_normal);
    surface_reset_target();
    draw_surface(light_surf, 0, 0);
}

// Brilho colorido das luzes (somado por cima)
gpu_set_blendmode(bm_add);
for (var i = 0; i < array_length(_lights); i++) {
    var _l = _lights[i];
    draw_sprite_ext(spr_luz, 0, _l.x, _l.y, _l.r / 64, _l.r / 64, 0, _l.col, 0.32 * _l.a * _pulse);
}
gpu_set_blendmode(bm_normal);
draw_set_color(c_white);
