// =====================================================================
// HISTÓRIA: PRÓLOGO + ATO 1
// - scr_event_cmds(evento): o que acontece quando a protagonista examina/conversa/pisa em algo
// - scr_room_setup(sala):   o que acontece quando ela entra numa sala
// - scr_room_style(sala):   cores provisórias de chão e parede de cada sala
// Os textos ficam em scr_text_ato1. Flags importantes estão comentadas onde são usadas.
// =====================================================================

// Roda um evento. Se não tiver nada programado pra ele, mostra o texto com a mesma chave.
function scr_event_run(_ev, _inst = noone) {
    var _cmds = scr_event_cmds(_ev, _inst);
    if (is_array(_cmds) && array_length(_cmds) > 0) {
        cs_start(_cmds);
    } else if (variable_struct_exists(global.text_db, _ev)) {
        cs_start([["say", _ev]]);
    }
}

// Conversa que alterna entre várias falas (usa uma flag como contador)
function scr_rotate(_counter, _keys) {
    var _n = scr_flag_get(_counter);
    scr_flag_set(_counter, _n + 1);
    return [["say", _keys[_n mod array_length(_keys)]]];
}

function scr_event_cmds(_ev, _inst) {
    switch (_ev) {

    // =================================================================
    // PRÓLOGO
    // =================================================================
    case "p_cama":
        if (scr_flag_get("noite")) return [["say", "p_cama_noite"]];
        if (scr_flag_get("mae_n") >= 1 && scr_flag_get("pai_n") >= 1) {
            return [
                ["say", "p_cama_ok"],
                ["darken", 1],
                ["wait", 60],
                ["flag", "noite", true],             // a casa fica de noite
                ["teleport", "player", 96, 132],
                ["face", "player", "down"],
                ["float", "p_noite_relogio"],
                ["darken", 0],
                ["say", "p_noite_acorda"]
            ];
        }
        return [["say", "p_cama_cedo"]];

    case "p_porta":
        if (scr_flag_get("noite")) {
            return [["say", "p_porta_noite"], ["goto", rm_casa_deposito, 160, 196]];
        }
        return [["say", "p_porta_dia"], ["flag", "viu_porta", true]];

    case "talk_mae":
        var _n = scr_flag_get("mae_n");
        scr_flag_set("mae_n", _n + 1);
        if (_n == 0) return [["say", "p_mae_1"]];
        if (_n == 1) return [["say", "p_mae_2"]];
        if (_n == 2) return [["say", "p_mae_3"]];
        return [["say", "p_mae_rep"]];

    case "talk_pai":
        var _n = scr_flag_get("pai_n");
        scr_flag_set("pai_n", _n + 1);
        if (_n == 0) return [["ask", "p_pai_1", "p_pai_1_opts"], ["branch", [["say", "p_pai_1a"]], [["say", "p_pai_1b"]]]];
        if (_n == 1) return [["ask", "p_pai_2", "p_pai_2_opts"], ["branch", [["say", "p_pai_2a"]], [["say", "p_pai_2b"]]]];
        if (scr_flag_get("viu_porta") && !scr_flag_get("pai_porta")) {
            return [["say", "p_pai_porta"], ["flag", "pai_porta", true]];
        }
        return [["say", "p_pai_rep"]];

    case "p_lencol":
        return [
            ["ask", "p_lencol", "p_lencol_opts"],
            ["branch",
                [
                    ["shake", 50],
                    ["say", "p_cai"],
                    ["flash", make_color_rgb(255, 220, 120)],
                    ["darken", 1],
                    ["goto", rm_a1_queda, 150, 128],
                    ["wait", 40],
                    ["darken", 0]
                ],
                [["say", "p_lencol_quieto"]]
            ]
        ];

    // =================================================================
    // VELINHAS (save)
    // =================================================================
    case "velinha":
        var _key = "velinha_" + room_get_name(room);
        var _cmds = [];
        if (!scr_flag_get(_key)) {
            array_push(_cmds,
                ["call", function() { with (obj_velinha) image_index = 1; }],
                ["flag", _key, true],
                ["heal"],
                ["say", "velinha_primeira"]
            );
            if (scr_party_has("faisca") && !scr_flag_get("lembr_faisca_velinha")) {
                // a Faísca cochila do lado do fogo (lembrança pro Lembrar do Ato 3)
                array_push(_cmds, ["say", "a1_velinha_faisca"], ["flag", "lembr_faisca_velinha", true]);
            }
        } else {
            array_push(_cmds, ["heal"], ["say", "velinha_acesa"]);
        }
        array_push(_cmds,
            ["ask", "velinha_pergunta", "velinha_opcoes"],
            ["branch", [["save"], ["say", "velinha_salvo"]], []]
        );
        return _cmds;

    // =================================================================
    // ATO 1 — SALA 1: CORREDOR
    // =================================================================
    case "a1_nana_entra":
        // (o nome é antigo: o gatilho fica no meio do corredor)
        // Ela tá sozinha no escuro. Uma coisa abre os olhos lá atrás e vem vindo. A Faísca chega e espanta.
        if (scr_flag_get("a1_faisca_achou")) return [];
        scr_flag_set("a1_faisca_achou", true);
        return [
            ["silence", 600],
            ["wait", 80],
            ["call", function() {
                var _a = scr_apagado_spawn("sombra_corredor", "", 36, 132, "", spr_estante);
                if (_a != noone) _a.scripted = true;
            }],
            ["wait", 40],
            ["sound", snd_susto, 0.7],
            ["say", "a1_olhos_1"],
            ["face", "player", "left"],
            ["wait", 30],
            ["move", "sombra_corredor", 196, 134, 0.8],
            ["shake", 8],
            ["say", "a1_olhos_2"],
            ["move", "player", 300, 136, 0.7],
            ["move", "sombra_corredor", 252, 135, 0.8],
            ["flash", make_color_rgb(255, 170, 70)],
            ["sound", snd_faisca_tilin, 0.6],
            ["spawn", "faisca", 470, 116],
            ["move", "faisca", 278, 126, 5],
            ["say", "a1_faisca_espanta"],
            ["move", "sombra_corredor", 24, 132, 2.4],
            ["destroy", "sombra_corredor"],
            ["face", "player", "right"],
            ["wait", 30],
            ["ask", "a1_faisca_oi", "a1_faisca_oi_opts"],
            ["branch", [["say", "a1_faisca_oi_a"]], [["say", "a1_faisca_oi_b"]]],
            ["say", "a1_faisca_oi_2"],
            ["party_add", "faisca"],
            ["flag", "lembr_faisca_achou", true],   // lembrança: ela te achou primeiro
            ["say", "a1_faisca_tut_carinho"],
            ["flag", "a1_tut_escuro", true],
            ["say", "a1_escuro_1"]
        ];

    case "talk_nana":
        // Nana na Varanda (ela não sai de lá)
        if (scr_flag_get("a1_pronto")) return [["say", "a1_nana_tchau"]];
        if (!scr_flag_get("a1_noite_feita")) {
            if (scr_flag_get("a1_falou_espinho") && scr_flag_get("a1_falou_fio")) {
                return scr_a1_noite();
            }
            return [["say", "a1_nana_panela"]];
        }
        return [["say", "a1_nana_tchau"]];

    // =================================================================
    // SALA 2: PONTE
    // =================================================================
    case "a1_ponte_nana":
        // (nome antigo do gatilho) Tem um vulto alto parado perto do sino. É o Espinho.
        if (scr_flag_get("a1_conheceu_espinho") || cs_resolve("espinho") == noone) return [];
        scr_flag_set("a1_conheceu_espinho", true);
        return [
            ["silence", 300],
            ["say", "a1_espinho_vulto"],
            ["call", function() { var _f = scr_faisca(); if (_f != noone) _f.medo = 150; }],
            ["move", "player", 118, 140, 0.6],
            ["shake", 12],
            ["say", "a1_espinho_alto_la"],
            ["flag", "conhece_espinho", true]
        ];

    case "a1_sino":
        if (scr_flag_get("a1_ponte1")) return [["say", "a1_sino_depois"]];
        // o Espinho vai na frente avisar a Varanda
        var _after = [];
        if (cs_resolve("espinho") != noone) {
            _after = [
                ["say", "a1_espinho_vai"],
                ["move", "espinho", 204, 140, 1.4],
                ["move", "espinho", 300, 132, 1.4],
                ["move", "espinho", 420, 132, 1.4],
                ["destroy", "espinho"]
            ];
        }
        return [
            ["ask", "a1_sino", "a1_sino_opts"],
            ["branch",
                [["say", "a1_sino_toca"], ["flash", make_color_rgb(255, 230, 150)], ["flag", "a1_ponte1", true], ["wait", 20], ["if", function() { return true; }, _after]],
                []
            ]
        ];

    case "a1_ponte_tese":
        return [];

    // =================================================================
    // SALA 3: VASINHO
    // =================================================================
    case "a1_vasinho":
        // primeiro Apagado (tutorial do Lembrar). A coisa dele (o regador) tá perto da entrada.
        if (scr_flag_get("a1_vasinho_feito") || scr_flag_get("ap_vasinho") != 0) return [];
        return [["say", "a1_vasinho_ve"], ["flag", "a1_vasinho_feito", true]];

    case "pega_regador":
        return [["say", "pega_regador"], ["item", "regador"], ["destroy", _inst], ["flag", "pegou_regador", true]];

    case "pega_cabo":
        return [["say", "pega_cabo"], ["item", "cabo_guarda"], ["destroy", _inst], ["flag", "pegou_cabo", true]];

    case "talk_vasinho":
        return scr_rotate("vasinho_n", ["a1_vasinho_r0", "a1_vasinho_r1"]);

    case "talk_sombrinha":
        return scr_rotate("sombrinha_n", ["a1_sombrinha_r0", "a1_sombrinha_r1"]);

    // =================================================================
    // SALA 4: O VÃO
    // =================================================================
    case "a1_vao_nana":
        if (!scr_party_has("nana")) return [];
        return [
            ["say", "a1_vao_nana"],
            ["party_remove", "nana"],
            ["move", "nana", 16, 132, 1.5],
            ["destroy", "nana"],
            ["flag", "a1_nana_volta", true]   // Nana está dando a volta
        ];

    case "a1_vao_voz_1":
    case "a1_vao_voz_2":
    case "a1_vao_voz_4":
        if (scr_flag_get("a1_nana_volta") && !scr_flag_get("a1_nana_voltou")) return [["say", _ev]];
        return [];

    case "a1_sino2":
        if (scr_flag_get("a1_ponte2")) return [["say", "a1_sino_depois"]];
        return [
            ["ask", "a1_sino2", "a1_sino_opts"],
            ["branch",
                [["say", "a1_sino2_toca"], ["flash", make_color_rgb(255, 230, 150)], ["flag", "a1_ponte2", true]],
                []
            ]
        ];

    // =================================================================
    // SALA 5: ANI
    // =================================================================
    case "talk_ani":
        var _n = scr_flag_get("ani_n");
        scr_flag_set("ani_n", _n + 1);
        scr_flag_set("ani_falou", true);  // Ani aparece cheia no final bom
        if (_n == 0) return [["say", "a1_ani_1"]];
        if (_n == 1) return [["ask", "a1_ani_2", "a1_ani_2_opts"], ["branch", [["say", "a1_ani_2a"]], [["say", "a1_ani_2b"]]]];
        if (_n == 2) return [["ask", "a1_ani_3", "a1_ani_3_opts"], ["branch", [["say", "a1_ani_3a"]], [["say", "a1_ani_3b"]]]];
        return [["say", "a1_ani_rep"]];

    // =================================================================
    // SALA 6: VARANDA
    // =================================================================
    case "talk_espinho":
        if (!scr_flag_get("a1_falou_espinho")) {
            scr_flag_set("a1_falou_espinho", true);
            return [["say", "a1_espinho_1"]];
        }
        return scr_rotate("espinho_n", ["a1_espinho_r0", "a1_espinho_r1", "a1_espinho_r2"]);

    case "talk_fio":
        if (!scr_flag_get("a1_falou_fio")) {
            scr_flag_set("a1_falou_fio", true);
            return [["say", "a1_fio_var"]];
        }
        return scr_rotate("fio_n", ["a1_fio_r0", "a1_fio_r1", "a1_fio_r2"]);

    case "talk_faisca":
        // Z perto da Faísca = carinho (pulinho, rodopio, faisquinha). A cada 3, ela fala alguma coisa.
        // Cada fala vira uma lembrança (flag "lembr_faisca_*") pro Lembrar do Ato 3.
        var _f = scr_faisca();
        if (_f != noone) { _f.pet_t = 36; _f.pet_n += 1; }
        var _p = scr_flag_get("faisca_pet");
        scr_flag_set("faisca_pet", _p + 1);
        if (_p mod 3 != 2) return [["wait", 1]];
        var _n = scr_flag_get("faisca_n");
        scr_flag_set("faisca_n", _n + 1);
        switch (_n mod 6) {
            case 0: return [["say", "a1_faisca_pet"], ["flag", "lembr_faisca_carinho", true]];
            case 1: return [["say", "a1_faisca_r1"], ["flag", "lembr_faisca_botoes", true]];
            case 2: return [
                ["ask", "a1_faisca_tomate", "a1_faisca_tomate_opts"],
                ["branch", [["say", "a1_faisca_tomate_a"]], [["say", "a1_faisca_tomate_b"]]],
                ["flag", "lembr_faisca_tomate", true]
            ];
            case 3: return [["say", "a1_faisca_sorvete"], ["flag", "lembr_faisca_sorvete", true]];
            case 4: return [["say", "a1_faisca_r0"], ["flag", "lembr_faisca_nome", true]];
            default: return [["say", "a1_faisca_r3"], ["flag", "lembr_faisca_chocolate", true]];
        }

    case "talk_relogio":
        if (!scr_flag_get("relogio_falou")) return [["say", "a1_relogio_1"], ["flag", "relogio_falou", true]];
        return [["say", "a1_relogio_rep"]];

    case "a1_panela":
        return [["say", "a1_panela"]];

    case "a1_fim":
        if (!scr_flag_get("a1_pronto")) {
            return [["say", "a1_saida_cedo"], ["move", "player", 412, 176, 2]];
        }
        return [
            ["say", "a1_saida"],
            ["move", "player", 494, 176, 2],
            ["darken", 1],
            ["flag", "ato1_completo", true],
            ["title", "fim_ato1", 200, "continua"],
            ["goto", rm_menu, 0, 0],
            ["darken", 0]
        ];
    }

    return [];
}

// A primeira noite na Varanda + a manhã seguinte + a despedida da Nana
function scr_a1_noite() {
    var _night = make_color_rgb(10, 10, 40);
    return [
        ["say", "a1_nana_jantar"],
        ["darken", 0.65, _night],
        ["party_remove", "faisca"],
        ["teleport", "player", 100, 166],
        ["pose", "player", spr_player_levanta, 0],   // deitada na rede
        ["teleport", "faisca", 106, 160],
        ["teleport", "nana", 134, 182],
        ["face", "nana", "left"],
        ["say", "a1_noite_1"],
        ["wait", 40],
        ["say", "a1_noite_2"],
        ["darken", 1, c_black],
        ["wait", 30],
        ["float", "a1_manha"],

        // Manhã
        ["pose", "player", -1],
        ["teleport", "player", 250, 192],
        ["face", "player", "up"],
        ["teleport", "faisca", 232, 196],
        ["party_add", "faisca"],
        ["teleport", "fio", 222, 162],
        ["teleport", "espinho", 286, 190],
        ["teleport", "nana", 364, 128],
        ["face", "nana", "down"],
        ["flag", "a1_noite_feita", true],
        ["darken", 0],
        ["say", "a1_manha_plano"],

        // Despedida da Nana
        ["move", "nana", 268, 172, 1.5],
        ["item", "marmita"],
        ["ask", "a1_manha_nana", "a1_manha_nana_opts"],
        ["branch", [["say", "a1_manha_nana_a"]], [["say", "a1_manha_nana_b"]]],
        ["flag", "promessa_nana", true],
        ["move", "nana", 364, 128, 1.5],
        ["face", "nana", "down"],
        ["flag", "a1_pronto", true]
    ];
}

// =====================================================================
// PREPARAÇÃO DAS SALAS (roda quando a protagonista entra)
// =====================================================================
function scr_room_setup(_name) {
    switch (_name) {

    case "rm_casa_quarto":
        if (!scr_flag_get("p_inicio")) {
            scr_flag_set("p_inicio", true);
            cs_start([["wait", 30], ["say", "p_quarto_inicio"]]);
        }
        break;

    case "rm_casa":
        if (scr_flag_get("noite")) {
            // de madrugada: os pais estão dormindo e a porta do depósito está aberta
            with (obj_char) if (who == "mae" || who == "pai") instance_destroy();
            with (obj_interact) if (event == "p_porta") image_index = 1;
        }
        break;

    case "rm_a1_queda":
        // Ela cai no escuro, sozinha. Levanta, bate a poeira e olha em volta.
        // Uma luzinha espia lá do canto e some (é a Faísca, mas ninguém fala nada ainda).
        if (!scr_flag_get("a1_queda_intro")) {
            scr_flag_set("a1_queda_intro", true);
            var _L = spr_player_levanta;
            // já começa deitada (antes do fade abrir)
            with (obj_player) { pose_spr = _L; pose_img = 0; }
            cs_start([
                ["pose", "player", _L, 0],
                ["sound", snd_queda, 0.8],
                ["shake", 10],
                ["wait", 110],
                ["float", "a1_queda_float"],
                ["wait", 30],
                ["pose", "player", _L, 1], ["wait", 50],
                ["pose", "player", _L, 2], ["wait", 16],
                ["pose", "player", _L, 3], ["wait", 24],
                // bate a poeira da roupa (sai poeira dourada)
                ["pose", "player", _L, 4], ["sound", snd_poeira, 0.5], ["call", function() { scr_fx_poeira(obj_player.x, obj_player.y - 6); }], ["wait", 7],
                ["pose", "player", _L, 5], ["wait", 7],
                ["pose", "player", _L, 4], ["sound", snd_poeira, 0.5, 1.1], ["call", function() { scr_fx_poeira(obj_player.x, obj_player.y - 6); }], ["wait", 7],
                ["pose", "player", _L, 5], ["wait", 7],
                ["pose", "player", _L, 4], ["sound", snd_poeira, 0.5, 0.95], ["call", function() { scr_fx_poeira(obj_player.x, obj_player.y - 6); }], ["wait", 7],
                ["pose", "player", _L, 3], ["wait", 30],
                ["pose", "player", -1],
                ["face", "player", "left"], ["wait", 34],
                ["face", "player", "right"], ["wait", 20],
                // lá no canto, uma luzinha espia e some
                ["spawn", "faisca", 292, 96],
                ["wait", 24],
                ["move", "faisca", 330, 84, 4],
                ["destroy", "faisca"],
                ["wait", 30],
                ["face", "player", "down"],
                ["say", "a1_queda_sozinha"]
            ]);
        }
        break;

    case "rm_a1_corredor":
        with (obj_hazard) instance_destroy();   // o escorregador era da cena antiga da Nana
        break;

    case "rm_a1_ponte":
        // o Espinho fica de guarda perto do sino até a Beira saber que chegou gente
        if (!scr_flag_get("a1_ponte1")) {
            var _e = scr_char_spawn("espinho", 152, 156);
            _e.face_dir = "left";
        }
        break;

    case "rm_a1_vasinho":
        with (obj_char) if (who == "vasinho") instance_destroy();
        scr_apagado_spawn("vasinho", "vasinho", 214, 128, "regador", spr_vasinho);
        if (!scr_flag_get("pegou_regador") && scr_flag_get("ap_vasinho") == 0) scr_item_spawn(96, 168, spr_regador, "pega_regador");
        break;

    case "rm_a1_vao":
        // a Sombrinha perdeu o cabo (ele tá na sala da Ani). Dá pra fugir dela agora e voltar depois.
        scr_apagado_spawn("sombrinha", "sombrinha", 340, 120, "cabo_guarda", spr_sombrinha, 18);
        break;

    case "rm_a1_ani":
        if (!scr_flag_get("pegou_cabo") && scr_flag_get("ap_sombrinha") == 0) scr_item_spawn(60, 180, spr_cabo_guarda, "pega_cabo");
        // a Fio tá aqui amarrando fita no barbante da Ani
        if (!scr_flag_get("a1_conheceu_fio")) {
            scr_flag_set("a1_conheceu_fio", true);
            scr_char_spawn("fio", 262, 112);
            cs_start([
                ["wait", 30],
                ["move", "player", 150, 132, 1.6],
                ["say", "a1_fio_conhece"],
                ["flag", "conhece_fio", true],
                ["move", "fio", 300, 130, 1.6],
                ["move", "fio", 330, 130, 1.6],
                ["destroy", "fio"]
            ]);
        }
        break;

    case "rm_a1_varanda":
        // a Nana mora aqui, no fogãozinho dela. O Espinho e a Fio vieram na frente.
        var _has = false;
        with (obj_char) if (who == "nana") _has = true;
        if (!_has) scr_char_spawn("nana", 364, 128);
        // quem você fez lembrar no caminho veio morar na Varanda
        if (scr_flag_get("ap_vasinho") == 1) scr_char_spawn("vasinho", 116, 118);
        if (scr_flag_get("ap_sombrinha") == 1) scr_char_spawn("sombrinha", 276, 116);

        if (!scr_flag_get("a1_var_intro")) {
            cs_start([
                ["wait", 20],
                ["say", "a1_var_chegada"],
                ["move", "nana", 300, 150, 2.4],
                ["move", "nana", 66, 196, 2.4],
                ["face", "player", "right"],
                ["face", "nana", "left"],
                ["ask", "a1_nana_conhece", "a1_nana_conhece_opts"],
                ["branch", [["say", "a1_nana_conhece_a"]], [["say", "a1_nana_conhece_b"]]],
                ["say", "a1_var_espinho"],
                ["move", "nana", 300, 150, 1.8],
                ["move", "nana", 364, 128, 1.8],
                ["face", "nana", "down"],
                ["flag", "a1_var_intro", true]
            ]);
        }
        break;
    }
}

// =====================================================================
// CORES PROVISÓRIAS DAS SALAS
// =====================================================================
function scr_room_style(_name) {
    var _s = {
        floor: make_color_rgb(60, 48, 70),
        wall: make_color_rgb(32, 26, 42),
        wall_top: make_color_rgb(82, 66, 98),
        wall_edge: make_color_rgb(20, 16, 26),
        dust: true,
        dark: 0,
        dark_col: make_color_rgb(10, 12, 40)
    };

    var _casa = (_name == "rm_casa_quarto" || _name == "rm_casa" || _name == "rm_casa_deposito");
    if (_casa) {
        _s.floor = make_color_rgb(150, 110, 78);
        _s.wall = make_color_rgb(206, 192, 170);
        _s.wall_top = make_color_rgb(228, 218, 202);
        _s.wall_edge = make_color_rgb(120, 90, 70);
        _s.dust = false;
        _s.dark_col = make_color_rgb(6, 8, 30);
        if (scr_flag_get("noite")) _s.dark = 0.48;
        if (_name == "rm_casa_deposito") _s.dark = 0.56;
    }

    // Avesso: escuro preto de verdade. A luz que ela tem é a Faísca (scr_luz).
    switch (_name) {
        case "rm_a1_queda":    _s.dark = 0.95; break;
        case "rm_a1_corredor": _s.dark = 0.93; break;
        case "rm_a1_ponte":    _s.dark = 0.86; break;
        case "rm_a1_vasinho":  _s.dark = 0.95; break;
        case "rm_a1_vao":      _s.dark = 0.95; break;
        case "rm_a1_ani":      _s.dark = 0.82; break;
    }
    if (string_pos("rm_a1_", _name) == 1) _s.dark_col = make_color_rgb(3, 2, 6);

    if (_name == "rm_a1_varanda") {
        // noite de luzinha: o escuro é roxo e as lâmpadas furam ele
        _s.dark = 0.58;
        _s.dark_col = make_color_rgb(16, 8, 30);
    }

    return _s;
}

// Luzes da sala. Cada uma: { x, y, r (raio), col (cor do brilho), a (força 0..1) }.
// De noite elas "furam" o escuro; de dia/fim de tarde só dão um brilhinho colorido.
function scr_room_lights(_name) {
    var _night = scr_flag_get("noite");
    var _moon = make_color_rgb(120, 150, 255);
    var _warm = make_color_rgb(255, 170, 80);
    switch (_name) {
        case "rm_casa_quarto":
            if (_night) return [
                { x: 208, y: 40,  r: 46, col: _moon, a: 0.9 },
                { x: 208, y: 116, r: 84, col: _moon, a: 0.7 }
            ];
            return [{ x: 68, y: 68, r: 40, col: _warm, a: 0.9 }];   // abajur aceso
        case "rm_casa":
            if (_night) return [
                { x: 568, y: 36,  r: 40, col: _moon, a: 0.9 },
                { x: 566, y: 120, r: 70, col: _moon, a: 0.6 },
                { x: 608, y: 56,  r: 52, col: _warm, a: 1 },        // a porta do depósito aberta
                { x: 608, y: 112, r: 44, col: _warm, a: 0.6 }
            ];
            return [];
        case "rm_casa_deposito":
            return [
                { x: 160, y: 250, r: 80, col: _moon, a: 0.7 },       // luz que entra pela porta
                { x: 160, y: 116, r: 58, col: _warm, a: 1 }          // a música vem daqui
            ];
    }

    // Avesso: o que brilha sozinho (a poeira, a velinha, a Ani) e as coisinhas caídas no chão
    var _gold = make_color_rgb(255, 210, 110);
    var _l = [];
    switch (_name) {
        case "rm_a1_queda": array_push(_l, { x: 150, y: 140, r: 34, col: _gold, a: 0.55 }); break;
        case "rm_a1_ponte": array_push(_l, { x: 336, y: 96, r: scr_flag_get("velinha_rm_a1_ponte") ? 64 : 22, col: _warm, a: 0.9 }); break;
        case "rm_a1_ani":   array_push(_l, { x: 282, y: 80, r: 40, col: make_color_rgb(255, 150, 190), a: 0.55 }); break;
        case "rm_a1_varanda":
            var _win = make_color_rgb(255, 196, 110);
            array_push(_l,
                { x: 128, y: 64, r: 40, col: _win, a: 1 },
                { x: 318, y: 64, r: 40, col: _win, a: 1 },
                { x: 240, y: 78, r: 44, col: _win, a: 1 },
                { x: 240, y: 108, r: 38, col: _win, a: 0.8 },
                { x: 364, y: 98, r: 42 + 3 * sin(current_time / 90), col: make_color_rgb(255, 140, 60), a: 1 },
                { x: 470, y: 116, r: 26, col: _warm, a: 0.9 }
            );
            if (scr_flag_get("velinha_rm_a1_varanda")) array_push(_l, { x: 60, y: 124, r: 40, col: _warm, a: 0.9 });
            var _b = scr_varanda_lampadas();
            for (var i = 0; i < array_length(_b); i++) {
                var _p = _b[i];
                if (_p[2]) array_push(_l, { x: _p[0], y: _p[1] + 2, r: 16, col: _p[3], a: 0.85 });
            }
            break;
    }
    with (obj_interact) if (variable_instance_exists(id, "glint") && glint) {
        array_push(_l, { x: x, y: y - 4, r: 10 + 3 * sin(current_time / 200), col: _gold, a: 0.6 });
    }
    return _l;
}

// Detalhes de chão de cada sala (tapete, azulejo, rachaduras)
function scr_room_draw_floor(_name) {
    switch (_name) {
        case "rm_casa_quarto":
            draw_set_color(make_color_rgb(120, 140, 190));
            draw_ellipse(110, 150, 220, 200, false);
            break;
        case "rm_casa":
            // azulejo da cozinha
            for (var _x = 336; _x < 624; _x += 16) {
                for (var _y = 72; _y < 224; _y += 16) {
                    draw_set_color(((_x + _y) div 16) mod 2 == 0 ? make_color_rgb(220, 220, 225) : make_color_rgb(190, 195, 205));
                    draw_rectangle(_x, _y, _x + 15, _y + 15, false);
                }
            }
            draw_set_color(make_color_rgb(150, 70, 70));
            draw_rectangle(150, 140, 250, 200, false); // tapete da sala
            break;
        case "rm_a1_varanda":
            draw_set_color(make_color_rgb(150, 104, 68));
            for (var _y = 80; _y < 344; _y += 12) draw_line(8, _y, 632, _y);
            break;
        default:
            // rachaduras douradas no chão do Avesso
            draw_set_color(make_color_rgb(110, 90, 60));
            for (var i = 0; i < 6; i++) {
                var _cx = (i * 131 + 40) mod room_width;
                var _cy = 100 + (i * 37) mod 80;
                draw_line(_cx, _cy, _cx + 10, _cy + 4);
                draw_line(_cx + 10, _cy + 4, _cx + 16, _cy + 2);
            }
            break;
    }
}

// Detalhes de parede (janela do quarto, rodapé...)
function scr_room_draw_walls(_name) {
    switch (_name) {
        case "rm_casa_quarto":
            // janela aberta: começo da noite / madrugada
            draw_sprite(spr_janela, scr_flag_get("noite") ? 1 : 0, 176, 16);   // 4x3 tiles na parede
            break;
        case "rm_a1_varanda":
            draw_set_color(make_color_rgb(40, 30, 60));
            draw_rectangle(8, 0, 632, 40, false); // céu do Avesso lá em cima
            draw_set_color(make_color_rgb(255, 220, 140));
            for (var i = 0; i < 20; i++) draw_point((i * 61) mod 620 + 10, (i * 17) mod 36 + 2);
            break;
    }
}

// Coisa caída no chão que dá pra pegar com Z. Brilha um pouquinho no escuro (scr_room_lights).
function scr_item_spawn(_x, _y, _spr, _event) {
    var _i = instance_create_depth(_x, _y, -_y, obj_interact);
    _i.sprite_index = _spr;
    _i.event = _event;
    _i.glint = true;
    return _i;
}
