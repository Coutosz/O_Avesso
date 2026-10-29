// =====================================================================
// SOM DO AVESSO
// Um barulho grave de fundo (loop) e, de vez em quando, uma coisa estranha bem baixinho:
// rangido, sussurro, passos longe, gota, sino, respiração, batida na parede.
// Sozinha é mais alto e mais frequente. Com a Faísca por perto, o escuro fica mais quieto.
// Quem chama: obj_room_ctrl (Step) -> scr_som_update(sala).
// =====================================================================

function scr_som_init() {
    if (variable_global_exists("amb_inst")) return;
    global.amb_inst = -1;     // o loop que está tocando
    global.amb_snd = -1;      // qual loop é
    global.amb_dying = -1;    // o loop antigo, sumindo
    global.amb_timer = 200;   // frames até a próxima coisa estranha
    global.amb_last = -1;
    global.amb_quiet = 0;     // frames de silêncio (antes de um susto, tudo para)
    audio_falloff_set_model(audio_falloff_linear_distance_clamped);
    audio_listener_position(0, 0, 0);
}

// Qual barulho de fundo cada sala tem (-1 = nenhum)
function scr_som_room_amb(_name) {
    if (string_pos("rm_a1_", _name) == 1 && _name != "rm_a1_varanda") return snd_amb_avesso;
    return -1;
}

function scr_som_update(_name) {
    scr_som_init();
    var _want = scr_som_room_amb(_name);

    if (_want != global.amb_snd) {
        if (global.amb_inst != -1 && audio_is_playing(global.amb_inst)) {
            audio_sound_gain(global.amb_inst, 0, 1500);
            global.amb_dying = global.amb_inst;
        }
        global.amb_inst = -1;
        global.amb_snd = _want;
        if (_want != -1) {
            global.amb_inst = audio_play_sound(_want, 2, true, 0);
        }
        global.amb_timer = 150;
    }
    if (global.amb_dying != -1 && audio_is_playing(global.amb_dying) && audio_sound_get_gain(global.amb_dying) <= 0.001) {
        audio_stop_sound(global.amb_dying);
        global.amb_dying = -1;
    }
    if (global.amb_inst == -1) return;

    var _sozinha = (scr_faisca() == noone);
    var _alvo = _sozinha ? 0.75 : 0.38;
    if (global.amb_quiet > 0) { global.amb_quiet -= 1; _alvo = 0; }
    var _g = audio_sound_get_gain(global.amb_inst);
    audio_sound_gain(global.amb_inst, lerp(_g, _alvo, global.amb_quiet > 0 ? 0.08 : 0.02), 0);

    // coisa estranha de vez em quando
    if (global.amb_quiet > 0 || scr_is_blocking()) return;
    global.amb_timer -= 1;
    if (global.amb_timer > 0) return;
    global.amb_timer = _sozinha ? irandom_range(260, 620) : irandom_range(700, 1400);

    var _list = _sozinha
        ? [snd_amb_rangido, snd_amb_sussurro, snd_amb_passos, snd_amb_gota, snd_amb_sino, snd_amb_respiro, snd_amb_batida]
        : [snd_amb_rangido, snd_amb_gota, snd_amb_sino, snd_amb_passos];
    var _s = _list[irandom(array_length(_list) - 1)];
    if (_s == global.amb_last) _s = _list[irandom(array_length(_list) - 1)];
    global.amb_last = _s;
    var _lado = choose(-1, 1) * irandom_range(60, 220);
    audio_play_sound_at(_s, _lado, 0, 0, 80, 520, 1, false, 3, _sozinha ? random_range(0.22, 0.38) : random_range(0.12, 0.2), 0, random_range(0.85, 1.08));
}

// Silencia o fundo por um tempo (o escuro "prende a respiração")
function scr_som_silencio(_frames) {
    scr_som_init();
    global.amb_quiet = _frames;
}

// Som curto de cena (susto, faísca, poeira...)
function scr_som(_snd, _gain = 0.6, _pitch = 1) {
    audio_play_sound(_snd, 4, false, _gain, 0, _pitch);
}
