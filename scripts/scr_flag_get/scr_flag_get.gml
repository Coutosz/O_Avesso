function scr_flag_get(_name) {
    if (variable_struct_exists(global.flags, _name)) {
        return global.flags[$ _name];
    }
    return false; // se a flag nunca foi definida, o padrão é "não aconteceu"
}