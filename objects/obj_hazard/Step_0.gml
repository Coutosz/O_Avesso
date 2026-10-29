depth = -y;

if (leaving) {
    // sai rangendo pra cima e some
    y -= 2;
    image_alpha -= 0.01;
    if (image_alpha <= 0) instance_destroy();
    exit;
}

if (scr_is_blocking()) exit;

if (pause_timer > 0) {
    pause_timer -= 1;
    exit;
}

y += spd;
if (y > y_bottom) {
    y = y_top;
    pause_timer = pause;
}

// Atropelou a protagonista: empurra pra trás e tira 1 de HP (nunca deixa zerar)
if (instance_exists(obj_player) && place_meeting(x, y, obj_player) && obj_player.invuln <= 0) {
    with (obj_player) {
        invuln = 50;
        var _push = (x < other.x) ? -24 : 24;
        var _steps = abs(_push);
        repeat (_steps) {
            if (!scr_solid_at(x + sign(_push), y)) x += sign(_push);
        }
    }
    global.hp = max(1, global.hp - 1);
    scr_flag_add("a1_escorregador_hits", 1);
}
