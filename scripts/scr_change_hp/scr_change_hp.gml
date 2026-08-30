function scr_change_hp(_amount) {
    global.hp += _amount;
    global.hp = clamp(global.hp, 0, global.hp_max);
}