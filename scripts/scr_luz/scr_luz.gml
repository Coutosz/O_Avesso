// =====================================================================
// A CHAMA DA FAÍSCA (bíblia v6, parte 4)
// No escuro do Avesso, a única luz que a protagonista carrega é a Faísca.
// - Segurar X: a Faísca brilha forte (cansa rápido).
// - Apagado dentro da luz fica lento e mostra o contorno do que ele foi.
// - Z num Apagado iluminado: se você tem a coisa dele, ele lembra quem era (Lembrar).
// - Brilhar forte em cima de um Apagado por muito tempo queima ele (Arder): apagado de vez.
// Flags: "ap_<id>" = 0 nada, 1 lembrou, 2 ardeu. "apagados" conta quantos arderam.
// =====================================================================

// A Faísca que anda com você (ou noone)
function scr_faisca() {
    with (obj_follower) if (who == "faisca") return id;
    return noone;
}

// Sala escura do Avesso? (o escuro vem do scr_room_style)
function scr_room_is_dark() {
    return instance_exists(obj_room_ctrl) && obj_room_ctrl.style.dark >= 0.8;
}

// Põe um Apagado na sala, se ainda não aconteceu nada com ele.
// _rows: quantas linhas de cima do sprite viram silhueta (0 = o sprite todo)
function scr_apagado_spawn(_id, _who, _x, _y, _need, _spr, _rows = 0) {
    if (scr_flag_get("ap_" + _id) != 0) return noone;
    var _a = instance_create_depth(_x, _y, -_y, obj_apagado);
    _a.ap_id = _id;
    _a.who = _who;
    _a.need = _need;
    _a.silhueta = _spr;
    _a.sil_rows = _rows;
    return _a;
}

// Encostou na protagonista: gela (perde calor)
function scr_apagado_toque(_a) {
    scr_change_hp(-4);
    obj_player.invuln = 60;
    // empurra ela pra longe do Apagado, sem atravessar parede
    var _dir = point_direction(_a.x, _a.y, obj_player.x, obj_player.y);
    with (obj_player) {
        repeat (14) {
            var _nx = x + lengthdir_x(1, _dir), _ny = y + lengthdir_y(1, _dir);
            if (!scr_solid_at(_nx, y)) x = _nx;
            if (!scr_solid_at(x, _ny)) y = _ny;
        }
    }
    var _f = scr_faisca();
    if (_f != noone) _f.medo = 90;
    if (global.hp <= 0) scr_apagou();
}

// Calor zerado: volta pro começo da sala
function scr_apagou() {
    cs_start([
        ["darken", 1, c_black],
        ["call", function() {
            global.hp = global.hp_max;
            if (variable_global_exists("room_entry_x")) {
                obj_player.x = global.room_entry_x;
                obj_player.y = global.room_entry_y;
            }
            obj_player.trail = [];
            obj_player.invuln = 90;
            var _f = scr_faisca();
            if (_f != noone) { _f.x = obj_player.x; _f.y = obj_player.y; _f.energia = 100; _f.cansada = 0; }
            with (obj_apagado) { x = home_x; y = home_y; burn = 0; }
        }],
        ["wait", 30],
        ["darken", 0],
        ["say", "voce_apagou"]
    ]);
}

// A Faísca avisa, uma vez por Apagado, que tá doendo nele
function scr_faisca_aviso() {
    cs_start([["say", "faisca_aviso_arder"]]);
}

// Arder: o Apagado vira poeira dourada e ninguém mais lembra dele
function scr_apagado_arder(_a) {
    if (_a.dying > 0) return;
    _a.dying = 1;
    scr_flag_set("ap_" + _a.ap_id, 2);
    scr_flag_add("apagados", 1);
    scr_change_sanity(-10);
    var _f = scr_faisca();
    if (_f != noone) {
        _f.brilhando = false;
        _f.energia = 0;
        _f.cansada = 240;
        _f.distante = 1800;   // ela anda mais longe de você por um tempo
    }
    cs_start([["wait", 50], ["say", "faisca_ardeu"]]);
}

// Z num Apagado
function scr_apagado_lembrar(_a) {
    if (!_a.lit) {
        cs_start([["say", "ap_escuro"]]);
        return;
    }
    if (_a.need != "" && scr_inventory_has(_a.need)) {
        var _ref = _a;
        cs_start([
            ["call", method({ a: _ref }, function() {
                scr_inventory_take(a.need);
                a.lembrando = 1;
            })],
            ["wait", 50],
            ["flash", make_color_rgb(255, 230, 160)],
            ["call", method({ a: _ref }, function() {
                if (!instance_exists(a)) return;
                scr_flag_set("ap_" + a.ap_id, 1);
                scr_change_sanity(10);
                scr_char_spawn(a.who, a.x, a.y);
                instance_destroy(a);
            })],
            ["say", "ap_lembrou_" + _a.who],
            ["say", "faisca_nomeia_" + _a.who]
        ]);
        return;
    }
    cs_start([["say", "ap_contorno_" + _a.who]]);
}

// ---------- Itens: tem / tira ----------
function scr_inventory_has(_id) {
    for (var i = 0; i < array_length(global.inventory); i++) {
        if (global.inventory[i] == _id) return true;
    }
    return false;
}

function scr_inventory_take(_id) {
    for (var i = 0; i < array_length(global.inventory); i++) {
        if (global.inventory[i] == _id) { scr_inventory_remove(i); return true; }
    }
    return false;
}
