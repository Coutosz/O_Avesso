// Segue o rastro da protagonista (o rastro é gravado pelo obj_player)
bob += 0.08;

if (who == "faisca") {
    // Brilhar: segurar X. Ela cansa e fica pequenininha um tempo.
    var _quer = keyboard_check(ord("X")) && !scr_is_blocking() && cansada <= 0;
    if (variable_global_exists("autotest_brilhar") && global.autotest_mode > 0) _quer = global.autotest_brilhar && !scr_is_blocking() && cansada <= 0;
    brilhando = _quer && energia > 0;
    if (brilhando) {
        energia -= 0.55;
        if (energia <= 0) { energia = 0; brilhando = false; cansada = 180; }
    } else {
        energia = min(100, energia + 0.35);
    }
    if (cansada > 0) cansada -= 1;
    if (distante > 0) distante -= 1;
    if (medo > 0) medo -= 1;
    if (pet_t > 0) pet_t -= 1;

    var _alvo = 46;
    if (brilhando) _alvo = 86;
    if (cansada > 0) _alvo = 26;
    if (medo > 0) _alvo -= 8;
    light_r = lerp(light_r, _alvo, 0.15);

    // no escuro ela anda colada em você; depois de Arder, anda longe
    spacing = 14;
    if (scr_room_is_dark()) spacing = 7;
    if (distante > 0) spacing = 26;
}

if (instance_exists(obj_player) && !cs_moving) {
    var _trail = obj_player.trail;
    var _i = (slot + 1) * spacing;
    if (_i >= array_length(_trail)) _i = array_length(_trail) - 1;
    if (_i >= 0) {
        var _p = _trail[_i];
        if (_p[0] != x || _p[1] != y) {
            face_dir = _p[2];
        }
        x = _p[0];
        y = _p[1];
    }
}

depth = -y;
