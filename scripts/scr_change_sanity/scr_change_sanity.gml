function scr_change_sanity(_amount) {
    global.sanity += _amount;
    global.sanity = clamp(global.sanity, 0, global.sanity_max);
    
    if (global.sanity <= 0) {
        
    }
}