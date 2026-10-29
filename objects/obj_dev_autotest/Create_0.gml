// FERRAMENTA DE DESENVOLVIMENTO: joga o Prólogo + Ato 1 sozinho e escreve no console o que deu errado.
// Só existe quando o jogo é aberto com a variável de ambiente OAVESSO_AUTOTEST=1 (paz: faz os Apagados lembrarem) ou =2 (arde os Apagados).
game_set_speed(240, gamespeed_fps);
step_i = 0;
delay = 0;
fails = 0;
mode = global.autotest_mode;

shots_taken = {};
shot = function(_name) { if (variable_struct_exists(shots_taken, _name)) return; shots_taken[$ _name] = true; screen_save("autotest_" + _name + ".png"); log("print " + _name); };
log = function(_s) { show_debug_message("[AUTOTEST] " + _s); };

steps = [
    ["newgame"],
    ["expect_room", rm_casa_quarto], ["shot", "01_quarto"],
    ["event", "p_desenho"], ["event", "p_cama"],
    ["goto", rm_casa, 36, 150], ["shot", "02_casa"], ["walk", 420, 150], ["shot", "03_cozinha"],
    ["event", "talk_mae"], ["event", "talk_mae"], ["event", "talk_mae"], ["event", "talk_mae"],
    ["event", "talk_pai"], ["event", "talk_pai"], ["event", "p_porta"], ["event", "talk_pai"], ["event", "talk_pai"],
    ["event", "p_estante"], ["event", "p_calendario"], ["event", "p_geladeira"], ["event", "p_tv"],
    ["event", "p_sofa"], ["event", "p_mesa"], ["event", "p_pia"],
    ["goto", rm_casa_quarto, 130, 132],
    ["event", "p_cama"],
    ["expect_flag", "noite"],
    ["goto", rm_casa, 590, 112],
    ["event", "p_porta"],
    ["expect_room", rm_casa_deposito], ["shot", "04_deposito"],
    ["event", "p_deposito_caixas"],
    ["event", "p_lencol"],
    ["expect_room", rm_a1_queda], ["wait", 60], ["shot", "05_queda"],
    ["event", "a1_poeira"],
    ["goto", rm_a1_corredor, 28, 136],
    ["event", "a1_mala"], ["event", "a1_cadeira"], ["event", "a1_ventilador"], ["event", "a1_carrinho"], ["event", "a1_patinete"],
    ["walk", 200, 136], ["wait", 60], ["shot", "06_corredor"],
    ["walk", 281, 136], ["wait", 20],
    ["expect_flag", "a1_faisca_achou"], ["expect_party", "faisca"], ["expect_flag", "a1_tut_escuro"],
    ["event", "talk_faisca"], ["event", "talk_faisca"], ["event", "talk_faisca"],
    ["call", function() { global.autotest_brilhar = true; }], ["wait", 40], ["shot", "07_brilhar"], ["call", function() { global.autotest_brilhar = false; }],
    ["goto", rm_a1_ponte, 28, 136],
    ["walk", 84, 136], ["wait", 20], ["expect_flag", "a1_conheceu_espinho"],
    ["walk", 145, 112], ["event", "a1_sino"],
    ["expect_flag", "a1_ponte1"], ["wait", 60],
    ["walk", 271, 136], ["wait", 20], ["shot", "08_ponte"], ["event", "velinha"], ["event", "velinha"],
    ["goto", rm_a1_vasinho, 28, 136],
    ["walk", 139, 136], ["wait", 20],
    ["expect_flag", "a1_vasinho_feito"], ["shot", "09_apagado"],
    ["use", "pega_regador"], ["expect_flag", "pegou_regador"],
    ["near_ap", "vasinho"], ["wait", 30], ["shot", "10_apagado_luz"],
    (mode == 2) ? ["arder", "vasinho"] : ["lembrar", "vasinho"],
    ["wait", 90],
    ["expect_val", "ap_vasinho", (mode == 2) ? 2 : 1],
    ["goto", rm_a1_vao, 28, 130],
    ["walk", 119, 130], ["walk", 189, 130], ["wait", 20], ["shot", "11_vao"], ["walk", 217, 130], ["event", "a1_sino2"], ["walk", 300, 130],
    ["goto", rm_a1_ani, 28, 136],
    ["wait", 30], ["expect_flag", "conhece_fio"],
    ["shot", "12_ani"], ["event", "talk_ani"], ["event", "talk_ani"], ["event", "talk_ani"], ["event", "talk_ani"],
    ["use", "pega_cabo"], ["expect_flag", "pegou_cabo"],
    ["goto", rm_a1_vao, 360, 130],
    ["near_ap", "sombrinha"], ["wait", 30],
    (mode == 2) ? ["arder", "sombrinha"] : ["lembrar", "sombrinha"],
    ["wait", 90],
    ["expect_val", "ap_sombrinha", (mode == 2) ? 2 : 1],
    ["goto", rm_a1_varanda, 26, 200],
    ["expect_flag", "a1_var_intro"],
    ["expect_party", "faisca"], ["walk", 250, 200], ["wait", 40], ["shot", "13_varanda"],
    ["walk", 400, 176], ["wait", 20], ["shot", "13b_varanda_direita"],
    ["event", "talk_espinho"], ["event", "talk_espinho"], ["event", "talk_fio"], ["event", "talk_fio"],
    ["event", "talk_faisca"], ["event", "talk_faisca"], ["event", "talk_faisca"], ["event", "talk_faisca"], ["event", "talk_faisca"], ["event", "talk_faisca"],
    ["event", "talk_relogio"], ["event", "a1_rede"], ["event", "a1_panela"], ["event", "a1_cadeira_praia"],
    (mode == 2) ? ["wait", 1] : ["event", "talk_vasinho"],
    (mode == 2) ? ["wait", 1] : ["event", "talk_sombrinha"],
    ["walk", 70, 150],
    ["event", "velinha"],
    ["event", "talk_nana"],
    ["expect_flag", "a1_pronto"],
    ["expect_flag", "promessa_nana"],
    ["expect_party", "faisca"],
    ["saveload"],
    ["expect_room", rm_a1_varanda],
    ["expect_party", "faisca"],
    ["walk", 440, 176], ["walk", 474, 176],
    ["expect_room", rm_menu],
    ["done"]
];

// Modo 3: vitrine. Passa pela casa parando nos diálogos pra tirar print da arte.
global.autotest_hold = false;
if (mode == 3) steps = [
    ["newgame"], ["wait", 200],
    ["walk", 150, 150], ["face", "up"], ["wait", 30], ["shot", "v01_quarto"],
    ["hold", true], ["walk", 96, 120], ["face", "up"], ["event", "p_colecao"], ["wait", 400], ["shotnow", "v02_quarto_dialogo"], ["hold", false],
    ["goto", rm_casa, 36, 150], ["walk", 236, 210], ["face", "right"], ["wait", 30], ["shot", "v03_sala"],
    ["hold", true], ["event", "talk_pai"], ["wait", 500], ["shotnow", "v04_pai"], ["hold", false], ["wait", 60],
    ["walk", 470, 160], ["face", "up"], ["wait", 30], ["shot", "v05_cozinha"],
    ["hold", true], ["event", "talk_mae"], ["wait", 300], ["shotnow", "v06_mae"], ["hold", false], ["wait", 60],
    ["event", "talk_mae"], ["wait", 30], ["hold", true], ["event", "talk_mae"], ["wait", 400], ["shotnow", "v07_mae_cansada"], ["hold", false], ["wait", 60],
    ["goto", rm_casa_quarto, 130, 132], ["event", "p_cama"], ["wait", 200], ["walk", 200, 120], ["face", "down"], ["wait", 30], ["shot", "v08_quarto_noite"],
    ["goto", rm_casa, 560, 130], ["face", "right"], ["wait", 30], ["shot", "v09_casa_noite"],
    ["event", "p_porta"], ["wait", 200], ["walk", 160, 200], ["face", "up"], ["wait", 30], ["shot", "v10_deposito"],
    ["done"]
];
if (mode == 3) game_set_speed(120, gamespeed_fps);

log("comecando, modo " + string(mode));

// Modo 4: revisão visual. Não salva nem carrega a partida do usuário.
if (mode == 4) {
    game_set_speed(120, gamespeed_fps);
    steps = [
        ["wait", 60], ["shotnow", "30_menu"],
        ["newgame"], ["wait", 120], ["walk", 178, 140], ["face", "down"],
        ["shot", "31_quarto"],
        ["call", function() { obj_pause_menu.pause_active = true; }],
        ["wait", 30], ["shotnow", "32_pause"],
        ["call", function() { obj_pause_menu.pause_active = false; }],
        ["goto", rm_casa, 236, 210], ["face", "up"], ["wait", 30], ["shot", "33_sala"],
        ["hold", true], ["event", "talk_pai"], ["wait", 500], ["shotnow", "34_pai"], ["hold", false],
        ["goto", rm_casa, 475, 156], ["face", "up"], ["wait", 30], ["shot", "35_cozinha"],
        ["hold", true], ["event", "talk_mae"], ["wait", 400], ["shotnow", "36_mae"], ["hold", false],
        ["goto", rm_casa_quarto, 166, 137], ["event", "p_cama"], ["wait", 150], ["face", "down"], ["shot", "37_quarto_noite"],
        ["goto", rm_casa_deposito, 160, 192], ["face", "up"], ["wait", 30], ["shot", "38_deposito"],
        ["goto", rm_a1_queda, 150, 128], ["wait", 60], ["shot", "39_queda"],
        ["goto", rm_a1_corredor, 270, 136], ["wait", 60], ["shot", "40_corredor"],
        ["goto", rm_a1_ponte, 300, 135], ["wait", 30], ["shot", "41_ponte"],
        ["goto", rm_a1_ani, 145, 136], ["wait", 60], ["shot", "42_ani"],
        ["goto", rm_a1_varanda, 250, 200], ["wait", 120], ["shot", "43_varanda"],
        ["done"]
    ];
}

// Modo 5: tela inicial. Para na tela do título, tira print, depois tira print do menu. Não salva nada.
if (mode == 5) {
    game_set_speed(60, gamespeed_fps);
    steps = [
        ["wait", 30],
        ["call", function() { room_goto(rm_boot); }], ["wait", 20],
        ["call", function() { obj_boot_sequence.boot_state = "title"; obj_boot_sequence.boot_timer = 0; global.title_t = 0; }],
        ["wait", 200], ["shotnow", "50_titulo"],
        ["wait", 32], ["shotnow", "51_titulo_pisca"],
        ["wait", 230], ["shotnow", "51b_titulo_olhos"],
        ["call", function() { room_goto(rm_menu); }],
        ["wait", 160], ["shotnow", "52_menu"],
        ["call", function() { obj_menu_controller.menu_index = 1; }],
        ["wait", 20], ["shotnow", "53_menu_novo"],
        ["done"]
    ];
}
