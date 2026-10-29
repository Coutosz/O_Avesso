if (!pause_active) exit;
draw_set_font(global.fnt_dialog);
draw_set_alpha(0.55);
av_rect(0, 0, 640, 480, make_color_rgb(9, 8, 17));
draw_set_alpha(1);
av_panel(32, 30, 576, 420);
draw_set_color(make_color_rgb(243, 190, 100));
draw_text(60, 54, global.player_name);
av_line(60, 91, 578, 91, make_color_rgb(85, 66, 80));
for (var i = 0; i < array_length(pause_tab_names); i++) {
    draw_set_color(i == pause_tab ? make_color_rgb(243, 190, 100) : make_color_rgb(163, 150, 153));
    draw_text(78, 110 + i * 38, scr_text(pause_tab_names[i]));
    if (i == pause_tab) av_star(62, 124 + i * 38, make_color_rgb(243, 190, 100), 4);
}
draw_set_color(make_color_rgb(227, 216, 194));
draw_text(60, 224, scr_text("label_lvl") + ": " + string(global.lvl));
draw_text(60, 258, scr_text("label_hp") + ": " + string(global.hp) + "/" + string(global.hp_max));
draw_text(60, 292, scr_text("label_gold") + ": " + string(global.gold));
draw_text(60, 326, scr_text("label_gratitude"));
av_rect(60, 362, 224, 372, make_color_rgb(75, 52, 63));
av_rect(60, 362, 60 + 164 * global.sanity / global.sanity_max, 372, make_color_rgb(224, 174, 91));
av_line(260, 110, 260, 406, make_color_rgb(85, 66, 80));
if (pause_tab == 0) {
    for (var i = 0; i < array_length(global.inventory); i++) {
        var _item = global.inventory[i];
        draw_set_color(_item == "" ? make_color_rgb(114, 102, 119) : make_color_rgb(230, 218, 194));
        draw_text(286, 112 + i * 36, _item == "" ? scr_text("label_empty_slot") : scr_item_name(_item));
    }
} else {
    draw_set_color(make_color_rgb(230, 218, 194));
    draw_text(286, 118, scr_text("label_gratitude") + ": " + string(global.sanity));
    for (var i = 0; i < array_length(global.party); i++) {
        var _sp = scr_char_sprite(global.party[i]);
        draw_sprite_ext(_sp, 0, 315, 205 + i * 58, 1, 1, 0, c_white, 1);
        draw_text(346, 175 + i * 58, scr_speaker_name(global.party[i]));
    }
}
draw_set_color(c_white);
