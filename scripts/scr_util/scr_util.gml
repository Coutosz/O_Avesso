// =====================================================================
// Utilidades gerais: bloqueio do jogador, colisão, flags, grupo e itens
// =====================================================================

// Z / Enter (o teste automático aperta sozinho)
function scr_key_confirm() {
    if (global.autotest_mode > 0) return !(variable_global_exists("autotest_hold") && global.autotest_hold);
    return keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter);
}

// true quando o jogador não deve andar nem interagir
function scr_is_blocking() {
    if (instance_exists(obj_battle)) return true;
    if (global.cutscene_active) return true;
    if (instance_exists(obj_dialogue_manager) && obj_dialogue_manager.dialogue_active) return true;
    if (instance_exists(obj_item_prompt) && obj_item_prompt.prompt_active) return true;
    if (instance_exists(obj_pause_menu) && obj_pause_menu.pause_active) return true;
    if (variable_global_exists("fade_state") && global.fade_state != "none") return true;
    return false;
}

// Tem coisa sólida nessa posição? (chamar de dentro da instância que está andando)
function scr_solid_at(_x, _y) {
    if (place_meeting(_x, _y, obj_wall)) return true;
    if (place_meeting(_x, _y, obj_interact_solid)) return true;
    var _gap = instance_place(_x, _y, obj_abismo);
    if (_gap != noone && !_gap.bridged) return true;
    return false;
}

function scr_flag_add(_name, _amount) {
    scr_flag_set(_name, scr_flag_get(_name) + _amount);
}

// ---------- Personagens ----------

// Sprite de cada personagem pelo nome
function scr_char_sprite(_who) {
    switch (_who) {
        case "nana":     return spr_nana;
        case "faisca":   return spr_faisca;
        case "espinho":  return spr_espinho;
        case "fio":      return spr_fio;
        case "mae":      return spr_mae;
        case "pai":      return spr_pai;
        case "ani":      return spr_ani;
        case "relogio":  return spr_relogio;
        case "vasinho":  return spr_vasinho;
        case "anima":    return spr_anima;
        case "ferro":    return spr_ferro;   // Ferro = Ai Shiteru
        case "ai_shiteru": return spr_ferro;
        case "verniz":   return spr_verniz;
        case "campeao":  return spr_campeao;
        case "vela":     return spr_vela;
        case "sombrinha": return spr_sombrinha;
    }
    return spr_npc;
}

// Cria um personagem parado na sala (pra cutscene mexer nele)
function scr_char_spawn(_who, _x, _y) {
    var _c = instance_create_depth(_x, _y, -_y, obj_char);
    _c.who = _who;
    _c.sprite_index = scr_char_sprite(_who);
    _c.event = "talk_" + _who;
    return _c;
}

// ---------- Grupo (quem anda atrás da protagonista) ----------

function scr_party_has(_who) {
    for (var i = 0; i < array_length(global.party); i++) {
        if (global.party[i] == _who) return true;
    }
    return false;
}

// Entra no grupo. Se o personagem estiver parado na sala, ele vira seguidor no mesmo lugar.
// Bíblia v6: só a Faísca anda atrás da protagonista. Os outros ficam onde estão (só marca que você conhece).
function scr_party_add(_who) {
    if (_who != "faisca") { scr_flag_set("conhece_" + _who, true); return; }
    if (scr_party_has(_who)) return;
    array_push(global.party, _who);

    var _x = instance_exists(obj_player) ? obj_player.x : 0;
    var _y = instance_exists(obj_player) ? obj_player.y : 0;
    with (obj_char) {
        if (who == _who) { _x = x; _y = y; instance_destroy(); }
    }

    var _f = instance_create_depth(_x, _y, -_y, obj_follower);
    _f.who = _who;
    _f.slot = array_length(global.party) - 1;
    _f.sprite_index = scr_char_sprite(_who);
}

// Sai do grupo. Deixa o personagem parado onde estava (vira obj_char).
function scr_party_remove(_who) {
    for (var i = array_length(global.party) - 1; i >= 0; i--) {
        if (global.party[i] == _who) array_delete(global.party, i, 1);
    }

    with (obj_follower) {
        if (who == _who) {
            scr_char_spawn(_who, x, y);
            instance_destroy();
        }
    }

    // Reorganiza a fila de quem ficou
    with (obj_follower) {
        for (var i = 0; i < array_length(global.party); i++) {
            if (global.party[i] == who) slot = i;
        }
    }
}

// ---------- Itens ----------
// O inventário guarda IDs ("marmita"). O nome que aparece vem do text_db (item_<id>).

function scr_item_name(_id) {
    var _key = "item_" + _id;
    if (variable_struct_exists(global.text_db, _key)) return scr_text(_key);
    return _id; // itens antigos de teste guardavam o nome direto
}

// Quanto o item cura (0 = não é de comer)
function scr_item_heal(_id) {
    switch (_id) {
        case "marmita": return 99;
    }
    return 0;
}

function scr_inventory_remove(_index) {
    global.inventory[_index] = "";
    // empurra os itens pra frente, sem buraco no meio
    var _items = [];
    for (var i = 0; i < array_length(global.inventory); i++) {
        if (global.inventory[i] != "") array_push(_items, global.inventory[i]);
    }
    for (var i = 0; i < array_length(global.inventory); i++) {
        global.inventory[i] = (i < array_length(_items)) ? _items[i] : "";
    }
}

function scr_inventory_count() {
    var _n = 0;
    for (var i = 0; i < array_length(global.inventory); i++) {
        if (global.inventory[i] != "") _n++;
    }
    return _n;
}

// Sprite da protagonista virada pra direção certa. Andando: anima; parada: primeiro quadro.
function scr_player_anim(_moving) {
    // Pose de cutscene (deitada, levantando, batendo a poeira...): fica parada nela
    if (pose_spr != -1) {
        sprite_index = pose_spr;
        image_index = pose_img;
        image_speed = 0;
        anim_x = x; anim_y = y;
        return;
    }
    var _spr = spr_player_down;
    switch (face_dir) {
        case "right": _spr = spr_player_right; break;
        case "left":  _spr = spr_player_left;  break;
        case "up":    _spr = spr_player_up;    break;
    }
    if (sprite_index != _spr) sprite_index = _spr;
    image_speed = 0;

    // O pé troca pela distância andada, não pelo tempo: assim ela não escorrega.
    // Frame 0 = parada; 1..4 = passo, meio, outro passo, meio.
    var _d = point_distance(x, y, anim_x, anim_y);
    if (_d > 12) _d = 0;   // teleporte
    anim_x = x; anim_y = y;
    if (_moving) {
        anim_dist += (_d > 0.05) ? _d : 0.6;   // empurrando a parede: anda no lugar, mais devagar
        var _f = 1 + (floor(anim_dist / 7) mod 4);
        if (_f != image_index && (_f == 1 || _f == 3)) {
            var _g = (string_pos("rm_a1_", room_get_name(room)) == 1) ? 0.16 : 0.08;
            audio_play_sound(snd_passo, 1, false, _g, 0, random_range(0.88, 1.08));
        }
        image_index = _f;
    } else {
        image_index = 0;
        anim_dist = 0;
    }
}
