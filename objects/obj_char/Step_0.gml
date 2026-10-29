// Primeiro frame: completa o que o Creation Code não definiu
if (!setup_done) {
    setup_done = true;
    if (who != "") {
        if (sprite_index == -1 || sprite_index == spr_npc) sprite_index = scr_char_sprite(who);
        if (event == "") event = "talk_" + who;
    }
}

bob += 0.08;
depth = -y;

// Passos: só quem tem desenho de caminhada (5 frames)
if (image_number >= 5) {
    image_speed = 0;
    var _d = point_distance(x, y, anim_x, anim_y);
    if (_d > 12) _d = 0;   // teleporte
    anim_x = x; anim_y = y;
    if (_d > 0.05) {
        anim_dist += _d;
        anim_idle = 0;
        image_index = 1 + (floor(anim_dist / 6) mod 4);
    } else if (++anim_idle > 3) {
        image_index = 0;
        anim_dist = 0;
    }
}
