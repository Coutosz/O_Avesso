
if (keyboard_check_pressed(ord("X"))) {
    var _save_point = instance_place(x, y, obj_save);
    if (_save_point != noone) {
        scr_game_save();
    }
}