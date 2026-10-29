// Mantém a protagonista viva e escolhe o comando de batalha
global.hp = global.hp_max;
with (obj_battle) {
    if (state == "menu") {
        if (other.mode == 2) menu_index = 0;                              // ATACAR
        else menu_index = calm_told ? array_length(menu) - 1 : 4;         // HESITAR, depois DESPEDIR
    }
}

// prints automáticos de momentos que acontecem dentro de cutscene/batalha
with (obj_battle) {
    if (state == "menu" && turn == 0) other.shot("20_batalha_menu");
    if (state == "dodge" && dodge_t == 120) other.shot("21_batalha_desvio");
    if (state == "talk") other.shot("22_batalha_conversar");
}
if (mode != 3 && obj_dialogue_manager.dialogue_active && obj_dialogue_manager.dialogue_full_page) {
    if (obj_dialogue_manager.choice_active) shot("23_escolha_" + room_get_name(room));
    else shot("24_dialogo_" + room_get_name(room));
}
if (room == rm_a1_varanda && obj_cutscene.tint_alpha > 0.6 && obj_dialogue_manager.dialogue_active) shot("25_noite");
if (obj_cutscene.title_alpha >= 1) shot("26_fim");
// cenas novas do Ato 1
if (instance_exists(obj_player) && obj_player.pose_spr == spr_player_levanta && room == rm_a1_queda) {
    if (obj_player.pose_img == 0) shot("05a_deitada");
    if (obj_player.pose_img == 1) shot("05b_sentada");
    if (obj_player.pose_img == 4) shot("05c_poeira");
}
with (obj_char) if (who == "faisca" && room == rm_a1_queda) other.shot("05d_luzinha");
with (obj_apagado) if (scripted && x > 150) other.shot("06b_olhos");
with (obj_char) if (who == "faisca" && room == rm_a1_corredor && x < 300) other.shot("06c_faisca_chega");
if (room == rm_a1_ponte && instance_exists(obj_player) && obj_player.x > 110 && obj_player.x < 125 && obj_dialogue_manager.dialogue_active) shot("08a_espinho");

if (delay > 0) { delay -= 1; exit; }
if (room == rm_boot && mode != 5) exit;
if (step_i >= array_length(steps)) exit;

var _s = steps[step_i];
var _busy = scr_is_blocking();

switch (_s[0]) {
    case "call": _s[1](); break;
    case "newgame":
        if (room != rm_menu) exit;
        global.player_name = "Teste";
        global.gold = 0; global.lvl = 1; global.hp = global.hp_max; global.sanity = 0;
        global.inventory = array_create(8, "");
        global.flags = {};
        global.party = [];
        scr_fade_to_room(rm_casa_quarto, 130, 132);
        break;

    case "expect_room":
        if (_busy) exit;
        if (room != _s[1]) { fails++; log("FALHOU: esperava sala " + room_get_name(_s[1]) + ", estou em " + room_get_name(room)); }
        else log("ok sala " + room_get_name(room));
        break;

    case "expect_flag":
        if (_busy) exit;
        if (!scr_flag_get(_s[1])) { fails++; log("FALHOU: flag " + _s[1] + " nao ligou"); }
        else log("ok flag " + _s[1]);
        break;

    case "expect_party":
        if (_busy) exit;
        if (!scr_party_has(_s[1])) { fails++; log("FALHOU: " + _s[1] + " nao esta no grupo " + string(global.party)); }
        else log("ok grupo tem " + _s[1]);
        break;

    case "event":
        if (_busy) exit;
        log("evento " + _s[1] + " em " + room_get_name(room));
        scr_event_run(_s[1], noone);
        break;

    case "goto":
        if (_busy) exit;
        log("indo pra " + room_get_name(_s[1]));
        scr_fade_to_room(_s[1], _s[2], _s[3]);
        break;

    case "walk":
        if (_busy) exit;
        obj_player.x = _s[1];
        obj_player.y = _s[2];
        break;

    case "shot":
        if (_busy) exit;
        shot(_s[1]);
        break;

    case "wait":
        delay = _s[1];
        break;

    case "hold":
        global.autotest_hold = _s[1];
        break;

    case "shotnow":
        shot(_s[1]);
        break;

    case "face":
        if (_busy) exit;
        obj_player.face_dir = _s[1];
        with (obj_player) scr_player_anim(false);
        break;

    case "use":
        // examina a coisa da sala que tem esse evento (ex.: pegar o regador)
        if (_busy) exit;
        var _ev = _s[1], _hit = noone;
        with (obj_interact) if (event == _ev) _hit = id;
        log("usando " + _ev + (_hit == noone ? " (nao achei na sala)" : ""));
        if (_hit != noone) { obj_player.x = _hit.x; obj_player.y = _hit.y + 4; scr_event_run(_ev, _hit); }
        break;

    case "near_ap":
        // leva a protagonista (e a Faísca) pra perto do Apagado
        if (_busy) exit;
        var _apid = _s[1], _ap = noone;
        with (obj_apagado) if (ap_id == _apid) _ap = id;
        if (_ap == noone) { fails++; log("FALHOU: Apagado " + _apid + " nao esta na sala"); break; }
        obj_player.x = _ap.x - 18; obj_player.y = _ap.y; obj_player.face_dir = "right"; obj_player.invuln = 999;
        with (obj_follower) if (who == "faisca") { x = _ap.x - 26; y = _ap.y; }
        _ap.home_x = _ap.x; _ap.home_y = _ap.y;
        break;

    case "lembrar":
        if (_busy) exit;
        var _apid = _s[1], _ap = noone;
        with (obj_apagado) if (ap_id == _apid) _ap = id;
        if (_ap == noone) { fails++; log("FALHOU: Apagado " + _apid + " sumiu"); break; }
        if (!_ap.lit) { fails++; log("FALHOU: Apagado " + _apid + " nao esta na luz"); }
        log("lembrar " + _apid);
        scr_apagado_lembrar(_ap);
        break;

    case "arder":
        // segura o brilho com o Apagado colado na Faísca até ele virar poeira
        var _apid = _s[1], _ap = noone;
        with (obj_apagado) if (ap_id == _apid) _ap = id;
        if (scr_flag_get("ap_" + _apid) == 2) { global.autotest_brilhar = false; log("ardeu " + _apid); break; }
        if (_ap == noone) { fails++; log("FALHOU: Apagado " + _apid + " sumiu antes de arder"); global.autotest_brilhar = false; break; }
        global.autotest_brilhar = true;
        obj_player.invuln = 999;
        var _f = scr_faisca();
        if (_f != noone && _ap.dying == 0) { _ap.x = _f.x + 6; _ap.y = _f.y + 4; }
        exit;

    case "expect_val":
        if (_busy) exit;
        if (scr_flag_get(_s[1]) != _s[2]) { fails++; log("FALHOU: " + _s[1] + " = " + string(scr_flag_get(_s[1])) + ", esperava " + string(_s[2])); }
        else log("ok " + _s[1] + " = " + string(_s[2]));
        break;

    case "saveload":
        if (_busy) exit;
        log("salvando e carregando");
        scr_game_save();
        scr_game_load();
        break;

    case "done":
        if (_busy) exit;
        log("FIM. falhas: " + string(fails) + " | gratidao " + string(global.sanity) + " | apagados " + string(scr_flag_get("apagados")));
        game_end();
        break;
}

step_i += 1;
if (_s[0] != "wait") delay = 15;
