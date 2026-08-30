function scr_fade_to_room(_room, _x, _y) {
    if (global.fade_state != "none") exit;
    
    global.fade_target_room = _room;
    global.fade_target_x = _x;
    global.fade_target_y = _y;
    global.fade_state = "out";
}