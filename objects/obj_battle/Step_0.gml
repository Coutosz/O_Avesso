var _z = scr_key_confirm();
var _x = keyboard_check_pressed(ord("X"));
var _left = keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"));
var _right = keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"));
var _up = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
var _down = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));

if (enemy_shake > 0) enemy_shake -= 1;
if (dmg_timer > 0) dmg_timer -= 1;
if (invuln > 0) invuln -= 1;

// Ficou calma pela primeira vez: libera DESPEDIR e avisa
var _check_calm = function() {
    if (en.calm >= en.calm_max && !calm_told) {
        calm_told = true;
        array_push(menu, "despedir");
        return scr_lines(en.calm_key);
    }
    return [];
};

switch (state) {

    // ---------- Esperando uma fala terminar ----------
    case "text":
        if (!obj_dialogue_manager.dialogue_active) {
            state = next_state;
            if (state == "enemy_lines") {
                // fala antes do turno do inimigo (se tiver)
                if (turn < array_length(en.turn_lines)) {
                    battle_say(scr_lines(en.turn_lines[turn]), "dodge_start");
                } else {
                    state = "dodge_start";
                }
            }
        }
        break;

    // ---------- Menu principal ----------
    case "menu":
        var _n = array_length(menu);
        if (_left) menu_index = (menu_index - 1 + _n) mod _n;
        if (_right) menu_index = (menu_index + 1) mod _n;

        if (_z) {
            sub_index = 0;
            switch (menu[menu_index]) {
                case "atacar":
                    state = "attack";
                    bar_x = wx1 + 20;
                    bar_done = false;
                    bar_wait = 0;
                    break;

                case "conversar":
                    state = "talk";
                    break;

                case "lembrar":
                    var _list = [];
                    for (var i = 0; i < array_length(en.remember); i++) {
                        var _r = en.remember[i];
                        if (_r.need_flag == "" || scr_flag_get(_r.need_flag)) array_push(_list, _r);
                    }
                    remember_list = _list;
                    if (array_length(_list) == 0) battle_say([scr_text("bt_lembrar_vazio")], "menu");
                    else state = "remember";
                    break;

                case "item":
                    if (scr_inventory_count() == 0) battle_say(scr_lines("bt_item_vazio"), "menu");
                    else state = "item";
                    break;

                case "hesitar":
                    var _key = (en.hesitate_used == 0) ? en.hesitate_key : en.hesitate_key2;
                    en.hesitate_used += 1;
                    en.calm += en.hesitate_calm;
                    var _pages = scr_lines(_key);
                    var _extra = _check_calm();
                    for (var i = 0; i < array_length(_extra); i++) array_push(_pages, _extra[i]);
                    battle_say(_pages, "enemy_lines");
                    break;

                case "despedir":
                    result = "despedido";
                    battle_say(scr_lines(en.spare_key), "end");
                    break;
            }
        }
        break;

    // ---------- Conversar ----------
    case "talk":
        var _n = array_length(en.acts);
        if (_up) sub_index = (sub_index - 1 + _n) mod _n;
        if (_down) sub_index = (sub_index + 1) mod _n;
        if (_x) state = "menu";
        if (_z) {
            var _act = en.acts[sub_index];
            var _key = (_act.used == 0) ? _act.key : _act.key2;
            _act.used += 1;
            en.calm += _act.calm;
            var _pages = scr_lines(_key);
            var _extra = _check_calm();
            for (var i = 0; i < array_length(_extra); i++) array_push(_pages, _extra[i]);
            battle_say(_pages, "enemy_lines");
        }
        break;

    // ---------- Lembrar ----------
    case "remember":
        var _n = array_length(remember_list);
        if (_up) sub_index = (sub_index - 1 + _n) mod _n;
        if (_down) sub_index = (sub_index + 1) mod _n;
        if (_x) state = "menu";
        if (_z) {
            var _r = remember_list[sub_index];
            en.calm += _r.calm;
            var _pages = scr_lines(_r.key);
            var _extra = _check_calm();
            for (var i = 0; i < array_length(_extra); i++) array_push(_pages, _extra[i]);
            battle_say(_pages, "enemy_lines");
        }
        break;

    // ---------- Item ----------
    case "item":
        var _n = scr_inventory_count();
        if (_up) sub_index = (sub_index - 1 + _n) mod _n;
        if (_down) sub_index = (sub_index + 1) mod _n;
        if (_x) state = "menu";
        if (_z) {
            var _id = global.inventory[sub_index];
            var _heal = scr_item_heal(_id);
            if (_heal > 0) {
                global.hp = min(global.hp_max, global.hp + _heal);
                scr_inventory_remove(sub_index);
                var _ukey = "item_" + _id + "_usar";
                battle_say(variable_struct_exists(global.text_db, _ukey) ? scr_lines(_ukey) : [scr_text("bt_cura")], "enemy_lines");
            } else {
                battle_say([scr_item_name(_id) + "..."], "menu");
            }
        }
        break;

    // ---------- Barra de ataque ----------
    case "attack":
        var _bar_l = wx1 + 20;
        var _bar_r = wx2 - 20;
        if (!bar_done) {
            bar_x += 7;
            if (_z || bar_x >= _bar_r) {
                bar_done = true;
                bar_wait = 30;
                var _center = (_bar_l + _bar_r) / 2;
                var _acc = 1 - clamp(abs(bar_x - _center) / ((_bar_r - _bar_l) / 2), 0, 1);
                var _dmg = (bar_x >= _bar_r) ? 0 : max(1, round(6 * _acc));
                attack_dmg = _dmg;
                if (_dmg > 0) {
                    en.hp -= _dmg;
                    enemy_shake = 20;
                    dmg_text = string(_dmg);
                } else {
                    dmg_text = "...";
                }
                dmg_timer = 50;
            }
        } else {
            bar_wait -= 1;
            if (bar_wait <= 0) {
                if (attack_dmg <= 0) {
                    battle_say([scr_text("bt_errou")], "enemy_lines");
                } else if (en.hp <= 0) {
                    result = "apagado";
                    state = "erase";
                } else {
                    battle_say(scr_lines(en.hit_key), "enemy_lines");
                }
            }
        }
        break;

    // ---------- Começo do turno do inimigo ----------
    case "dodge_start":
        bullets = [];
        dodge_t = 0;
        soul_x = (bx1 + bx2) / 2;
        soul_y = (by1 + by2) / 2;
        soul_trail = [];
        state = "dodge";
        break;

    // ---------- Turno do inimigo: desviar ----------
    case "dodge":
        dodge_t += 1;

        var _mx = keyboard_check(vk_right) - keyboard_check(vk_left) + keyboard_check(ord("D")) - keyboard_check(ord("A"));
        var _my = keyboard_check(vk_down) - keyboard_check(vk_up) + keyboard_check(ord("S")) - keyboard_check(ord("W"));
        _mx = clamp(_mx, -1, 1);
        _my = clamp(_my, -1, 1);
        soul_x = clamp(soul_x + _mx * soul_spd, bx1 + 6, bx2 - 6);
        soul_y = clamp(soul_y + _my * soul_spd, by1 + 6, by2 - 6);

        array_insert(soul_trail, 0, [soul_x, soul_y]);
        if (array_length(soul_trail) > 8) array_resize(soul_trail, 8);

        scr_battle_pattern(id, en.pattern, dodge_t);

        for (var i = array_length(bullets) - 1; i >= 0; i--) {
            var _bl = bullets[i];
            scr_battle_bullet_step(_bl);

            if (point_distance(soul_x, soul_y, _bl.x, _bl.y) < _bl.r + 3) {
                if (scr_battle_bullet_hurts(_bl)) {
                    if (invuln <= 0) {
                        global.hp = max(0, global.hp - en.dmg);
                        invuln = 40;
                    }
                } else {
                    global.hp = min(global.hp_max, global.hp + 1);
                }
                array_delete(bullets, i, 1);
                continue;
            }

            if (_bl.y > by2 + 8 || _bl.y < by1 - 40 || _bl.x < bx1 - 40 || _bl.x > bx2 + 40) {
                array_delete(bullets, i, 1);
            }
        }

        if (global.hp <= 0) {
            state = "gameover";
            bullets = [];
            break;
        }

        if (dodge_t >= en.turn_len) {
            bullets = [];
            turn += 1;
            state = "menu";
        }
        break;

    // ---------- Apagando o Eco ----------
    case "erase":
        enemy_alpha -= 0.01;
        if (enemy_alpha <= 0) {
            enemy_alpha = 0;
            battle_say(scr_lines(en.erase_key), "end");
        }
        break;

    // ---------- Fim ----------
    case "end":
        global.battle_result = result;
        if (result == "despedido") {
            scr_flag_set("caderno_" + en.id, true);
            scr_change_sanity(10);
        } else if (result == "apagado") {
            scr_flag_set("apagado_" + en.id, true);
            scr_flag_add("ecos_apagados", 1);
            scr_change_sanity(-20);
        }
        with (obj_dialogue_manager) { box_x = 40; box_y = 340; box_w = 560; box_h = 100; }
        instance_destroy();
        break;

    // ---------- Game over ----------
    case "gameover":
        if (_z) {
            with (obj_dialogue_manager) { box_x = 40; box_y = 340; box_w = 560; box_h = 100; dialogue_active = false; }
            with (obj_cutscene) { queue = []; waiting = ""; }
            global.cutscene_active = false;
            global.hp = global.hp_max;
            instance_destroy();
            if (!scr_game_load()) room_goto(rm_menu);
        }
        break;
}
