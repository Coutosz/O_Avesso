// =====================================================================
// SISTEMA DE CUTSCENE
// Uma cutscene é um array de comandos. Cada comando é um array: ["tipo", argumentos...]
// Os comandos rodam um depois do outro; os que "esperam" (fala, andar, trocar de sala...)
// seguram a fila até terminar. Enquanto tem cutscene rodando, o jogador não se mexe.
//
// Comandos:
//   ["say", "chave"]                    mostra um bloco de falas do text_db
//   ["ask", "chave_falas", "chave_opcoes"] falas + escolha no fim (resultado em global.choice)
//   ["float", "chave"]                  texto solto no meio da tela
//   ["branch", [cmds0], [cmds1], ...]   roda o bloco da escolha feita no último "ask"
//   ["if", funcao, [cmds_sim], [cmds_nao]]
//   ["flag", "nome", valor]   ["add", "nome", quantidade]
//   ["wait", frames]
//   ["move", alvo, x, y, velocidade]    alvo: "player", "nana", "faisca"... ou uma instância
//   ["teleport", alvo, x, y]   ["face", alvo, "up"/"down"/"left"/"right"]
//   ["goto", sala, x, y]                troca de sala com fade e espera
//   ["darken", alfa, cor]               escurece a tela (0 = normal, 1 = preto) e espera
//   ["shake", frames]   ["flash", cor]
//   ["title", "chave", frames, "chave_sub"]  texto grande no meio da tela
//   ["battle", "id_inimigo"]            abre uma batalha e espera (resultado em global.battle_result)
//   ["party_add", "quem"]   ["party_remove", "quem"]
//   ["spawn", "quem", x, y]   ["destroy", alvo]   ["sprite", alvo, sprite, frame]
//   ["item", "id"]   ["sanity", n]   ["heal"]   ["save"]
//   ["call", funcao]
//   ["pose", "player", sprite, frame]   prende a protagonista num desenho (["pose", "player", -1] solta)
//   ["sound", som, volume]              ["silence", frames] (o barulho de fundo para, ver scr_som)
// =====================================================================

function cs_start(_cmds) {
    with (obj_cutscene) {
        if (global.cutscene_active) {
            // Já tem uma rodando: enfileira no final
            for (var i = 0; i < array_length(_cmds); i++) array_push(queue, _cmds[i]);
        } else {
            queue = [];
            for (var i = 0; i < array_length(_cmds); i++) array_push(queue, _cmds[i]);
            waiting = "";
            global.cutscene_active = true;
        }
    }
}

// Coloca comandos no começo da fila (usado pelo "branch" e pelo "if")
function cs_insert(_cmds) {
    for (var i = array_length(_cmds) - 1; i >= 0; i--) array_insert(queue, 0, _cmds[i]);
}

// Acha a instância de um personagem pelo nome ("player", "nana", ...)
function cs_resolve(_target) {
    if (!is_string(_target)) return _target;
    if (_target == "player") return instance_exists(obj_player) ? obj_player.id : noone;

    var _found = noone;
    with (obj_follower) if (who == _target) _found = id;
    if (_found != noone) return _found;
    with (obj_char) if (who == _target) _found = id;
    if (_found != noone) return _found;
    with (obj_apagado) if (ap_id == _target) _found = id;
    return _found;
}

function cs_exec(_c) {
    var _n = array_length(_c);
    switch (_c[0]) {
        case "say":
            scr_dialogue_start(scr_lines(_c[1]));
            waiting = "dialogue";
            break;

        case "ask":
            scr_dialogue_start(scr_lines(_c[1]), scr_options(_c[2]));
            waiting = "dialogue";
            break;

        case "float":
            scr_dialogue_start(scr_lines(_c[1]), [], true);
            waiting = "dialogue";
            break;

        case "branch":
            var _pick = global.choice + 1;
            if (_pick < _n) cs_insert(_c[_pick]);
            break;

        case "if":
            if (_c[1]()) cs_insert(_c[2]);
            else if (_n > 3) cs_insert(_c[3]);
            break;

        case "flag":
            scr_flag_set(_c[1], _c[2]);
            break;

        case "add":
            scr_flag_add(_c[1], _c[2]);
            break;

        case "wait":
            wait_timer = _c[1];
            waiting = "wait";
            break;

        case "move":
            move_target = cs_resolve(_c[1]);
            move_x = _c[2];
            move_y = _c[3];
            move_spd = (_n > 4) ? _c[4] : 1.5;
            if (instance_exists(move_target)) waiting = "move";
            break;

        case "teleport":
            var _t = cs_resolve(_c[1]);
            if (instance_exists(_t)) { _t.x = _c[2]; _t.y = _c[3]; }
            break;

        case "face":
            var _t = cs_resolve(_c[1]);
            if (instance_exists(_t)) _t.face_dir = _c[2];
            break;

        case "goto":
            scr_fade_to_room(_c[1], _c[2], _c[3]);
            waiting = "room";
            break;

        case "darken":
            tint_target = _c[1];
            if (_n > 2) tint_col = _c[2];
            waiting = "tint";
            break;

        case "shake":
            shake = _c[1];
            break;

        case "flash":
            flash_alpha = 1;
            flash_col = (_n > 1) ? _c[1] : c_white;
            break;

        case "title":
            title_text = scr_text(_c[1]);
            title_hold = (_n > 2) ? _c[2] : 120;
            title_sub = (_n > 3) ? scr_text(_c[3]) : "";
            title_alpha = 0;
            title_state = "in";
            waiting = "title";
            break;

        case "battle":
            instance_create_depth(0, 0, 50, obj_battle, { enemy_id: _c[1] });
            waiting = "battle";
            break;

        case "party_add":
            scr_party_add(_c[1]);
            break;

        case "party_remove":
            scr_party_remove(_c[1]);
            break;

        case "spawn":
            scr_char_spawn(_c[1], _c[2], _c[3]);
            break;

        case "destroy":
            var _t = cs_resolve(_c[1]);
            if (instance_exists(_t)) instance_destroy(_t);
            break;

        case "sprite":
            var _t = cs_resolve(_c[1]);
            if (instance_exists(_t)) {
                _t.sprite_index = _c[2];
                if (_n > 3) { _t.image_index = _c[3]; _t.image_speed = 0; }
            }
            break;

        case "item":
            scr_inventory_add(_c[1]);
            break;

        case "sanity":
            scr_change_sanity(_c[1]);
            break;

        case "heal":
            global.hp = global.hp_max;
            break;

        case "save":
            scr_game_save();
            break;

        case "call":
            _c[1]();
            break;

        case "pose":
            var _t = cs_resolve(_c[1]);
            if (instance_exists(_t)) {
                if (variable_instance_exists(_t, "pose_spr")) {
                    _t.pose_spr = _c[2];
                    _t.pose_img = (_n > 3) ? _c[3] : 0;
                } else if (_c[2] != -1) {
                    _t.sprite_index = _c[2];
                    _t.image_index = (_n > 3) ? _c[3] : 0;
                }
            }
            break;

        case "sound":
            scr_som(_c[1], (_n > 2) ? _c[2] : 0.6, (_n > 3) ? _c[3] : 1);
            break;

        case "silence":
            scr_som_silencio(_c[1]);
            break;

        default:
            show_debug_message("Cutscene: comando desconhecido " + string(_c[0]));
            break;
    }
}

// Devolve true quando o comando que estava esperando terminou
function cs_wait_done() {
    switch (waiting) {
        case "dialogue":
            return !obj_dialogue_manager.dialogue_active;

        case "wait":
            wait_timer -= 1;
            return (wait_timer <= 0);

        case "move":
            if (!instance_exists(move_target)) return true;
            var _t = move_target;
            var _dx = move_x - _t.x;
            var _dy = move_y - _t.y;
            var _d = point_distance(0, 0, _dx, _dy);
            if (_d <= move_spd) {
                _t.x = move_x;
                _t.y = move_y;
                _t.cs_moving = false;
                return true;
            }
            _t.x += _dx / _d * move_spd;
            _t.y += _dy / _d * move_spd;
            _t.cs_moving = true;
            if (abs(_dx) > abs(_dy)) _t.face_dir = (_dx > 0) ? "right" : "left";
            else _t.face_dir = (_dy > 0) ? "down" : "up";
            return false;

        case "room":
            return (global.fade_state == "none");

        case "tint":
            return (abs(tint_alpha - tint_target) < 0.01);

        case "title":
            return (title_state == "");

        case "battle":
            return !instance_exists(obj_battle);
    }
    return true;
}
