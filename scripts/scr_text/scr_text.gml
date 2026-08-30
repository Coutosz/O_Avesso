function scr_text(_key) {
    if (!variable_struct_exists(global.text_db, _key)) {
        return "[TEXTO FALTANDO: " + _key + "]"; // erro visível, fácil de notar durante teste
    }
    
    var _entry = global.text_db[$ _key];
    
    if (variable_struct_exists(_entry, global.language)) {
        return _entry[$ global.language];
    }
    
    return _entry[$ "pt"]; // se a tradução em inglês ainda não existir, cai pro português
}