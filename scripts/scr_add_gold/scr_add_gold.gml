function scr_add_gold(_amount) {
    global.gold += _amount;
    if (global.gold < 0) global.gold = 0; // nunca fica negativo
}