function scr_game_save() {
    var _save_data = {
        save_room: room_get_name(room), // salva pelo nome: não quebra quando o projeto ganha salas novas
        save_x: obj_player.x,
        save_y: obj_player.y,
        player_name: global.player_name,
        gold: global.gold,
        lvl: global.lvl,
        hp: global.hp,
        hp_max: global.hp_max,
        sanity: global.sanity,
        inventory: global.inventory,
        flags: global.flags,
        party: global.party
    };

    var _json_string = json_stringify(_save_data);
    var _file = file_text_open_write("save1.sav");
    file_text_write_string(_file, _json_string);
    file_text_close(_file);
}
