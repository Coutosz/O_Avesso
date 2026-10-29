wob += 0.07;
blink -= 1;
if (blink < -8) blink = 120 + irandom(160);
if (dying > 0) { dying += 1; if (dying > 45) instance_destroy(); exit; }
if (lembrando > 0) { lembrando += 1; exit; }
if (touch_cd > 0) touch_cd -= 1;
if (!instance_exists(obj_player)) exit;

var _f = scr_faisca();
lit = (_f != noone) && point_distance(x, y - 10, _f.x, _f.y - 8) < _f.light_r * 0.85;
if (scripted) { depth = -y; exit; }
if (scr_is_blocking()) exit;

var _p = obj_player;
var _d = point_distance(x, y, _p.x, _p.y);
var _spd = lit ? spd_lit : spd_dark;

if (_d < 130) {
    // vem atrás da luz
    var _dir = point_direction(x, y, _p.x, _p.y);
    var _nx = x + lengthdir_x(_spd, _dir);
    var _ny = y + lengthdir_y(_spd, _dir);
    if (!place_meeting(_nx, y, obj_wall)) x = _nx;
    if (!place_meeting(x, _ny, obj_wall)) y = _ny;
} else if (point_distance(x, y, home_x, home_y) > 2) {
    // longe dela, volta devagar pro canto dele
    var _dir = point_direction(x, y, home_x, home_y);
    x += lengthdir_x(0.4, _dir);
    y += lengthdir_y(0.4, _dir);
}
depth = -y;

// Encostou: gela
if (_d < 11 && touch_cd <= 0 && _p.invuln <= 0) {
    touch_cd = 50;
    scr_apagado_toque(id);
}

// Arder: a Faísca brilhando forte bem em cima dele
if (_f != noone && _f.brilhando && point_distance(x, y - 10, _f.x, _f.y - 8) < 48) {
    burn += 1 / 150;
    if (burn >= 0.5 && !_f.avisou_arder) {
        _f.avisou_arder = true;
        scr_faisca_aviso();
    }
    if (burn >= 1) scr_apagado_arder(id);
} else {
    burn = max(0, burn - 1 / 90);
}
