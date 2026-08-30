if (!pause_active) exit;

var _menu_x = 40;
var _menu_y = 40;
var _menu_w = 560;
var _menu_h = 400;

draw_set_color(c_black);
draw_rectangle(_menu_x, _menu_y, _menu_x + _menu_w, _menu_y + _menu_h, false);
draw_set_color(c_white);
draw_rectangle(_menu_x, _menu_y, _menu_x + _menu_w, _menu_y + _menu_h, true);

// Abas na vertical
var _tab_x = _menu_x + 20;
var _tab_y = _menu_y + 20;
for (var i = 0; i < array_length(pause_tab_names); i++) {
    draw_set_color(i == pause_tab ? c_yellow : c_white);
    draw_text(_tab_x, _tab_y + (i * 30), pause_tab_names[i]);
}

// Espaçamento, depois o bloco de stats
var _stats_y = _tab_y + (array_length(pause_tab_names) * 30) + 40;

draw_set_color(c_white);
draw_text(_tab_x, _stats_y,      "Nome: " + global.player_name);
draw_text(_tab_x, _stats_y + 20, "LVL: " + string(global.lvl));
draw_text(_tab_x, _stats_y + 40, "HP: " + string(global.hp) + "/" + string(global.hp_max));
draw_text(_tab_x, _stats_y + 60, "Gold: " + string(global.gold));
draw_text(_tab_x, _stats_y + 80, "Gratidão: " + string(global.sanity) + "/" + string(global.sanity_max));

// Conteúdo da aba selecionada, do lado direito
var _content_x = _menu_x + 250;
var _content_y = _menu_y + 20;

if (pause_tab == 0) { // Itens
    for (var i = 0; i < array_length(global.inventory); i++) {
        var _item_text = (global.inventory[i] == "") ? scr_text("label_empty_slot") : global.inventory[i];
        draw_text(_content_x, _content_y + (i * 24), _item_text);
    }
}

for (var i = 0; i < array_length(pause_tab_names); i++) {
    draw_set_color(i == pause_tab ? c_yellow : c_white);
    draw_text(_tab_x, _tab_y + (i * 30), scr_text(pause_tab_names[i]));
}

// ...

draw_text(_tab_x, _stats_y,      scr_text("label_name") + ": " + global.player_name);
draw_text(_tab_x, _stats_y + 20, scr_text("label_lvl") + ": " + string(global.lvl));
draw_text(_tab_x, _stats_y + 40, scr_text("label_hp") + ": " + string(global.hp) + "/" + string(global.hp_max));
draw_text(_tab_x, _stats_y + 60, scr_text("label_gold") + ": " + string(global.gold));
draw_text(_tab_x, _stats_y + 80, scr_text("label_gratitude") + ": " + string(global.sanity) + "/" + string(global.sanity_max));