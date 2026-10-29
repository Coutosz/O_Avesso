var _x1 = bbox_left, _y1 = bbox_top, _x2 = bbox_right, _y2 = bbox_bottom;
av_rect(_x1, _y1, _x2, _y2, make_color_rgb(13, 12, 26));
av_rect(_x1 + 3, _y1 + 3, _x2 - 3, _y2 - 3, make_color_rgb(23, 20, 39));
av_line(_x1, _y1, _x1, _y2, make_color_rgb(172, 130, 92));
av_line(_x2, _y1, _x2, _y2, make_color_rgb(172, 130, 92));
for (var i = 0; i < 8; i++) {
    var _px = _x1 + 5 + (i * 17) mod max(1, _x2 - _x1 - 10);
    var _py = _y1 + 4 + (i * 31) mod max(1, _y2 - _y1 - 8);
    av_star(_px, _py, make_color_rgb(63, 50, 86), 0);
}
if (bridged) {
    var _cy = round((_y1 + _y2) / 2);
    av_rect(_x1, _cy - 14, _x2, _cy + 14, make_color_rgb(173, 117, 72));
    for (var _px = _x1; _px < _x2; _px += 8) {
        av_rect(_px + 1, _cy - 13, min(_px + 6, _x2), _cy + 13, make_color_rgb(230, 180, 100));
        av_line(_px + 2, _cy - 12, min(_px + 5, _x2), _cy - 12, make_color_rgb(255, 233, 160));
    }
    av_line(_x1, _cy - 15, _x2, _cy - 15, make_color_rgb(255, 218, 131));
    av_line(_x1, _cy + 15, _x2, _cy + 15, make_color_rgb(255, 218, 131));
}
draw_set_color(c_white);
