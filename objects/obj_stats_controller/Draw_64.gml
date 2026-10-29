draw_set_font(fnt_main);

if (room == rm_menu) exit;
if (!global.debug) exit; // HUD de teste: os stats ficam no menu de pausa (C)

draw_set_color(c_white);
draw_text(10, 10, "Gold: " + string(global.gold));
draw_text(10, 30, "LVL: " + string(global.lvl));
draw_text(10, 50, "Gratidão: " + string(global.sanity) + "/" + string(global.sanity_max));