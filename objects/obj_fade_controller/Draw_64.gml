draw_set_font(fnt_main)
if (global.fade_alpha > 0) {
    draw_set_color(c_black);
    draw_set_alpha(global.fade_alpha);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1); // MUITO importante resetar, se n tudo que desenhar depois fica transparente
}