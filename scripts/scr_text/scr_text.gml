// Devolve o valor cru de uma chave do text_db (string ou array de falas), no idioma atual.
function scr_text_raw(_key) {
    if (!variable_struct_exists(global.text_db, _key)) {
        return "[TEXTO FALTANDO: " + _key + "]";
    }

    var _entry = global.text_db[$ _key];

    if (variable_struct_exists(_entry, global.language)) {
        return _entry[$ global.language];
    }

    return _entry[$ "pt"];
}

// Troca {nome} pelo nome do jogador ({NOME} = em caixa alta, pro Campeão).
function scr_text_fill(_str) {
    _str = string_replace_all(_str, "{NOME}", string_upper(global.player_name));
    return string_replace_all(_str, "{nome}", global.player_name);
}

function scr_text(_key) {
    var _raw = scr_text_raw(_key);
    if (is_array(_raw)) _raw = _raw[0];
    return scr_text_fill(_raw);
}

// Lê um bloco de falas. Cada linha pode começar com "@quem " pra dizer quem está falando.
// Linha sem "@" é o narrador. Devolve um array de { spk, txt } pro obj_dialogue_manager.
function scr_lines(_key) {
    var _raw = scr_text_raw(_key);
    if (!is_array(_raw)) _raw = [_raw];

    var _out = [];
    for (var i = 0; i < array_length(_raw); i++) {
        var _s = scr_text_fill(_raw[i]);
        var _spk = "";
        var _expr = "";
        if (string_char_at(_s, 1) == "@") {
            var _space = string_pos(" ", _s);
            _spk = string_copy(_s, 2, _space - 2);
            _s = string_delete(_s, 1, _space);
            // "@mae.cansada" -> quem fala: mae, expressão: cansada
            var _dot = string_pos(".", _spk);
            if (_dot > 0) {
                _expr = string_delete(_spk, 1, _dot);
                _spk = string_copy(_spk, 1, _dot - 1);
            }
        }
        array_push(_out, { spk: _spk, expr: _expr, txt: _s });
    }
    return _out;
}

// Opções de escolha: a chave aponta pra um array de strings.
function scr_options(_key) {
    var _raw = scr_text_raw(_key);
    if (!is_array(_raw)) _raw = [_raw];
    var _out = [];
    for (var i = 0; i < array_length(_raw); i++) array_push(_out, scr_text_fill(_raw[i]));
    return _out;
}

// Nome que aparece na plaquinha em cima da caixa de diálogo.
function scr_speaker_name(_spk) {
    if (_spk == "eu") return global.player_name;
    var _key = "spk_" + _spk;
    if (variable_struct_exists(global.text_db, _key)) return scr_text(_key);
    return _spk;
}

// Retrato de quem fala (spr_retrato_<quem>_<expressão>, ou spr_retrato_<quem>). -1 = sem retrato.
function scr_portrait(_spk, _expr) {
    if (_spk == "") return -1;
    if (_expr != "") {
        var _s = asset_get_index("spr_retrato_" + _spk + "_" + _expr);
        if (_s != -1 && asset_get_type("spr_retrato_" + _spk + "_" + _expr) == asset_sprite) return _s;
    }
    var _b = asset_get_index("spr_retrato_" + _spk);
    if (_b != -1 && asset_get_type("spr_retrato_" + _spk) == asset_sprite) return _b;
    return -1;
}
