function scr_game_load() {
    if (!file_exists("save1.sav")) return false;
    
    var _file = file_text_open_read("save1.sav");
    var _json_string = file_text_read_string(_file);
    file_text_close(_file);
    
    var _save_data = json_parse(_json_string);
    
    global.player_name = _save_data.player_name;
    global.gold = _save_data.gold;
    global.lvl = _save_data.lvl;
    global.hp = _save_data.hp;
    global.hp_max = _save_data.hp_max;
    global.sanity = _save_data.sanity;
    global.inventory = _save_data.inventory;
    global.flags = _save_data.flags;
    
    global.next_room_x = _save_data.save_x;
    global.next_room_y = _save_data.save_y;
    room_goto(_save_data.save_room);
    
    return true;
}