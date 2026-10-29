// Abre a caixa de diálogo.
// _pages: array de strings OU de structs { spk, txt } (use scr_lines("chave") pra montar).
// _choices (opcional): array de strings mostrado depois da última página. O resultado vai pra global.choice.
// _float (opcional): true = texto solto no meio da tela, sem caixa (pra momentos de silêncio).
function scr_dialogue_start(_pages, _choices = [], _float = false) {
    var _norm = [];
    for (var i = 0; i < array_length(_pages); i++) {
        var _p = _pages[i];
        if (is_string(_p)) _p = { spk: "", txt: _p };
        if (!variable_struct_exists(_p, "expr")) _p.expr = "";
        array_push(_norm, _p);
    }

    with (obj_dialogue_manager) {
        dialogue_pages = _norm;
        dialogue_page_index = 0;
        dialogue_char_index = 0;
        dialogue_current_text = "";
        dialogue_full_page = false;
        dialogue_timer = 0;
        dialogue_active = true;
        dialogue_just_opened = true;
        choice_options = _choices;
        choice_index = 0;
        choice_active = false;
        float_mode = _float;
    }
}

// Atalho: abre um bloco de falas do text_db direto pela chave.
function scr_say(_key) {
    scr_dialogue_start(scr_lines(_key));
}

// "Voz" de quem fala: um bipezinho por letra. snd_voz_<quem> se existir, senão snd_voz (narrador).
function scr_voice_blip(_spk) {
    var _name = "snd_voz_" + _spk;
    var _snd = asset_get_index(_name);
    if (_snd == -1 || asset_get_type(_name) != asset_sound) _snd = asset_get_index("snd_voz");
    if (_snd == -1) exit;
    audio_stop_sound(_snd);
    audio_play_sound(_snd, 1, false, 0.45, 0, random_range(0.96, 1.04));
}
