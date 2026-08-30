// Não mostra os stats na tela de menu (ainda não faz sentido lá)
if (room == rm_menu) exit;

draw_set_color(c_white);
draw_text(10, 10, "Gold: " + string(global.gold));
draw_text(10, 30, "LVL: " + string(global.lvl));
draw_text(10, 50, "Gratidão: " + string(global.sanity) + "/" + string(global.sanity_max));