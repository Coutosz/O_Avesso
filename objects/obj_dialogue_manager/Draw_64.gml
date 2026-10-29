if (!dialogue_active) exit;
draw_set_font(global.fnt_dialog);

var _page = dialogue_pages[dialogue_page_index];
var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

// Texto solto no meio da tela (sem caixa)
if (float_mode) {
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_black);
    draw_text_ext(_gw / 2 + 2, _gh * 0.3 + 2, dialogue_current_text, 32, 520);
    draw_set_color(c_white);
    draw_text_ext(_gw / 2, _gh * 0.3, dialogue_current_text, 32, 520);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    exit;
}

// Posição da caixa. Na batalha, quem manda é o obj_battle (box_x/y/w/h).
// Fora dela, a caixa fica embaixo, e vai pra cima se a protagonista estiver na parte de baixo da tela.
var _bx = box_x, _by = box_y, _bw = box_w, _bh = box_h;
if (!instance_exists(obj_battle)) {
    _bx = 32; _bw = 576; _bh = 152;
    _by = 314;
    if (instance_exists(obj_player)) {
        var _cy = camera_get_view_y(view_camera[0]);
        var _vh = camera_get_view_height(view_camera[0]);
        if ((obj_player.y - _cy) / _vh > 0.66) _by = 14;
    }
}
box_draw_y = _by;

av_panel(_bx, _by, _bw, _bh);

// Retrato (48x48 desenhado em 2x). Sem retrato, o nome aparece no canto.
var _por = scr_portrait(_page.spk, _page.expr);
var _tx = _bx + 26;
var _ty = _by + 22;
if (_por != -1) {
    var _talking = !dialogue_full_page && (dialogue_char_index div 4) mod 2 == 0;
    draw_sprite_ext(_por, 0, _bx + 22, _by + (_bh - 96) div 2 + (_talking ? -2 : 0), 2, 2, 0, c_white, 1);
    _tx = _bx + 140;
} else if (_page.spk != "") {
    draw_set_color(make_color_rgb(255, 200, 90));
    draw_text(_tx, _by + 16, scr_speaker_name(_page.spk));
    _ty = _by + 48;
}

// "* " na frente de cada fala, e o texto com recuo
draw_set_color(c_white);
draw_text(_tx, _ty, "*");
draw_text_ext(_tx + 24, _ty, dialogue_current_text, 32, _bx + _bw - (_tx + 24) - 20);

// Setinha piscando quando dá pra avançar
if (dialogue_full_page && !choice_active && (current_time div 300) mod 2 == 0) {
    var _ax = _bx + _bw - 26;
    var _ay = _by + _bh - 22;
    draw_triangle(_ax, _ay, _ax + 10, _ay, _ax + 5, _ay + 6, false);
}

// Escolhas: caixinha do lado direito, em cima da caixa (ou embaixo, se a caixa estiver no topo)
if (choice_active) {
    var _n = array_length(choice_options);
    var _cw = 0;
    for (var i = 0; i < _n; i++) _cw = max(_cw, string_width(choice_options[i]));
    _cw += 64;
    var _ch = _n * 32 + 20;
    var _cx = _bx + _bw - _cw;
    var _cy2 = (_by < _gh / 2) ? _by + _bh + 6 : _by - _ch - 6;

    av_panel(_cx, _cy2, _cw, _ch, true);

    for (var i = 0; i < _n; i++) {
        var _sel = (i == choice_index);
        var _oy = _cy2 + 12 + i * 32;
        draw_set_color(_sel ? make_color_rgb(255, 220, 110) : c_white);
        draw_text(_cx + 40, _oy, choice_options[i]);
        if (_sel) {
            // a luzinha (a "alma") marca a escolha
            var _sx = _cx + 22, _sy = _oy + 14;
            draw_set_color(c_white);
            draw_triangle(_sx, _sy - 6, _sx + 6, _sy, _sx, _sy + 6, false);
            draw_triangle(_sx, _sy - 6, _sx - 6, _sy, _sx, _sy + 6, false);
        }
    }
}

draw_set_color(c_white);
