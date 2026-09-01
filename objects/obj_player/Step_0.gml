if (interact_cooldown > 0) interact_cooldown -= 1;
if (obj_pause_menu.pause_active) exit;
var _left  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
var _right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _up    = keyboard_check(vk_up)    || keyboard_check(ord("W"));
var _down  = keyboard_check(vk_down)  || keyboard_check(ord("S"));

if (keyboard_check_pressed(ord("G"))) scr_add_gold(10);
if (keyboard_check_pressed(ord("H"))) scr_change_sanity(-10);

var _input_x = _right - _left;
var _input_y = _down - _up;

var _new_sprite = sprite_index;

if (_input_x != 0 || _input_y != 0) {
    var _dir = point_direction(0, 0, _input_x, _input_y);
    
    h_spd = lengthdir_x(move_spd, _dir);
    v_spd = lengthdir_y(move_spd, _dir);
    
    if (abs(_input_x) > abs(_input_y)) {
        face_dir = (_input_x > 0) ? "right" : "left";
    } else if (_input_y != 0) {
        face_dir = (_input_y > 0) ? "down" : "up";
    }
    
    switch (face_dir) {
        case "right": _new_sprite = spr_player_right; break;
        case "left":  _new_sprite = spr_player_left;  break;
        case "down":  _new_sprite = spr_player_down;  break;
        case "up":    _new_sprite = spr_player_up;    break;
    }
} else {
    h_spd = 0;
    v_spd = 0;
    _new_sprite = spr_player; // idle (facedir mantem a mesma direçao)
}

if (sprite_index != _new_sprite) {
    sprite_index = _new_sprite;
    image_index = 0;
}

// --- Movimento com colisão, eixo por eixo ---
if (!place_meeting(x + h_spd, y, obj_wall)) {
    x += h_spd;
} else {
    while (!place_meeting(x + sign(h_spd), y, obj_wall)) {
        x += sign(h_spd);
    }
}

if (!place_meeting(x, y + v_spd, obj_wall)) {
    y += v_spd;
} else {
    while (!place_meeting(x, y + sign(v_spd), obj_wall)) {
        y += sign(v_spd);
    }
}

// --- Interação (NPC ou Item) ---
if (keyboard_check_pressed(ord("Z")) && !obj_dialogue_manager.dialogue_active && !obj_item_prompt.prompt_active && interact_cooldown <= 0) {
    var _range = 20;
    var _check_x = x;
    var _check_y = y;
    
    switch (face_dir) {
        case "up":    _check_y -= _range; break;
        case "down":  _check_y += _range; break;
        case "left":  _check_x -= _range; break;
        case "right": _check_x += _range; break;
    }
    
    var _npc = instance_place(_check_x, _check_y, obj_npc);
    var _item = instance_place(x, y, obj_item); // item: checa embaixo do próprio personagem
    
    if (_npc != noone) {
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

// --- Salvar jogo ---
if (keyboard_check_pressed(ord("X")) && !obj_dialogue_manager.dialogue_active && !obj_item_prompt.prompt_active) {
    var _save_point = instance_place(x, y, obj_save);
    if (_save_point != noone) {
        scr_game_save();
        show_debug_message("JOGO SALVO!");
    } else {
        show_debug_message("Nenhum ponto de save aqui.");
    }
}

// --- Transição de Room ---
var _trigger = instance_place(x, y, obj_room_trigger);
if (_trigger != noone) {
    scr_fade_to_room(_trigger.target_room, _trigger.target_x, _trigger.target_y);
}

