// =====================================================================
// DADOS DOS INIMIGOS (Ecos) E PADRÕES DE ATAQUE
// Pra criar um Eco novo: copie o bloco da Vasinho, troque os textos (chaves do text_db)
// e escreva um padrão novo em scr_battle_pattern.
// =====================================================================

function scr_enemy_get(_id) {
    switch (_id) {
        case "vasinho":
            return {
                id: "vasinho",
                name_key: "en_vasinho",
                sprite: spr_vasinho_batalha,
                scale: 2,
                hp: 12,
                hp_max: 12,
                calm: 0,
                calm_max: 2,
                dmg: 2,                       // dano de cada folha seca
                box: [250, 236, 390, 326],    // caixa da defesa (coordenadas da tela)
                turn_len: 240,                // duração do turno dela, em frames
                pattern: "vasinho",
                intro_key: "bt_vasinho_intro",
                flavor: ["bt_vasinho_flavor_0", "bt_vasinho_flavor_1", "bt_vasinho_flavor_2", "bt_vasinho_flavor_3"],
                turn_lines: ["bt_vasinho_turno_0"], // falas antes de cada turno dela (índice = turno)
                acts: [
                    { label: "bt_act_perguntar", key: "bt_vasinho_perguntar", key2: "bt_vasinho_perguntar_2", calm: 1, used: 0 },
                    { label: "bt_act_elogiar",   key: "bt_vasinho_elogiar",   key2: "bt_vasinho_elogiar",     calm: 0, used: 0 }
                ],
                remember: [],                 // { label, key, calm, need_flag }
                hesitate_key: "bt_vasinho_hesitar",
                hesitate_key2: "bt_vasinho_hesitar_2",
                hesitate_calm: 1,
                hesitate_used: 0,
                calm_key: "bt_vasinho_calma",
                spare_key: "bt_vasinho_despedir",
                hit_key: "bt_vasinho_hit",
                erase_key: "bt_vasinho_apagada"
            };
    }
    show_debug_message("Inimigo desconhecido: " + string(_id));
    return scr_enemy_get("vasinho");
}

// Chamado todo frame durante o turno do inimigo. _b = a instância do obj_battle.
function scr_battle_pattern(_b, _pattern, _t) {
    var _x1 = _b.bx1, _y1 = _b.by1, _x2 = _b.bx2;

    switch (_pattern) {
        case "vasinho":
            // folhas secas caindo balançando (machucam) e gotas d'água (curam)
            if (_t mod 26 == 0) {
                array_push(_b.bullets, {
                    x: random_range(_x1 + 10, _x2 - 10), y: _y1 + 2,
                    vx: 0, vy: 0.9 + random(0.4), r: 4,
                    kind: "folha", t: random(100), sway: random_range(1, 2)
                });
            }
            if (_t mod 55 == 20) {
                array_push(_b.bullets, {
                    x: random_range(_x1 + 10, _x2 - 10), y: _y1 + 2,
                    vx: 0, vy: 1.3, r: 3,
                    kind: "gota", t: 0, sway: 0
                });
            }
            break;
    }
}

// Move cada tipo de "bala"
function scr_battle_bullet_step(_bl) {
    _bl.t += 1;
    switch (_bl.kind) {
        case "folha":
            _bl.x += sin(_bl.t * 0.08) * _bl.sway;
            _bl.y += _bl.vy;
            break;
        default:
            _bl.x += _bl.vx;
            _bl.y += _bl.vy;
            break;
    }
}

function scr_battle_bullet_draw(_bl) {
    switch (_bl.kind) {
        case "folha":
            draw_set_color(make_color_rgb(160, 110, 50));
            draw_ellipse(_bl.x - 5, _bl.y - 3, _bl.x + 5, _bl.y + 3, false);
            draw_set_color(make_color_rgb(100, 60, 20));
            draw_line(_bl.x - 5, _bl.y, _bl.x + 5, _bl.y);
            break;
        case "gota":
            draw_set_color(make_color_rgb(110, 190, 255));
            draw_circle(_bl.x, _bl.y, 3, false);
            draw_triangle(_bl.x - 3, _bl.y, _bl.x + 3, _bl.y, _bl.x, _bl.y - 6, false);
            break;
    }
}

// true = machuca, false = cura
function scr_battle_bullet_hurts(_bl) {
    return (_bl.kind != "gota");
}
