gpu_set_texfilter(false);
esc_hold_timer = 0;
scr_settings_load();

if (global.fullscreen_enabled) {
    window_set_fullscreen(true);
} else {
    window_center();
}

display_set_gui_size(640, 480);

// Variáveis globais usadas pelos sistemas novos (cutscene, grupo, batalha)
global.debug = false;           // true = mostra HUD de teste e libera as teclas G/H
global.cutscene_active = false;
global.choice = 0;
global.battle_result = "";
global.party = [];
if (!variable_global_exists("player_name")) global.player_name = ""; // o texto usa {nome} desde a abertura

// Fonte pixelada do jogo (spr_fonte, desenhada em 2x). A ordem dos quadros é a desta string.
if (!variable_global_exists("fnt_dialog")) {
    global.fnt_dialog = font_add_sprite_ext(spr_fonte, " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!?.,:;'\"-—_()[]/*+=~%&#$<>|♪…ºªáàâãéêíóôõúüÁÀÂÃÉÊÍÓÔÕÚÜçÇ", true, 2);
}

// Todos os textos do jogo ficam em scr_text_db / scr_text_ato1
scr_text_db_init();

// Teste automático (ferramenta de desenvolvimento): abrir o jogo com OAVESSO_AUTOTEST=1 ou 2
global.autotest_mode = real("0" + string_digits(environment_get_variable("OAVESSO_AUTOTEST")));
if (global.autotest_mode > 0) {
    instance_create_depth(0, 0, 0, obj_dev_autotest);
    room_goto(rm_menu);
}
