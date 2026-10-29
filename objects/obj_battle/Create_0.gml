// Batalha. Criada pela cutscene: ["battle", "vasinho"] (a variável enemy_id vem junto na criação).
// Os dados do inimigo ficam em scr_battle_data.
if (!variable_instance_exists(id, "enemy_id")) enemy_id = "vasinho";
en = scr_enemy_get(enemy_id);

global.battle_result = "";

state = "intro";        // intro, menu, talk, remember, item, attack, enemy_lines, dodge, text, erase, end, gameover
next_state = "";        // pra onde ir depois que a fala atual terminar
menu = ["atacar", "conversar", "lembrar", "item", "hesitar"];
menu_index = 0;
sub_index = 0;
turn = 0;
calm_told = false;
result = "";
remember_list = [];
attack_dmg = 0;

// Caixa larga (texto e menus)
wx1 = 40; wy1 = 230; wx2 = 600; wy2 = 330;
// Caixa da defesa
bx1 = en.box[0]; by1 = en.box[1]; bx2 = en.box[2]; by2 = en.box[3];

// A luzinha da protagonista
soul_x = (bx1 + bx2) / 2;
soul_y = (by1 + by2) / 2;
soul_spd = 2.2;
soul_trail = [];
invuln = 0;

bullets = [];
dodge_t = 0;

// Barra de ataque
bar_x = 0;
bar_done = false;
bar_wait = 0;

// Efeitos no inimigo
enemy_shake = 0;
enemy_alpha = 1;
dmg_text = "";
dmg_timer = 0;

// A caixa de diálogo passa a aparecer dentro da área da batalha
with (obj_dialogue_manager) {
    box_x = other.wx1;
    box_y = other.wy1;
    box_w = other.wx2 - other.wx1;
    box_h = other.wy2 - other.wy1;
}

// Começa com a fala de entrada
battle_say = function(_pages, _then) {
    scr_dialogue_start(_pages);
    state = "text";
    next_state = _then;
};

battle_say(scr_lines(en.intro_key), "menu");
