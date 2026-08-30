function scr_settings_load() {
    if (!file_exists("settings.sav")) {
        global.language = "pt";
        global.fullscreen_enabled = false;
        global.seen_instructions = false;
        return;
    }
    
    var _file = file_text_open_read("settings.sav");
    var _json_string = file_text_read_string(_file);
    file_text_close(_file);
    
    var _data = json_parse(_json_string);
    global.language = _data.language;
    global.fullscreen_enabled = _data.fullscreen;
    global.seen_instructions = _data.seen_instructions;
}