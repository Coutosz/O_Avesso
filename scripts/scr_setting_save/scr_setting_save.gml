function scr_settings_save() {
    var _data = {
        language: global.language,
        fullscreen: global.fullscreen_enabled,
        seen_instructions: global.seen_instructions
    };
    
    var _json_string = json_stringify(_data);
    var _file = file_text_open_write("settings.sav");
    file_text_write_string(_file, _json_string);
    file_text_close(_file);
}