draw_set_font(global.fnt_dialog);
if (boot_state != "cutscene" && boot_state != "instructions") scr_visual_title();
draw_set_font(global.fnt_dialog);
draw_set_halign(fa_center);
switch (boot_state) {
    case "logo": break;
    case "title":
        if ((boot_timer div 30) mod 2 == 0) scr_pixtext(320, 446, "PRESS Z / ENTER", make_color_rgb(246, 228, 190), 2, fa_center);
        break;
    case "cutscene":
        av_rect(0, 0, 640, 480, make_color_rgb(12, 12, 23));
        av_star(320, 133, make_color_rgb(243, 190, 100), 5);
        draw_set_color(make_color_rgb(237, 225, 201));
        draw_text_ext(320, 197, cutscene_current_text, 34, 510);
        break;
    case "language":
        av_panel(126, 300, 388, 100);
        draw_set_color(make_color_rgb(169, 151, 157));
        draw_text(320, 310, "Idioma / Language");
        draw_set_color(language_index == 0 ? make_color_rgb(243, 190, 100) : c_white);
        draw_text(232, 355, "Português");
        draw_set_color(language_index == 1 ? make_color_rgb(243, 190, 100) : c_white);
        draw_text(410, 355, "English");
        break;
    case "instructions":
        av_rect(0, 0, 640, 480, make_color_rgb(17, 17, 30));
        av_panel(48, 52, 544, 370);
        draw_set_color(make_color_rgb(243, 190, 100));
        draw_text(320, 80, scr_text("instructions_title"));
        draw_set_halign(fa_left);
        draw_set_color(make_color_rgb(237, 225, 201));
        draw_text(80, 142, scr_text("instructions_z"));
        draw_text(80, 180, scr_text("instructions_x"));
        draw_text(80, 218, scr_text("instructions_c"));
        draw_text(80, 256, scr_text("instructions_f4"));
        draw_text(80, 294, scr_text("instructions_esc"));
        draw_set_halign(fa_center);
        draw_set_color(make_color_rgb(243, 190, 100));
        draw_text(320, 366, scr_text("instructions_continue"));
        break;
}
draw_set_halign(fa_left);
draw_set_color(c_white);
