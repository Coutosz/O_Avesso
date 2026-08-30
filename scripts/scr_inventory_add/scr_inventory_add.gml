function scr_inventory_add(_item_name) {
    for (var i = 0; i < array_length(global.inventory); i++) {
        if (global.inventory[i] == "") {
            global.inventory[i] = _item_name;
            return true; // conseguiu adicionar
        }
    }
    return false; // inventário cheio, nenhum slot vazio
}