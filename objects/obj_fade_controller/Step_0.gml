switch (global.fade_state) {
    case "out":
        global.fade_alpha += global.fade_speed;
        if (global.fade_alpha >= 1) {
            global.fade_alpha = 1;
            
            global.next_room_x = global.fade_target_x;
            global.next_room_y = global.fade_target_y;
            
            room_goto(global.fade_target_room);
            global.fade_state = "in";
        }
        break;
        
    case "in":
        global.fade_alpha -= global.fade_speed;
        if (global.fade_alpha <= 0) {
            global.fade_alpha = 0;
            global.fade_state = "none";
        }
        break;
}