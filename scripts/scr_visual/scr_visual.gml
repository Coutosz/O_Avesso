// Direção visual O Avesso: casa âmbar, retalhos e luz no mundo violeta.
// Coordenadas inteiras e desenhos sem filtragem: uma unidade = um pixel do mundo.
function av_rect(_x1, _y1, _x2, _y2, _col) {
    draw_set_color(_col);
    draw_rectangle(round(_x1), round(_y1), round(_x2), round(_y2), false);
}
function av_line(_x1, _y1, _x2, _y2, _col) {
    draw_set_color(_col);
    draw_line(round(_x1), round(_y1), round(_x2), round(_y2));
}
function av_star(_x, _y, _col, _s = 1) {
    av_rect(_x - _s, _y, _x + _s, _y, _col);
    av_rect(_x, _y - _s, _x, _y + _s, _col);
}
function av_shadow(_x, _y, _w = 10) {
    draw_set_alpha(0.22);
    draw_set_color(make_color_rgb(22, 14, 28));
    draw_ellipse(round(_x - _w), round(_y - 2), round(_x + _w), round(_y + 2), false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}
function av_planks(_x, _y, _w, _h, _aged = false) {
    var _base = _aged ? make_color_rgb(113, 75, 76) : make_color_rgb(208, 157, 98);
    var _line = _aged ? make_color_rgb(82, 53, 68) : make_color_rgb(160, 110, 68);
    var _light = _aged ? make_color_rgb(139, 91, 89) : make_color_rgb(231, 184, 122);
    av_rect(_x, _y, _x + _w, _y + _h, _base);
    for (var _r = 0; _r < ceil(_h / 10); _r++) {
        var _py = _y + _r * 10;
        av_line(_x, _py, _x + _w, _py, _line);
        av_line(_x, _py + 1, _x + _w, _py + 1, _light);
        for (var _px = _x + ((_r mod 3) * 19); _px < _x + _w; _px += 64) {
            av_line(_px, _py + 2, _px, min(_py + 9, _y + _h), _line);
            if ((_r + _px div 64) mod 3 == 0) {
                av_line(_px + 12, _py + 5, min(_px + 28, _x + _w), _py + 5, _light);
                av_line(_px + 29, _py + 7, min(_px + 34, _x + _w), _py + 7, _line);
            }
        }
    }
}
function av_rug(_x, _y, _w, _h, _col) {
    var _cream = make_color_rgb(237, 210, 158);
    var _dark = merge_color(_col, c_black, 0.30);
    av_rect(_x - 1, _y + 3, _x + _w + 1, _y + _h - 3, _dark);
    av_rect(_x + 3, _y - 1, _x + _w - 3, _y + _h + 1, _dark);
    av_rect(_x, _y + 3, _x + _w, _y + _h - 3, _cream);
    av_rect(_x + 3, _y, _x + _w - 3, _y + _h, _cream);
    av_rect(_x + 4, _y + 4, _x + _w - 4, _y + _h - 4, _col);
    for (var _px = _x + 8; _px < _x + _w - 6; _px += 6) {
        av_rect(_px, _y + 6, _px + 1, _y + 6, _cream);
        av_rect(_px, _y + _h - 6, _px + 1, _y + _h - 6, _cream);
    }
    for (var _py = _y + 12; _py < _y + _h - 10; _py += 16) {
        for (var _px = _x + 16; _px < _x + _w - 12; _px += 24) {
            av_line(_px, _py - 3, _px + 3, _py, _cream);
            av_line(_px + 3, _py, _px, _py + 3, _cream);
            av_line(_px, _py + 3, _px - 3, _py, _cream);
            av_line(_px - 3, _py, _px, _py - 3, _cream);
        }
    }
    for (var _py = _y + 5; _py < _y + _h - 3; _py += 4) {
        av_line(_x - 3, _py, _x - 2, _py, _cream);
        av_line(_x + _w + 2, _py, _x + _w + 3, _py, _cream);
    }
}
function av_picture(_x, _y, _w = 24, _h = 22) {
    av_rect(_x, _y, _x + _w, _y + _h, make_color_rgb(60, 37, 29));
    av_rect(_x + 1, _y + 1, _x + _w - 1, _y + _h - 1, make_color_rgb(190, 126, 64));
    av_rect(_x + 3, _y + 3, _x + _w - 3, _y + _h - 3, make_color_rgb(238, 208, 145));
    av_rect(_x + 4, _y + 4, _x + _w - 4, _y + _h - 8, make_color_rgb(109, 152, 146));
    draw_set_color(make_color_rgb(72, 108, 93));
    draw_triangle(_x + 4, _y + _h - 4, _x + _w / 2, _y + 8, _x + _w - 4, _y + _h - 4, false);
    av_rect(_x + _w - 9, _y + 6, _x + _w - 6, _y + 9, make_color_rgb(255, 226, 146));
}
function av_sconce(_x, _y) {
    av_rect(_x - 3, _y - 5, _x + 3, _y + 4, make_color_rgb(80, 47, 39));
    av_rect(_x - 2, _y - 4, _x + 2, _y + 1, make_color_rgb(236, 173, 72));
    av_rect(_x - 1, _y - 3, _x, _y, make_color_rgb(255, 237, 174));
    av_line(_x - 4, _y + 3, _x + 4, _y + 3, make_color_rgb(190, 116, 58));
}
function av_arch(_x, _y, _w, _h, _sky) {
    var _edge = make_color_rgb(143, 116, 134);
    av_rect(_x - 2, _y + 8, _x + _w + 2, _y + _h + 2, _edge);
    av_rect(_x + 3, _y + 3, _x + _w - 3, _y + _h, _edge);
    av_rect(_x + 8, _y, _x + _w - 8, _y + _h, _edge);
    av_rect(_x, _y + 10, _x + _w, _y + _h, _sky);
    av_rect(_x + 5, _y + 5, _x + _w - 5, _y + _h, _sky);
    av_rect(_x + 9, _y + 2, _x + _w - 9, _y + _h, _sky);
    av_line(_x + _w / 2, _y + 2, _x + _w / 2, _y + _h, _edge);
    av_line(_x, _y + _h - 9, _x + _w, _y + _h - 9, _edge);
}
function scr_visual_house(_name) {
    var _dark = make_color_rgb(49, 32, 30);
    var _cream = make_color_rgb(237, 219, 170);
    var _sage = make_color_rgb(104, 130, 101);
    var _deposit = (_name == "rm_casa_deposito");
    var _left = _deposit ? 48 : 16;
    var _right = room_width - _left;
    av_rect(0, 0, room_width, room_height, _dark);
    av_planks(_left, 80, _right - _left, room_height - 96);
    av_rect(_left, 16, _right - 1, 61, _cream);
    av_rect(_left, 17, _right - 1, 19, make_color_rgb(255, 235, 185));
    for (var _x = _left + 12; _x < _right; _x += 24) {
        av_line(_x, 21, _x, 58, make_color_rgb(222, 201, 151));
        av_line(_x + 1, 21, _x + 1, 58, make_color_rgb(244, 226, 181));
    }
    av_rect(_left, 61, _right - 1, 78, make_color_rgb(123, 78, 47));
    av_line(_left, 61, _right - 1, 61, make_color_rgb(82, 49, 35));
    av_line(_left, 63, _right - 1, 63, make_color_rgb(202, 145, 78));
    for (var _x = _left + 3; _x < _right - 3; _x += 32) {
        av_rect(_x, 66, min(_x + 25, _right - 3), 74, make_color_rgb(155, 103, 56));
        av_line(_x, 74, min(_x + 25, _right - 3), 74, make_color_rgb(87, 55, 36));
    }
    av_rect(_left, 78, _right - 1, 80, make_color_rgb(78, 48, 35));
    av_line(_left, 81, _right - 1, 81, make_color_rgb(235, 182, 112));
    av_line(_left - 1, 80, _left - 1, room_height - 16, make_color_rgb(243, 188, 114));
    av_line(_right, 80, _right, room_height - 16, make_color_rgb(243, 188, 114));
    av_rect(_left, room_height - 16, _right, room_height - 13, make_color_rgb(98, 58, 38));
    switch (_name) {
        case "rm_casa_quarto":
            av_rug(112, 152, 108, 48, _sage);
            av_picture(117, 27, 27, 24);
            draw_sprite(spr_janela, scr_flag_get("noite") ? 1 : 0, 176, 17);
            av_sconce(281, 45);
            // The passage on the right is exactly the existing door collision gap.
            av_rect(304, 129, 319, 174, make_color_rgb(160, 110, 68));
            av_line(306, 129, 306, 174, make_color_rgb(237, 197, 131));
            av_line(307, 174, 319, 174, _dark);
            // Child's collection: pebbles and caps, part of the floor decoration.
            av_rect(148, 177, 170, 190, make_color_rgb(229, 207, 164));
            av_star(152, 182, make_color_rgb(115, 143, 159));
            av_rect(160, 180, 163, 183, make_color_rgb(194, 103, 81));
            av_rect(164, 186, 167, 188, make_color_rgb(105, 123, 93));
            break;
        case "rm_casa":
            av_rug(120, 137, 150, 70, make_color_rgb(151, 77, 61));
            av_picture(112, 26, 38, 26);
            av_sconce(288, 41);
            av_rect(0, 130, 15, 174, make_color_rgb(160, 110, 68));
            av_line(12, 130, 12, 174, make_color_rgb(237, 197, 131));
            // The kitchen shares the same level, with a distinct ceramic floor.
            av_rect(336, 81, 623, 223, make_color_rgb(203, 196, 151));
            for (var _x = 336; _x < 624; _x += 16) {
                for (var _y = 82; _y < 224; _y += 16) {
                    var _col = ((_x div 16 + _y div 16) mod 2 == 0) ? make_color_rgb(229, 221, 174) : make_color_rgb(165, 183, 142);
                    av_rect(_x + 1, _y + 1, _x + 14, min(_y + 14, 223), _col);
                    av_line(_x + 2, _y + 2, _x + 13, _y + 2, merge_color(_col, c_white, 0.14));
                }
            }
            av_rect(329, 81, 335, 223, make_color_rgb(134, 89, 54));
            av_line(332, 82, 332, 223, make_color_rgb(231, 184, 122));
            av_rect(337, 21, 623, 60, make_color_rgb(234, 225, 187));
            for (var _x = 337; _x < 624; _x += 16) {
                av_line(_x, 21, _x, 60, make_color_rgb(183, 184, 150));
                av_rect(_x + 7, 29, _x + 9, 31, _sage);
                av_rect(_x + 7, 45, _x + 9, 47, _sage);
            }
            av_line(337, 36, 623, 36, make_color_rgb(183, 184, 150));
            av_line(337, 52, 623, 52, make_color_rgb(183, 184, 150));
            draw_sprite(spr_janela, scr_flag_get("noite") ? 1 : 0, 548, 18);
            av_rug(416, 166, 96, 51, make_color_rgb(122, 138, 107));
            // Copper rail and kitchen utensils.
            av_line(444, 28, 532, 28, make_color_rgb(89, 58, 40));
            for (var _i = 0; _i < 4; _i++) {
                var _px = 452 + _i * 18;
                av_line(_px, 29, _px, 42, make_color_rgb(155, 99, 52));
                av_rect(_px - 2, 40, _px + 2, 43, make_color_rgb(197, 129, 59));
                av_line(_px - 1, 40, _px - 1, 42, make_color_rgb(246, 193, 111));
            }
            break;
        case "rm_casa_deposito":
            av_rect(48, 18, 271, 60, make_color_rgb(178, 151, 109));
            for (var _x = 53; _x < 272; _x += 12) av_line(_x, 20, _x, 59, make_color_rgb(151, 123, 92));
            av_sconce(160, 42);
            av_rug(117, 153, 86, 38, make_color_rgb(117, 93, 101));
            av_rect(145, 224, 176, 239, make_color_rgb(172, 127, 77));
            av_line(148, 229, 173, 229, make_color_rgb(223, 183, 116));
            break;
    }
    draw_set_color(c_white);
}
function scr_visual_avesso(_name) {
    var _floor = make_color_rgb(53, 43, 70);
    var _seam = make_color_rgb(39, 32, 55);
    var _wall = make_color_rgb(45, 33, 61);
    var _trim = make_color_rgb(116, 85, 114);
    if (_name == "rm_a1_corredor") { _floor = make_color_rgb(49, 61, 72); _wall = make_color_rgb(36, 40, 58); }
    if (_name == "rm_a1_vasinho") { _floor = make_color_rgb(50, 70, 65); _wall = make_color_rgb(31, 52, 53); _trim = make_color_rgb(100, 129, 105); }
    if (_name == "rm_a1_ani") { _floor = make_color_rgb(76, 48, 77); _wall = make_color_rgb(53, 31, 58); }
    if (_name == "rm_a1_vao") { _floor = make_color_rgb(41, 40, 67); _wall = make_color_rgb(29, 26, 49); }
    av_rect(0, 0, room_width, room_height, make_color_rgb(17, 15, 30));
    av_rect(8, 72, room_width - 9, room_height - 9, _floor);
    if (_name == "rm_a1_varanda") {
        av_planks(8, 72, room_width - 16, room_height - 80, true);
        av_rug(84, 198, 122, 68, make_color_rgb(87, 65, 111));
        av_rug(354, 154, 143, 84, make_color_rgb(117, 72, 69));
    } else {
        for (var _y = 72; _y < room_height - 8; _y += 16) {
            var _off = ((_y div 16) mod 2) * 16;
            av_line(8, _y, room_width - 9, _y, _seam);
            for (var _x = 8 + _off; _x < room_width - 8; _x += 32) {
                av_line(_x, _y, _x, min(_y + 15, room_height - 9), _seam);
                if ((_x div 32 + _y div 16) mod 4 == 0) {
                    av_line(_x + 4, _y + 2, min(_x + 25, room_width - 12), _y + 2, merge_color(_floor, c_white, 0.075));
                    av_line(_x + 5, _y + 11, _x + 11, _y + 11, merge_color(_floor, _seam, 0.5));
                }
            }
        }
    }
    with (obj_wall) {
        if (object_index != obj_wall) continue;
        av_rect(bbox_left, bbox_top, bbox_right, bbox_bottom, _wall);
        for (var _y = max(8, bbox_top + 5); _y < bbox_bottom - 4; _y += 16) {
            av_line(bbox_left + 2, _y, bbox_right - 2, _y, merge_color(_wall, c_black, 0.22));
        }
        av_rect(bbox_left, bbox_bottom - 5, bbox_right, bbox_bottom - 3, _trim);
        av_line(bbox_left, bbox_bottom - 2, bbox_right, bbox_bottom - 2, make_color_rgb(31, 23, 42));
        av_line(bbox_left, bbox_bottom, bbox_right, bbox_bottom, merge_color(_trim, make_color_rgb(228, 182, 106), 0.25));
    }
    // Architecture changes per room, rather than repeating the same empty corridor.
    switch (_name) {
        case "rm_a1_queda":
            av_arch(124, 18, 72, 44, make_color_rgb(23, 22, 41));
            av_star(164, 34, make_color_rgb(242, 193, 119), 2);
            av_line(42, 151, 74, 151, make_color_rgb(136, 106, 80));
            av_line(74, 151, 82, 159, make_color_rgb(190, 149, 87));
            break;
        case "rm_a1_corredor":
            for (var _x = 48; _x < room_width - 32; _x += 96) {
                av_arch(_x, 19, 32, 39, make_color_rgb(18, 28, 43));
                av_rect(_x - 4, 60, _x + 36, 63, make_color_rgb(100, 92, 97));
            }
            break;
        case "rm_a1_ponte":
        case "rm_a1_vao":
            for (var _x = 48; _x < room_width - 32; _x += 96) {
                av_rect(_x, 20, _x + 10, 68, make_color_rgb(79, 63, 96));
                av_rect(_x - 3, 20, _x + 13, 25, make_color_rgb(129, 105, 130));
                av_rect(_x - 2, 64, _x + 12, 70, make_color_rgb(116, 91, 119));
                av_line(_x + 3, 28, _x + 3, 61, make_color_rgb(110, 89, 123));
            }
            break;
        case "rm_a1_vasinho":
            for (var _x = 34; _x < 288; _x += 76) {
                av_arch(_x, 15, 46, 47, make_color_rgb(22, 38, 44));
                av_star(_x + 11, 31, make_color_rgb(182, 196, 137));
                for (var _i = 0; _i < 4; _i++) {
                    av_rect(_x - 3 + (_i mod 2) * 4, 25 + _i * 9, _x + (_i mod 2) * 4, 28 + _i * 9, make_color_rgb(97, 133, 92));
                }
            }
            break;
        case "rm_a1_ani":
            for (var _x = 30; _x < 290; _x += 18) {
                av_line(_x, 26 + (_x div 18 mod 2) * 4, _x + 18, 26 + ((_x div 18 + 1) mod 2) * 4, make_color_rgb(151, 126, 137));
                av_rect(_x + 7, 32, _x + 10, 38, make_color_rgb(134, 90, 133));
            }
            av_rug(124, 128, 77, 47, make_color_rgb(113, 70, 106));
            break;
        case "rm_a1_varanda":
            av_rect(8, 0, room_width - 9, 51, make_color_rgb(23, 24, 45));
            for (var _i = 0; _i < 45; _i++) {
                var _sx = 15 + (_i * 73) mod (room_width - 30);
                var _sy = 5 + (_i * 17) mod 40;
                av_star(_sx, _sy, (_i mod 4 == 0) ? make_color_rgb(231, 193, 131) : make_color_rgb(91, 96, 133), (_i mod 9 == 0) ? 1 : 0);
            }
            av_rect(8, 52, room_width - 9, 58, make_color_rgb(137, 99, 98));
            av_rect(8, 59, room_width - 9, 63, make_color_rgb(53, 37, 59));
            for (var _x = 12; _x < room_width - 8; _x += 20) av_rect(_x, 58, _x + 3, 70, make_color_rgb(99, 67, 79));
            av_sconce(38, 49); av_sconce(605, 49);
            break;
    }
    draw_set_color(c_white);
}
function scr_visual_room(_name) {
    gpu_set_texfilter(false);
    // Sala com cenário pintado (spr_bg_<sala sem "rm_">): desenha ele e pronto
    var _bgn = "spr_bg_" + string_delete(_name, 1, 3);
    var _bg = asset_get_index(_bgn);
    if (_bg != -1 && asset_get_type(_bgn) == asset_sprite) {
        draw_sprite(_bg, 0, 0, 0);
    }
    else if (string_pos("rm_casa", _name) == 1) scr_visual_house(_name);
    else scr_visual_avesso(_name);
    draw_set_alpha(1);
    draw_set_color(c_white);
}
function scr_visual_decor(_name) {
    // Decorative solids live at the room edges; the original routes stay clear.
    if (_name == "rm_casa_quarto") {
        instance_create_depth(272, 120, -120, obj_interact_solid, { sprite_index: spr_estante, visual_decor: true });
        instance_create_depth(256, 211, -211, obj_interact_solid, { sprite_index: spr_mesa, visual_decor: true });
        instance_create_depth(253, 218, -218, obj_interact_solid, { sprite_index: spr_cadeira, visual_decor: true });
    }
}
function av_drawing(_x, _y) {
    av_rect(_x - 10, _y - 13, _x + 10, _y - 1, make_color_rgb(115, 76, 55));
    av_rect(_x - 10, _y - 14, _x + 9, _y - 2, make_color_rgb(245, 226, 183));
    av_line(_x - 6, _y - 7, _x - 2, _y - 11, make_color_rgb(158, 95, 80));
    av_line(_x - 2, _y - 11, _x + 2, _y - 7, make_color_rgb(158, 95, 80));
    av_rect(_x - 5, _y - 7, _x + 1, _y - 4, make_color_rgb(133, 160, 115));
    av_star(_x + 5, _y - 11, make_color_rgb(230, 174, 61));
}
function av_panel(_x, _y, _w, _h, _active = false) {
    av_rect(_x + 4, _y + 6, _x + _w + 4, _y + _h + 6, make_color_rgb(7, 7, 14));
    av_rect(_x, _y, _x + _w, _y + _h, _active ? make_color_rgb(243, 190, 100) : make_color_rgb(236, 227, 205));
    av_rect(_x + 4, _y + 4, _x + _w - 4, _y + _h - 4, make_color_rgb(12, 12, 21));
    av_rect(_x + 8, _y + 8, _x + _w - 8, _y + _h - 8, make_color_rgb(20, 19, 30));
    av_rect(_x + 4, _y + 4, _x + 10, _y + 10, make_color_rgb(243, 190, 100));
    av_rect(_x + _w - 10, _y + _h - 10, _x + _w - 4, _y + _h - 4, make_color_rgb(243, 190, 100));
    draw_set_color(c_white);
}
// =====================================================================
// TELA INICIAL — "THE OTHER SIDE"
// Fundo: spr_titulo_fundo (320x240, o pixel do jogo, desenhado em 2x). Título: spr_titulo_logo.
// Por cima: poeira dourada subindo, brilho nos pingentes e, de vez em quando, os olhos dela no capuz.
// =====================================================================
function scr_visual_title() {
    if (!variable_global_exists("title_t")) global.title_t = 0;
    global.title_t += 1;
    var _t = global.title_t;
    draw_sprite_ext(spr_titulo_fundo, 0, 0, 0, 2, 2, 0, c_white, 1);

    // os olhos dela abrem no escuro do capuz, mais ou menos a cada 9 segundos
    var _cyc = _t mod 560;
    if (_cyc > 400 && _cyc < 520) {
        var _a = min(1, (_cyc - 400) / 24) * min(1, (520 - _cyc) / 24);
        if (_cyc > 455 && _cyc < 462) _a = 0;   // pisca
        draw_set_alpha(_a * 0.3);
        draw_set_color(make_color_rgb(255, 40, 50));
        draw_rectangle(153 * 2, 65 * 2, 158 * 2 - 1, 68 * 2 - 1, false);
        draw_rectangle(162 * 2, 65 * 2, 167 * 2 - 1, 68 * 2 - 1, false);
        draw_set_alpha(_a);
        draw_set_color(make_color_rgb(220, 30, 40));
        draw_rectangle(155 * 2, 66 * 2, 157 * 2 - 1, 67 * 2 - 1, false);
        draw_rectangle(164 * 2, 66 * 2, 166 * 2 - 1, 67 * 2 - 1, false);
        draw_set_alpha(1);
    }

    // um pingente brilha de cada vez
    var _pend = [[120, 73], [200, 73], [96, 98], [224, 98], [159, 118]];
    var _k = (_t div 47) mod array_length(_pend);
    var _ph = _t mod 47;
    if (_ph < 16) {
        var _gx = _pend[_k][0] * 2, _gy = _pend[_k][1] * 2;
        draw_set_alpha(1 - abs(_ph - 8) / 8);
        draw_set_color(make_color_rgb(255, 238, 176));
        draw_rectangle(_gx, _gy - 4, _gx + 1, _gy + 5, false);
        draw_rectangle(_gx - 4, _gy, _gx + 5, _gy + 1, false);
        draw_set_alpha(1);
    }

    // poeira dourada subindo devagar
    draw_set_color(make_color_rgb(255, 210, 120));
    for (var i = 0; i < 26; i++) {
        var _px = ((i * 53 + 17) mod 320) + round(sin(_t / 70 + i) * 3);
        var _py = 240 - ((_t * (0.10 + (i mod 4) * 0.05) + i * 37) mod 260);
        draw_set_alpha(0.2 + 0.35 * abs(sin(_t / 45 + i)));
        draw_rectangle(_px * 2, round(_py) * 2, _px * 2 + 1, round(_py) * 2 + 1, false);
    }
    draw_set_alpha(1);

    draw_sprite_ext(spr_titulo_logo, 0, 320, 10, 2, 2, 0, c_white, 1);

    // entra devagar do preto
    if (_t < 90) {
        draw_set_alpha(1 - _t / 90);
        draw_set_color(c_black);
        draw_rectangle(0, 0, 640, 480, false);
        draw_set_alpha(1);
    }
    draw_set_color(c_white);
}

// ---------- Fonte pixel da tela inicial (5x7, em negrito) ----------
// _s = tamanho de cada pixel na tela (2 = o pixel do jogo).
function scr_pixtext(_x, _y, _txt, _col, _s = 2, _align = fa_left, _shadow = true) {
    _txt = string_upper(_txt);
    if (_align == fa_center) _x -= scr_pixtext_width(_txt, _s) div 2;
    _x = (_x div _s) * _s;
    if (_shadow) scr_pixtext_raw(_x + _s, _y + _s, _txt, make_color_rgb(10, 6, 14), _s);
    scr_pixtext_raw(_x, _y, _txt, _col, _s);
}

function scr_pixtext_width(_txt, _s = 2) {
    var _w = 0;
    for (var i = 1; i <= string_length(_txt); i++) _w += (string_char_at(_txt, i) == " ") ? 4 * _s : 7 * _s;
    return _w - _s;
}

function scr_pixtext_raw(_x, _y, _txt, _col, _s) {
    draw_set_color(_col);
    var _cx = _x;
    for (var i = 1; i <= string_length(_txt); i++) {
        var _c = string_char_at(_txt, i);
        if (_c == " ") { _cx += 4 * _s; continue; }
        var _g = scr_pixfont_glyph(_c);
        for (var k = 0; k < string_length(_g); k++) {
            if (string_char_at(_g, k + 1) == "#") {
                var _gx = _cx + (k mod 5) * _s, _gy = _y + (k div 5) * _s;
                draw_rectangle(_gx, _gy, _gx + 2 * _s - 1, _gy + _s - 1, false);   // 2 de largura = negrito
            }
        }
        _cx += 7 * _s;
    }
}

// Chaminha (a Faísca) que marca a opção escolhida no menu
function scr_pix_flame(_x, _y, _s = 2) {
    var _g = "..#....##..###..##############.###.";
    var _cols = [make_color_rgb(255, 120, 40), make_color_rgb(255, 196, 70)];
    for (var k = 0; k < 35; k++) {
        if (string_char_at(_g, k + 1) != "#") continue;
        var _cx = k mod 5, _cy = k div 5;
        draw_set_color((_cy >= 4 && _cx >= 1 && _cx <= 3) ? _cols[1] : _cols[0]);
        draw_rectangle(_x + _cx * _s, _y + _cy * _s, _x + _cx * _s + _s - 1, _y + _cy * _s + _s - 1, false);
    }
    draw_set_color(c_white);
}

// Fonte pixel 5x7 da tela inicial (gerada pelo script do scratchpad; edite aqui mesmo se quiser).
// Cada letra: 35 caracteres, 7 linhas de 5. "#" = pixel aceso.
function scr_pixfont_glyph(_ch) {
    switch (_ch) {
        case "A": return ".###.#...##...#######...##...##...#";
        case "B": return "####.#...##...#####.#...##...#####.";
        case "C": return ".#####....#....#....#....#.....####";
        case "D": return "####.#...##...##...##...##...#####.";
        case "E": return "######....#....####.#....#....#####";
        case "F": return "######....#....####.#....#....#....";
        case "G": return ".#####....#....#..###...##...#.####";
        case "H": return "#...##...##...#######...##...##...#";
        case "I": return "#####..#....#....#....#....#..#####";
        case "J": return "..###...#....#....#....#.#..#..##..";
        case "K": return "#...##..#.#.#..##...#.#..#..#.#...#";
        case "L": return "#....#....#....#....#....#....#####";
        case "M": return "#...###.###.#.##.#.##...##...##...#";
        case "N": return "#...###..##.#.##.#.##..###...##...#";
        case "O": return ".###.#...##...##...##...##...#.###.";
        case "P": return "####.#...##...#####.#....#....#....";
        case "Q": return ".###.#...##...##...##.#.##..#..##.#";
        case "R": return "####.#...##...#####.#.#..#..#.#...#";
        case "S": return ".#####....#.....###.....#....#####.";
        case "T": return "#####..#....#....#....#....#....#..";
        case "U": return "#...##...##...##...##...##...#.###.";
        case "V": return "#...##...##...##...#.#.#..#.#...#..";
        case "W": return "#...##...##...##.#.##.#.###.###...#";
        case "X": return "#...##...#.#.#...#...#.#.#...##...#";
        case "Y": return "#...##...#.#.#...#....#....#....#..";
        case "Z": return "#####....#...#...#...#...#....#####";
        case "/": return "....#....#...#...#...#...#....#....";
        case "?": return ".###.#...#....#...#...#.........#..";
        case ".": return "................................#..";
    }
    return "";
}

// ---------------------------------------------------------------------
// Varanda: as luzinhas penduradas (fio + lâmpada). Metade pisca, metade não.
// Cada fio: [x1, y1, x2, y2, quanto ele cai no meio]. Cada lâmpada: [x, y, acesa, cor].
// Quem usa: scr_room_lights (furo no escuro) e scr_visual_varanda_luzes (o desenho).
function scr_varanda_fios() {
    var _f = [];
    for (var _x = 96; _x < 384; _x += 48) array_push(_f, [_x, 42, _x + 48, 42, 6]);
    array_push(_f, [96, 42, 38, 176, 12], [384, 42, 427, 146, 12],
        [40, 227, 172, 227, 6], [308, 227, 424, 227, 6], [184, 259, 296, 259, 5]);
    return _f;
}
function scr_varanda_lampadas() {
    var _out = [];
    var _cores = [make_color_rgb(255, 214, 120), make_color_rgb(255, 150, 90), make_color_rgb(255, 140, 190), make_color_rgb(150, 230, 190)];
    var _fios = scr_varanda_fios();
    var _n = 0;
    for (var i = 0; i < array_length(_fios); i++) {
        var _w = _fios[i];
        var _len = point_distance(_w[0], _w[1], _w[2], _w[3]);
        var _steps = max(2, floor(_len / 12));
        for (var k = 1; k < _steps; k++) {
            var _t = k / _steps;
            var _x = lerp(_w[0], _w[2], _t);
            var _y = lerp(_w[1], _w[3], _t) + _w[4] * 4 * _t * (1 - _t);
            var _pisca = (_n mod 2 == 0);
            var _on = !_pisca || ((current_time div 650 + _n * 7) mod 5 != 0);
            array_push(_out, [round(_x), round(_y) + 1, _on, _cores[_n mod 4]]);
            _n++;
        }
    }
    return _out;
}
function scr_visual_varanda_luzes() {
    var _fios = scr_varanda_fios();
    draw_set_color(make_color_rgb(30, 20, 26));
    for (var i = 0; i < array_length(_fios); i++) {
        var _w = _fios[i];
        var _px = _w[0], _py = _w[1];
        for (var k = 1; k <= 16; k++) {
            var _t = k / 16;
            var _x = lerp(_w[0], _w[2], _t);
            var _y = lerp(_w[1], _w[3], _t) + _w[4] * 4 * _t * (1 - _t);
            draw_line(round(_px), round(_py), round(_x), round(_y));
            _px = _x; _py = _y;
        }
    }
    var _b = scr_varanda_lampadas();
    for (var i = 0; i < array_length(_b); i++) {
        var _l = _b[i];
        var _c = _l[2] ? _l[3] : merge_color(_l[3], c_black, 0.6);
        draw_set_color(make_color_rgb(30, 20, 26));
        draw_point(_l[0], _l[1] - 1);
        draw_set_color(_c);
        draw_rectangle(_l[0] - 1, _l[1], _l[0], _l[1] + 1, false);
        if (_l[2]) { draw_set_color(merge_color(_c, c_white, 0.6)); draw_point(_l[0] - 1, _l[1]); }
    }
    draw_set_color(c_white);
}

// Poeira dourada saindo da roupa (quando ela bate a poeira)
function scr_fx_poeira(_x, _y) {
    if (!variable_global_exists("fx_ps") || !part_system_exists(global.fx_ps)) {
        global.fx_ps = part_system_create();
        part_system_depth(global.fx_ps, -9000);
        global.fx_pt = part_type_create();
        var _p = global.fx_pt;
        part_type_shape(_p, pt_shape_pixel);
        part_type_size(_p, 1, 1, 0, 0);
        part_type_colour2(_p, make_color_rgb(255, 222, 140), make_color_rgb(150, 120, 90));
        part_type_alpha2(_p, 1, 0);
        part_type_speed(_p, 0.3, 0.9, -0.02, 0);
        part_type_direction(_p, 20, 160, 0, 4);
        part_type_gravity(_p, 0.02, 270);
        part_type_life(_p, 25, 45);
    }
    part_particles_create(global.fx_ps, _x - 6, _y, global.fx_pt, 6);
    part_particles_create(global.fx_ps, _x + 6, _y, global.fx_pt, 6);
}
