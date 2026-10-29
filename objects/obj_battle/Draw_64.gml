draw_set_font(fnt_main);
var _gw = display_get_gui_width();
var _gh = display_get_gui_height();
var _amber = make_color_rgb(255, 190, 80);

// Fundo
av_rect(0, 0, _gw, _gh, make_color_rgb(11, 11, 20));
for (var _i = 0; _i < 32; _i++) av_star(30 + (_i * 101) mod 580, 45 + (_i * 37) mod 164, make_color_rgb(55, 46, 70), 0);
av_line(40, 217, 600, 217, make_color_rgb(76, 57, 78));

// ---------- Game over ----------
if (state == "gameover") {
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text_transformed(_gw / 2, _gh / 2 - 20, scr_text("bt_gameover"), 2, 2, 0);
    draw_set_color(c_gray);
    draw_text(_gw / 2, _gh / 2 + 30, scr_text("bt_gameover_sub"));
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    exit;
}

// ---------- Inimigo ----------
var _ex = _gw / 2 + ((enemy_shake > 0) ? irandom_range(-4, 4) : 0);
draw_sprite_ext(en.sprite, 0, _ex, 200, en.scale, en.scale, 0, c_white, enemy_alpha);

if (dmg_timer > 0) {
    draw_set_halign(fa_center);
    draw_set_color(c_red);
    draw_text_transformed(_gw / 2, 80 - (50 - dmg_timer) * 0.4, dmg_text, 2, 2, 0);
    draw_set_halign(fa_left);
}

// ---------- Caixa ----------
var _dodging = (state == "dodge");
var _x1 = _dodging ? bx1 : wx1;
var _y1 = _dodging ? by1 : wy1;
var _x2 = _dodging ? bx2 : wx2;
var _y2 = _dodging ? by2 : wy2;

if (!(state == "text" && obj_dialogue_manager.dialogue_active)) {
    draw_set_color(c_black);
    draw_rectangle(_x1, _y1, _x2, _y2, false);
    draw_set_color(c_white);
    av_panel(_x1, _y1, _x2 - _x1, _y2 - _y1);
}

// Conteúdo da caixa
switch (state) {
    case "menu":
        var _fkeys = en.flavor;
        draw_set_color(c_white);
        draw_text_ext(wx1 + 16, wy1 + 12, scr_text(_fkeys[turn mod array_length(_fkeys)]), -1, wx2 - wx1 - 32);
        break;

    case "talk":
        for (var i = 0; i < array_length(en.acts); i++) {
            var _sel = (i == sub_index);
            draw_set_color(_sel ? _amber : c_white);
            draw_text(wx1 + 36, wy1 + 12 + i * 20, scr_text(en.acts[i].label));
            if (_sel) draw_text(wx1 + 18, wy1 + 12 + i * 20, ">");
        }
        break;

    case "remember":
        for (var i = 0; i < array_length(remember_list); i++) {
            var _sel = (i == sub_index);
            draw_set_color(_sel ? _amber : c_white);
            draw_text(wx1 + 36, wy1 + 12 + i * 20, scr_text(remember_list[i].label));
            if (_sel) draw_text(wx1 + 18, wy1 + 12 + i * 20, ">");
        }
        break;

    case "item":
        var _n = scr_inventory_count();
        for (var i = 0; i < _n; i++) {
            var _sel = (i == sub_index);
            draw_set_color(_sel ? _amber : c_white);
            draw_text(wx1 + 36, wy1 + 12 + i * 20, scr_item_name(global.inventory[i]));
            if (_sel) draw_text(wx1 + 18, wy1 + 12 + i * 20, ">");
        }
        break;

    case "attack":
        var _bl = wx1 + 20;
        var _br = wx2 - 20;
        var _cy = (wy1 + wy2) / 2;
        var _cx = (_bl + _br) / 2;
        // faixa: quanto mais perto do meio, mais forte
        draw_set_color(make_color_rgb(60, 40, 20));
        draw_rectangle(_bl, _cy - 16, _br, _cy + 16, false);
        draw_set_color(make_color_rgb(140, 90, 40));
        draw_rectangle(_cx - 90, _cy - 16, _cx + 90, _cy + 16, false);
        draw_set_color(_amber);
        draw_rectangle(_cx - 20, _cy - 16, _cx + 20, _cy + 16, false);
        draw_set_color(c_white);
        draw_rectangle(bar_x - 2, _cy - 22, bar_x + 2, _cy + 22, false);
        break;

    case "dodge":
        for (var i = 0; i < array_length(bullets); i++) scr_battle_bullet_draw(bullets[i]);
        // rastro da luzinha
        for (var i = array_length(soul_trail) - 1; i >= 1; i--) {
            draw_set_alpha(0.35 * (1 - i / array_length(soul_trail)));
            draw_set_color(c_white);
            draw_circle(soul_trail[i][0], soul_trail[i][1], 3, false);
        }
        draw_set_alpha(1);
        if (!(invuln > 0 && (invuln div 4) mod 2 == 0)) {
            draw_set_color(c_white);
            draw_circle(soul_x, soul_y, 4, false);
            draw_set_color(make_color_rgb(255, 245, 210));
            draw_circle(soul_x, soul_y, 2, false);
        }
        break;
}

// ---------- Nome do Eco + calma ----------
draw_set_color(c_white);
var _ename = scr_text(en.name_key);
if (calm_told) {
    draw_set_color(_amber);
    _ename += " " + scr_text("bt_calma");
}
draw_text(wx1, 30, _ename);

// ---------- HP da protagonista ----------
var _hy = 342;
draw_set_color(c_white);
draw_text(wx1, _hy, global.player_name);
draw_text(wx1 + 150, _hy, scr_text("label_hp"));
var _barw = 100;
var _hx = wx1 + 180;
draw_set_color(make_color_rgb(80, 30, 30));
draw_rectangle(_hx, _hy + 2, _hx + _barw, _hy + 14, false);
draw_set_color(_amber);
draw_rectangle(_hx, _hy + 2, _hx + _barw * (global.hp / global.hp_max), _hy + 14, false);
draw_set_color(c_white);
draw_text(_hx + _barw + 12, _hy, string(global.hp) + " / " + string(global.hp_max));

// ---------- Botões ----------
var _bw = 92;
var _gap = 8;
var _total = array_length(menu) * _bw + (array_length(menu) - 1) * _gap;
var _bx = (_gw - _total) / 2;
var _by = 380;
for (var i = 0; i < array_length(menu); i++) {
    var _sel = (state == "menu" && i == menu_index);
    var _x = _bx + i * (_bw + _gap);
    draw_set_color(_sel ? _amber : make_color_rgb(150, 150, 150));
    av_panel(_x, _by, _bw, 34, _sel);
    draw_set_color(_sel ? _amber : make_color_rgb(195, 181, 177));
    draw_set_halign(fa_center);
    draw_text(_x + _bw / 2, _by + 8, scr_text("bt_cmd_" + menu[i]));
    draw_set_halign(fa_left);
}

draw_set_color(c_white);
draw_set_alpha(1);
