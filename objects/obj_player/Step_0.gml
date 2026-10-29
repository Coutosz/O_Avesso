if (interact_cooldown > 0) interact_cooldown -= 1;
if (invuln > 0) invuln -= 1;
depth = -y;

// Rastro pros seguidores (grava também quando a cutscene move ela)
if (x != last_x || y != last_y) {
    array_insert(trail, 0, [x, y, face_dir]);
    if (array_length(trail) > 90) array_resize(trail, 90);
    last_x = x;
    last_y = y;
}

// Em cutscene / diálogo / menu: só atualiza o sprite (anda se a cutscene estiver movendo ela)
if (scr_is_blocking()) {
    scr_player_anim(cs_moving);
    exit;
}

var _left  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
var _right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _up    = keyboard_check(vk_up)    || keyboard_check(ord("W"));
var _down  = keyboard_check(vk_down)  || keyboard_check(ord("S"));

if (global.debug) {
    if (keyboard_check_pressed(ord("G"))) scr_add_gold(10);
    if (keyboard_check_pressed(ord("H"))) scr_change_sanity(-10);
}

var _input_x = _right - _left;
var _input_y = _down - _up;

var _moving = (_input_x != 0 || _input_y != 0);

if (_moving) {
    var _dir = point_direction(0, 0, _input_x, _input_y);

    h_spd = lengthdir_x(move_spd, _dir);
    v_spd = lengthdir_y(move_spd, _dir);

    if (abs(_input_x) > abs(_input_y)) {
        face_dir = (_input_x > 0) ? "right" : "left";
    } else if (_input_y != 0) {
        face_dir = (_input_y > 0) ? "down" : "up";
    }
} else {
    h_spd = 0;
    v_spd = 0;
}

scr_player_anim(_moving);

// Colisão eixo a eixo (paredes, móveis sólidos, personagens e buracos)
if (!scr_solid_at(x + h_spd, y)) {
    x += h_spd;
} else {
    while (!scr_solid_at(x + sign(h_spd), y)) {
        x += sign(h_spd);
    }
}

if (!scr_solid_at(x, y + v_spd)) {
    y += v_spd;
} else {
    while (!scr_solid_at(x, y + sign(v_spd))) {
        y += sign(v_spd);
    }
}


// Interagir (Z)
if (keyboard_check_pressed(ord("Z")) && interact_cooldown <= 0) {
    var _range = 20;
    var _check_x = x;
    var _check_y = y;

    switch (face_dir) {
        case "up":    _check_y -= _range; break;
        case "down":  _check_y += _range; break;
        case "left":  _check_x -= _range; break;
        case "right": _check_x += _range; break;
    }

    var _thing = instance_place(_check_x, _check_y, obj_interact);
    if (_thing == noone) _thing = instance_place(x, y, obj_interact);
    var _buddy = instance_place(_check_x, _check_y, obj_follower);
    var _npc = instance_place(_check_x, _check_y, obj_npc);
    var _item = instance_place(x, y, obj_item);

    // Apagado na frente: tentar fazer ele lembrar (ver scr_luz)
    var _ap = instance_nearest(_check_x, _check_y, obj_apagado);
    if (_ap != noone && (point_distance(_check_x, _check_y, _ap.x, _ap.y) > 22 || _ap.dying > 0 || _ap.lembrando > 0)) _ap = noone;

    if (_ap != noone) {
        scr_apagado_lembrar(_ap);
    } else if (_thing != noone && _thing.event != "") {
        scr_event_run(_thing.event, _thing);
    } else if (_buddy != noone) {
        scr_event_run("talk_" + _buddy.who, _buddy);
    } else if (_npc != noone) {
        if (scr_flag_get(_npc.npc_flag_name)) {
            scr_dialogue_start(_npc.dialogue_pages_repeat);
        } else {
            scr_dialogue_start(_npc.dialogue_pages_first);
            scr_flag_set(_npc.npc_flag_name, true);
        }
    } else if (_item != noone) {
        obj_item_prompt.prompt_active = true;
        obj_item_prompt.prompt_text = "Pegar " + _item.item_name + "?";
        obj_item_prompt.prompt_index = 0;
        obj_item_prompt.prompt_target_item = _item;
    }
}


if (keyboard_check_pressed(ord("X")) && scr_faisca() == noone) {
    var _save_point = instance_place(x, y, obj_save);
    if (_save_point != noone) {
        scr_game_save();
        show_debug_message("JOGO SALVO!");
    }
}


// Portas para outras salas. Se a porta tiver require_flag e a flag ainda for false,
// roda o blocked_event (ex.: "ainda não dá pra sair") e empurra ela de volta.
var _trigger = instance_place(x, y, obj_room_trigger);
if (_trigger != noone) {
    if (_trigger.require_flag != "" && !scr_flag_get(_trigger.require_flag)) {
        x -= h_spd * 8;
        y -= v_spd * 8;
        if (_trigger.blocked_event != "") scr_event_run(_trigger.blocked_event, _trigger);
    } else {
        scr_fade_to_room(_trigger.target_room, _trigger.target_x, _trigger.target_y);
    }
}
