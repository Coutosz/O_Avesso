function scr_game_save() {
    var _save_data = {
        save_room: room,
        save_x: obj_player.x,
        save_y: obj_player.y,
        player_name: global.player_name,
        gold: global.gold,
        lvl: global.lvl,
        hp: global.hp,
        hp_max: global.hp_max,
        sanity: global.sanity,
        inventory: global.inventory,
        flags: global.flags
    };
    
    var _json_string = json_stringify(_save_data);
    var _file = file_text_open_write("save1.sav");
    file_text_write_string(_file, _json_string);
    file_text_close(_file);
}